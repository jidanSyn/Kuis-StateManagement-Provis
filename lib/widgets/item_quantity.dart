import 'package:flutter/material.dart';
import 'package:kuis_statemanagement/providers/item_quantity_notifier.dart';
import 'package:provider/provider.dart';

class ItemQuantity extends StatelessWidget {
  final int item_id;
  ItemQuantity({Key? key, required this.item_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemQuantityNotifier>(
      builder: (context, quantityNotifier, _) {
        int quantity = quantityNotifier.getQuantity(item_id);
        return Row(
          children: [
            IconButton(
              onPressed: () {
                quantityNotifier.decrementQuantity(item_id);
              },
              icon: Icon(Icons.remove_circle_outline_outlined),
            ),
            SizedBox(width: 5),
            Text(
              "$quantity",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(width: 5),
            IconButton(
              onPressed: () {
                quantityNotifier.incrementQuantity(item_id);
              },
              icon: Icon(Icons.add_circle_outline_outlined),
            ),
          ],
        );
      },
    );
  }
}
