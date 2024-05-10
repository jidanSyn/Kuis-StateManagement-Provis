import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuis_statemanagement/pages/keranjang_page.dart';
import 'package:kuis_statemanagement/widgets/daftar_makanan.dart';
import 'package:badges/badges.dart' as badges;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Makanan"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: Offset(0, 3))
                  ]),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    Container(
                      height: 50,
                      width: 300,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Cari Makanan",
                              border: InputBorder.none),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 10),
            child: Text(
              "Daftar Makanan",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          DaftarMakanan(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => KeranjangPage()),
            );
          },
          child: badges.Badge(
            badgeContent: Text(
              '3',
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
            child: Icon(Icons.shopping_cart),
          )),
    );
  }
}
