<<<<<<< HEAD
  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
import 'package:kuis_statemanagement/providers/cart_provider.dart';
=======
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
>>>>>>> ab77e945ce686286528655e1c701aeca235efd3f
import 'package:kuis_statemanagement/providers/item_quantity_notifier.dart';
import 'package:kuis_statemanagement/providers/user_provider.dart';
import 'package:kuis_statemanagement/widgets/item_quantity.dart';
import 'package:provider/provider.dart';
import 'package:kuis_statemanagement/pages/keranjang_page.dart';
import 'package:badges/badges.dart' as badges;
import 'package:kuis_statemanagement/providers/auth_provider.dart';
import 'package:kuis_statemanagement/widgets/daftar_makanan.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

<<<<<<< HEAD
    @override
    Widget build(BuildContext context) {
      final authProvider = Provider.of<AuthProvider>(context,
          listen: false); // Access AuthProvider
      final userProvider = Provider.of<UserProvider>(context,
          listen: false); // Access AuthProvider
      final cartProvider = Provider.of<CartProvider>(context,
          listen: false);

      return FutureBuilder<void>(
        future: Future.wait([
          userProvider.fetchUser(authProvider.userId, authProvider.token),
          cartProvider.fetchUserCart(authProvider.userId, authProvider.token),

        ]),
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
=======
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context,
        listen: false); // Access AuthProvider
    final userProvider = Provider.of<UserProvider>(context,
        listen: false); // Access AuthProvider

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
>>>>>>> ab77e945ce686286528655e1c701aeca235efd3f
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
<<<<<<< HEAD
                  DaftarMakanan(userId: userProvider.user!.id,),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                  onPressed: () async {
                    // i want to print item quantities here
                      await Provider.of<CartProvider>(context, listen: false).postAllItemsToCart(userProvider.user!.id, Provider.of<AuthProvider>(context, listen: false).token);


                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => KeranjangPage(
                                  userId: userProvider.user!.id,
                                )),
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
        },
      );
    }
=======
                ),
                DaftarMakanan(),
              ],
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  // i want to print item quantities here
                  await Provider.of<ItemQuantityNotifier>(context,
                          listen: false)
                      .getAllItemQuantities();
                  // print(itemQuantities);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => KeranjangPage(
                              userId: userProvider.user!.id,
                            )),
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
      },
    );
>>>>>>> ab77e945ce686286528655e1c701aeca235efd3f
  }
}
