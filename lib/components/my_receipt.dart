import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:provider/provider.dart';

class MyReceipt extends StatelessWidget {
  const MyReceipt({super.key});

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.inversePrimary;

    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 50),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Thank You for your order ",
              style: TextStyle(color: textColor),
            ),
            SizedBox(height: 25),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              padding: EdgeInsets.all(25),
              child: Consumer<Restaurant>(
                builder:
                    (context, restaurant, child) => Text(
                      restaurant.displayCartReceipt(),
                      style: TextStyle(color: textColor),
                    ),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              "Estimated delievery time : 4:02 PM",
              style: TextStyle(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
