import 'package:flutter/material.dart';
import 'package:kuis_statemanagement/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:kuis_statemanagement/providers/status_provider.dart';
import 'package:kuis_statemanagement/pages/home_page.dart';
import 'package:kuis_statemanagement/providers/cart_provider.dart';

class StatusPesananPage extends StatelessWidget {
  final int userId; // Mendefinisikan userId

  const StatusPesananPage({Key? key, required this.userId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Mendapatkan instance dari StatusProvider
    final statusProvider = Provider.of<StatusProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return FutureBuilder<void>(
      future: statusProvider.fetchStatus(
          userId, Provider.of<AuthProvider>(context, listen: false).token),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Status Pesanan"),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
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
              builder: (context, statusProvider, child) {
                if (statusProvider.statusData == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  String statusText = statusProvider.statusData!.status;

                  // Menambahkan pengecekan untuk status "belum_bayar"
                  if (statusText == 'belum_bayar') {
                    return Center(
                      // Menggunakan Center untuk menengahkan Column
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Anda Belum Melakukan Pembayaran',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              // Mengubah status menjadi "pesanan_diterima"
                              await statusProvider.postPembayaran(
                                userId,
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .token,
                              );
                            },
                            child: Text('Lakukan Pembayaran'),
                          ),
                        ],
                      ),
                    );
                  }

                  // Menambahkan pengecekan untuk status "sudah_bayar"
                  else if (statusText == 'sudah_bayar') {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Anda Sudah Bayar',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              // Mengubah status menjadi "pesanan_diterima"
                              await statusProvider.postPenjualTerima(
                                  userId,
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .token);
                            },
                            child: Text('Pesanan Diterima Restoran'),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () async {
                              // Mengubah status menjadi "pesanan_ditolak"
                              await statusProvider.postPenjualTolak(
                                  userId,
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .token);
                            },
                            child: Text('Pesanan Ditolak Restoran'),
                          ),
                        ],
                      ),
                    );
                  }
                  // Menambahkan pengecekan untuk status "pesanan_diterima" dan "pesanan_ditolak"
                  else if (statusText == 'pesanan_diterima') {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Anda Sudah Bayar dan Pesanan Diterima Restoran',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              // Mengubah status menjadi "pesanan_diterima"
                              await statusProvider.postDiantar(
                                  userId,
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .token);
                            },
                            child: Text('Antar Makanan'),
                          ),
                        ],
                      ),
                    );
                  } else if (statusText == 'pesanaan_diantar') {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Pesanan Sedang Diantar Ke Lokasi Anda',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              // Mengubah status menjadi "pesanan_diterima"
                              await statusProvider.postDiterima(
                                  userId,
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .token);
                            },
                            child: Text('Selesaikan Pesanan'),
                          ),
                        ],
                      ),
                    );
                  } else if (statusText == 'pesanan_selesai') {
                    // Menambahkan penundaan 3 detik sebelum kembali ke halaman utama
                    Future.delayed(Duration(seconds: 3), () async {
                      await statusProvider.postHarapBayar(
                        userId,
                        Provider.of<AuthProvider>(context, listen: false).token,
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    });

                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Pesanan Selesai Kembali Ke Halaman Awal untuk order',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Kembali ke Halaman Awal dalam 3 detik...',
                            style: TextStyle(
                                fontSize: 14, fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    );
                  } else if (statusText == 'pesanan_ditolak') {
                    // Menambahkan penundaan 3 detik sebelum kembali ke halaman utama
                    Future.delayed(Duration(seconds: 3), () async {
                      await statusProvider.postHarapBayar(
                        userId,
                        Provider.of<AuthProvider>(context, listen: false).token,
                      );
                      await cartProvider.deleteAllItemCart(
                        userId,
                        Provider.of<AuthProvider>(context, listen: false).token,
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    });

                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Pesanan Ditolak Restoran Kembali Ke Halaman Awal untuk order Uang Dikembalikan',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Kembali ke Halaman Awal dalam 3 detik...',
                            style: TextStyle(
                                fontSize: 14, fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    );
                  }

                  // Jika status bukan "belum_bayar", "sudah_bayar", "pesanan_diterima", atau "pesanan_ditolak"
                  else {
                    return ListTile(
                      title: Text('$statusText'),
                    );
                  }
                }
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // Refresh status
                statusProvider.fetchStatus(userId,
                    Provider.of<AuthProvider>(context, listen: false).token);
              },
              child: Icon(Icons.refresh),
            ),
          );
        }
      },
    );
  }
}
