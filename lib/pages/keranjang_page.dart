import 'package:flutter/material.dart';
import 'package:kuis_statemanagement/widgets/daftar_makanan.dart';
import 'package:kuis_statemanagement/pages/status_pesanan_page.dart';
// import 'package:kuis_statemanagement/pages/home_page.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({Key? key}) : super(key: key);

  @override
  _KeranjangPageState createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  bool _showCheckoutButton = true;

  void _toggleCheckoutButton() {
    setState(() {
      _showCheckoutButton = !_showCheckoutButton;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool showCheckedButton =
        true; // Tentukan apakah tombol Checkout terlihat atau tidak

    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: DaftarMakanan(
                showButtons: false,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Total: Rp. 200.000'),
              _showCheckoutButton
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(150, 50),
                        backgroundColor: Colors.deepPurple[100],
                      ),
                      onPressed: () {
                        // Simulasikan tindakan pembayaran
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(height: 16.0),
                                  Text('Pesanan Sedang Dibuat'),
                                ],
                              ),
                            );
                          },
                        );

                        // Tambahkan logika pembayaran di sini

                        // Setelah pembayaran selesai, tutup dialog loading dan kosongkan keranjang
                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.of(context, rootNavigator: true).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Pesanan Berhasil Dibuat'),
                            ),
                          );
                          // Setelah Checkout, ganti menjadi tombol "Lihat Detail Pesanan"
                          _toggleCheckoutButton();
                        });
                      },
                      child: const Text('Checkout'),
                    )
                  : TextButton(
                      onPressed: () {
                        // Navigasi ke halaman "StatusPesanan"
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StatusPesananPage()),
                        );
                      },
                      child: Text(
                        'Lihat Detail Pesanan',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
