import 'package:flutter/material.dart';
import 'package:kuis_statemanagement/providers/auth_provider.dart';
import 'package:kuis_statemanagement/providers/item_provider.dart';
import 'package:kuis_statemanagement/models/item.dart';
import 'package:kuis_statemanagement/providers/item_quantity_notifier.dart';
import 'package:kuis_statemanagement/widgets/item_quantity.dart';
import 'package:provider/provider.dart';
import 'package:kuis_statemanagement/globals.dart';

class DaftarMakanan extends StatelessWidget {
  final bool showButtons;
  const DaftarMakanan({Key? key, this.showButtons = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    print("build daftar makanan");

    final List<Item> items = Provider.of<ItemProvider>(context).items;
    final token = Provider.of<AuthProvider>(context).token;

    Map<int, int> itemQuantities = Provider.of<ItemQuantityNotifier>(context, listen: false).getAllItemQuantities();




    if (items.isEmpty) {
      Provider.of<ItemProvider>(context, listen: false).fetchItems(token);
    }



    return Consumer<ItemProvider>(
      builder: (context, itemModel, _) {
        if (items.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container(
            height:
                MediaQuery.of(context).size.height * 0.8, // Set a finite height
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                if(!showButtons && itemQuantities[item.id] == null) {
                  return SizedBox(width: 0, height: 0,);
                }
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 3),
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
                              Container(
                                alignment: Alignment.center,
                                child: Image.network(
                                  api_url + "/items_image/${item.id}",
                                  headers: {'Authorization': 'Bearer $token'},
                                ),
                                height: 120,
                                width: 150,
                              ),
                              Container(
                                width: 190,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "${item.title}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${item.description}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "\Rp ${item.price}",
                                          style: TextStyle(
                                            fontSize: 17,
                                          ),
                                        ),

                                        showButtons ?
                                        ItemQuantity(item_id: item.id)
                                          : // keranjang
                                          Row(
                                            children: [

                                              Text(
                                                "${itemQuantities[item.id]}",  // counter
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 15),
                                              ),

                                              SizedBox(
                                                width: 5,
                                              ),

                                              IconButton(
                                                onPressed: () {}, // add item
                                                icon: Icon(Icons.remove_circle_outline_outlined),

                                              )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
