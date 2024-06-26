import 'package:flutter/material.dart';
import 'package:kuis_statemanagement/globals.dart';
import 'package:kuis_statemanagement/models/item.dart';
import 'package:kuis_statemanagement/providers/auth_provider.dart';
import 'package:kuis_statemanagement/providers/cart_provider.dart';
import 'package:kuis_statemanagement/providers/item_provider.dart';
import 'package:kuis_statemanagement/providers/item_quantity_notifier.dart';
import 'package:kuis_statemanagement/widgets/daftar_makanan.dart';
import 'package:kuis_statemanagement/providers/status_provider.dart';
import 'package:kuis_statemanagement/pages/status_pesanan_page.dart';
import 'package:provider/provider.dart';

class KeranjangPage extends StatelessWidget {
  final int userId; // Mendefinisikan userId

  const KeranjangPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<int, int> itemQuantities = Provider.of<ItemQuantityNotifier>(context, listen: false).getAllItemQuantities();
    List<Item> items = Provider.of<ItemProvider>(context, listen: false).items;
    int totalPrice = 0;

    for(var entry in itemQuantities.entries) {
      Item current = items.firstWhere((element) => element.id == entry.key);
      totalPrice = totalPrice + (entry.value * current.price);
    }


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
                userId: userId,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Consumer<StatusProvider>(
          builder: (context, statusProvider, _) => Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: <Widget>[
                Text('Total: ${formatCurrency(totalPrice)}'),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 50),
                    backgroundColor: Colors.deepPurple[100],
                  ),
                  onPressed: () async {

                    Map<int, int> itemQuantities =  await Provider.of<ItemQuantityNotifier>(context, listen: false).getAllItemQuantities();
                    bool noneSelected = itemQuantities.values.every((value) => value == 0);
                    print(itemQuantities);
                    if(noneSelected) {
                      // Show a SnackBar at the bottom of the screen
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please select at least one item before proceeding.'),
                        ),
                      );

                    } else {
                      await statusProvider.postHarapBayar(userId, Provider.of<AuthProvider>(context, listen: false).token);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => StatusPesananPage(
                            userId: userId,
                          ),
                        ),
                      );

                    }


                  },
                  child: const Text('Checkout'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
