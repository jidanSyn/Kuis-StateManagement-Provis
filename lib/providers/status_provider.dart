import 'dart:convert';
import 'package:kuis_statemanagement/globals.dart';
import 'package:flutter/material.dart';
import 'package:kuis_statemanagement/models/status.dart';
import 'package:http/http.dart' as http;

class StatusProvider with ChangeNotifier {
  String url = api_url;
  List<Status> _statusProvider = [];

  List<Status> get statusData => _statusProvider;

  // Fetch status
  Future<void> fetchStatus(int userId) async {
    try {
      final response = await http.get(Uri.parse('$url/get_status/$userId'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        _statusProvider = [Status.fromJson(jsonData)];
        notifyListeners();
      } else {
        throw Exception('Failed to load status');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Post status for each specific operation
  Future<void> postHarapBayar(int userId) async {
    await _postStatus(userId, 'set_status_harap_bayar');
  }

  Future<void> postDiantar(int userId) async {
    await _postStatus(userId, 'set_status_diantar');
  }

  Future<void> postPembayaran(int userId) async {
    await _postStatus(userId, 'pembayaran');
  }

  Future<void> postPenjualTerima(int userId) async {
    await _postStatus(userId, 'set_status_penjual_terima');
  }

  Future<void> postPenjualTolak(int userId) async {
    await _postStatus(userId, 'set_status_penjual_tolak');
  }

  Future<void> postDiterima(int userId) async {
    await _postStatus(userId, 'set_status_diterima');
  }

  Future<void> _postStatus(int userId, String endpoint) async {
    try {
      final response = await http.post(
        Uri.parse('$url/$endpoint/$userId'),
        headers: {'Content-Type': 'application/json'},
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
