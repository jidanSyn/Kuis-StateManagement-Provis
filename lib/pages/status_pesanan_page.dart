import 'package:flutter/material.dart';

// Model untuk status pesanan
class StatusPesanan {
  final String status;

  StatusPesanan({required this.status});
}

// Contoh data status pesanan
List<StatusPesanan> statusPesananList = [
  StatusPesanan(status: 'belum bayar'),
  StatusPesanan(status: 'sudah bayar'),
  StatusPesanan(status: 'pesanan diterima'),
  StatusPesanan(status: 'pesanan diantar'),
  StatusPesanan(status: 'pesanan selesai'),
];

class StatusPesananPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status Pesanan'),
      ),
      body: ListView.builder(
        itemCount: statusPesananList.length,
        itemBuilder: (context, index) {
          final statusPesanan = statusPesananList[index];
          return ListTile(
            title: Text('${statusPesanan.status}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Update Status Pesanan
          statusPesananList = [
            StatusPesanan(status: 'belum bayar'),
            StatusPesanan(status: 'sudah bayar'),
            StatusPesanan(status: 'pesanan diterima'),
            StatusPesanan(status: 'pesanan diantar'),
            StatusPesanan(status: 'pesanan selesai'),
          ];
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
