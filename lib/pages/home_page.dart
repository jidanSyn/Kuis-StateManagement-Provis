import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuis_statemanagement/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'package:kuis_statemanagement/providers/auth_provider.dart';
import 'package:kuis_statemanagement/widgets/daftar_makanan.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false); // Access AuthProvider
    final userProvider = Provider.of<UserProvider>(context, listen: false); // Access AuthProvider

    return FutureBuilder<void>(
      future: userProvider.fetchUser(authProvider.userId, authProvider.token),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // If the future is still waiting, show a loading indicator
          return Scaffold(
            appBar: AppBar(
              title: Text("Daftar Makanan"),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          // If there was an error, handle it appropriately
          return Scaffold(
            appBar: AppBar(
              title: Text("Daftar Makanan"),
            ),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          // Once the future has completed, build the UI with fetched user details
          return Scaffold(
            appBar: AppBar(
              title: Text("Daftar Makanan"),
            ),
            body: ListView(
              children: [
                Text('Hello, ${userProvider.user!.username}!'),
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
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Icon(Icons.search),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Cari Makanan",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
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
          );
        }
      },
    );
  }

}
