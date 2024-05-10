import 'package:flutter/material.dart';
import 'package:kuis_statemanagement/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:kuis_statemanagement/providers/status_provider.dart';

class StatusPesananPage extends StatelessWidget {
  final int userId; // Mendefinisikan userId

  const StatusPesananPage({Key? key, required this.userId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Mendapatkan instance dari StatusProvider
    final statusProvider = Provider.of<StatusProvider>(context, listen: false);


    return FutureBuilder<void>(
      future: statusProvider.fetchStatus(userId, Provider.of<AuthProvider>(context, listen: false).token),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              appBar: AppBar(
                title: Text("Status Pesanana"),
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
        }
        else if(snapshot.hasError) {

          return Scaffold(
              appBar: AppBar(
                title: Text("Status Pesanan"),
              ),
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );


        } else {
          return Scaffold(
        appBar: AppBar(
          title: Text('Status Pesanan'),
        ),
        body: Consumer<StatusProvider>(

          builder:(context, value, child) {

            if(statusProvider.statusData == null) {
              return Center(
            child: CircularProgressIndicator(),
          );
            } else {
              return ListTile(
                title: Text('${statusProvider.statusData!.status}'),
              );
            }


          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Mendapatkan instance dari StatusProvider
            final statusProvider =
                Provider.of<StatusProvider>(context, listen: false);
            await statusProvider.fetchStatus(userId, Provider.of<AuthProvider>(context, listen: false).token);
            if (statusProvider.statusData!.status != null) {
              if (statusProvider.statusData!.status == 'pesanan diterima') {
                statusProvider.postDiantar(userId, Provider.of<AuthProvider>(context, listen: false).token);
              } else if (statusProvider.statusData!.status ==
                  'pesanan sedang diantarkan') {
                statusProvider.postDiterima(userId, Provider.of<AuthProvider>(context, listen: false).token);
              }
            }
          },
          child: Icon(Icons.refresh),
        ),
      );
        }
      },
    );
  }
}
