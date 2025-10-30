import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:provider/provider.dart';

class MyCurrentLocation extends StatelessWidget {
  const MyCurrentLocation({super.key});

  void openLocationSearchBox(BuildContext context) {
    final textEditingController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              "Your loaction",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            content: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: "Enter address..",
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            actions: [
              // cancel button
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  textEditingController.clear();
                },
                child: Text(
                  "cancel",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),

              // save button
              MaterialButton(
                onPressed: () {
                  // update delivery Address
                  String newAddress = textEditingController.text;
                  context.read<Restaurant>().updateDeliveryAddress(newAddress);

                  Navigator.pop(context);
                  textEditingController.clear();
                },
                child: Text(
                  "save",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 5, 25, 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deliver now",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          GestureDetector(
            onTap: () => openLocationSearchBox(context),
            child: Row(
              children: [
                // address
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Consumer<Restaurant>(
                    builder:
                        (context, restaurant, child) => Text(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          restaurant.deliveryAddress,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  ),
                ),

                // drop down menu
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
