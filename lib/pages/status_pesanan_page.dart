import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kuis_statemanagement/providers/status_provider.dart';

class StatusPesananPage extends StatelessWidget {
  final int userId; // Mendefinisikan userId

  const StatusPesananPage({Key? key, required this.userId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Mendapatkan instance dari StatusProvider
    final statusProvider = Provider.of<StatusProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Status Pesanan'),
      ),
      body: Consumer<StatusProvider>(
        builder: (context, statusProvider, _) => ListView.builder(
          itemCount: statusProvider.statusData.length,
          itemBuilder: (context, index) {
            final statusPesanan = statusProvider.statusData[index];
            return ListTile(
              title: Text('${statusPesanan.status}'),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Mendapatkan instance dari StatusProvider
          final statusProvider =
              Provider.of<StatusProvider>(context, listen: false);
          await statusProvider.fetchStatus(userId);
          if (statusProvider.statusData.isNotEmpty) {
            if (statusProvider.statusData[0].status == 'pesanan diterima') {
              statusProvider.postDiantar(userId);
            } else if (statusProvider.statusData[0].status ==
                'pesanan sedang diantarkan') {
              statusProvider.postDiterima(userId);
            }
          }
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
