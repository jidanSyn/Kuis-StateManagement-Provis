import 'package:flutter/material.dart';

class DaftarMakanan extends StatelessWidget {
  const DaftarMakanan({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: 380,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.network("images/gambar_beruang.jpg"),
                        height: 120,
                        width: 150,
                      ),
                    ),
                    Container(
                      width: 190,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Title",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "jsfjksfbsjkbksjbkassdhasbhfasbjfabhsjabfhjabshjbsajbfasdasdasdasfasfasfsafasfasfasfafasaasadadasdasdasdasdasdasdadsadasdasdasdasdasdassdf kwgefueqvfvfevfgjqfvgjfjeav jvasdFKWEWVFUWEFVWUGEVFGWVFGYWV",
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w300),
                          ),
                          Text(
                            "\$Price",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
