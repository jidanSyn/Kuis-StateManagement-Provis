import 'dart:convert';
import 'package:kuis_statemanagement/globals.dart';
import 'package:flutter/material.dart';
import 'package:kuis_statemanagement/models/status.dart';
import 'package:http/http.dart' as http;

class StatusProvider with ChangeNotifier {
  String url = api_url;
  Status? _statusProvider;

  Status? get statusData => _statusProvider;

  // Fetch status
  Future<void> fetchStatus(int userId, String? token) async {
    try {
      final response = await http.get(Uri.parse('$url/get_status/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }
       );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        _statusProvider = Status.fromJson(jsonData['status']);
        print("fetch status");
        print(_statusProvider);
        notifyListeners();
      } else {
        throw Exception('Failed to load status');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Post status for each specific operation
  Future<void> postHarapBayar(int userId, String? token) async {
    await _postStatus(userId, token, 'set_status_harap_bayar');
  }

  Future<void> postDiantar(int userId, String? token) async {
    await _postStatus(userId, token, 'set_status_diantar');
  }

  Future<void> postPembayaran(int userId, String? token) async {
    await _postStatus(userId, token, 'pembayaran');
  }

  Future<void> postPenjualTerima(int userId, String? token) async {
    await _postStatus(userId, token, 'set_status_penjual_terima');
  }

  Future<void> postPenjualTolak(int userId, String? token) async {
    await _postStatus(userId, token, 'set_status_penjual_tolak');
  }

  Future<void> postDiterima(int userId, String? token) async {
    await _postStatus(userId, token, 'set_status_diterima');
  }

  Future<void> _postStatus(int userId, String? token, String endpoint) async {
    try {
      final response = await http.post(
        Uri.parse('$url/$endpoint/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          },
      );

      if (response.statusCode == 200) {
        notifyListeners();
      } else {
        throw Exception('Failed to post status');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
