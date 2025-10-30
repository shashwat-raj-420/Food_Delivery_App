import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/cart_item.dart';
import 'package:food_delivery_app/models/food.dart';
import 'package:intl/intl.dart';

class Restaurant extends ChangeNotifier {
  //list of food menu
  final List<Food> _menu = [
    // burgers
    Food(
      name: "classic 1",
      description:
          "cheese burger with a jucy patty with melted chedder on top with lettuce and tomato",
      imagePath: "lib/images_food_app/burger/burger_1.png",
      price: 100,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra cheese", price: 0.99),
        Addon(name: "baccon", price: 1.99),
        Addon(name: "Avacado", price: 2.99),
      ],
    ),
    Food(
      name: "classic 2",
      description:
          "cheese burger with a jucy patty with melted chedder on top with lettuce and tomato",
      imagePath: "lib/images_food_app/burger/burger_2.png",
      price: 100,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra cheese", price: 0.99),
        Addon(name: "baccon", price: 1.99),
        Addon(name: "Avacado", price: 2.99),
      ],
    ),
    Food(
      name: "classic 3",
      description:
          "cheese burger with a jucy patty with melted chedder on top with lettuce and tomato",
      imagePath: "lib/images_food_app/burger/burger_3.png",
      price: 100,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra cheese", price: 0.99),
        Addon(name: "baccon", price: 1.99),
        Addon(name: "Avacado", price: 2.99),
      ],
    ),
    Food(
      name: "classic 4",
      description:
          "cheese burger with a jucy patty with melted chedder on top with lettuce and tomato",
      imagePath: "lib/images_food_app/burger/burger_4.png",
      price: 100,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra cheese", price: 0.99),
        Addon(name: "baccon", price: 1.99),
        Addon(name: "Avacado", price: 2.99),
      ],
    ),

    // salad
    Food(
      name: "classic salad",
      description:
          "Fresh salad with freshly harvested veggis which are locally sorced",
      imagePath: "lib/images_food_app/salad/salad_1.png",
      price: 100,
      category: FoodCategory.salads,
      availableAddons: [
        Addon(name: "Extra cheese", price: 0.99),
        Addon(name: "baccon", price: 1.99),
        Addon(name: "Avacado", price: 2.99),
      ],
    ),

    // sides
    Food(
      name: "classic side",
      description: "side for any thing perfect for every occasion",
      imagePath: "lib/images_food_app/side/side_1.png",
      price: 100,
      category: FoodCategory.sides,
      availableAddons: [
        Addon(name: "Extra cheese", price: 0.99),
        Addon(name: "baccon", price: 1.99),
        Addon(name: "Avacado", price: 2.99),
      ],
    ),

    // desserts
    Food(
      name: "classic dessert",
      description: "melts in the mouth from just the slightest taste",
      imagePath: "lib/images_food_app/dessert/dessert_1.png",
      price: 100,
      category: FoodCategory.desserts,
      availableAddons: [
        Addon(name: "Extra sweet", price: 0.99),
        Addon(name: "chocolate", price: 1.99),
      ],
    ),

    // drinks
    Food(
      name: "classic drink 1",
      description: "refressing and cool helps you calm down",
      imagePath: "lib/images_food_app/drink/drink_1.png",
      price: 100,
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "Extra ice", price: 0.99),
        Addon(name: "syrup", price: 1.99),
      ],
    ),
    Food(
      name: "classic drink 2",
      description: "refressing and cool helps you calm down",
      imagePath: "lib/images_food_app/drink/drink_2.png",
      price: 100,
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "Extra ice", price: 0.99),
        Addon(name: "syrup", price: 1.99),
      ],
    ),
    Food(
      name: "classic drink 3",
      description: "refressing and cool helps you calm down",
      imagePath: "lib/images_food_app/drink/drink_3.png",
      price: 100,
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "Extra ice", price: 0.99),
        Addon(name: "syrup", price: 1.99),
      ],
    ),
    Food(
      name: "classic drink 4",
      description: "refressing and cool helps you calm down",
      imagePath: "lib/images_food_app/drink/drink_4.png",
      price: 100,
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "Extra ice", price: 0.99),
        Addon(name: "syrup", price: 1.99),
      ],
    ),
  ];

  // user cart
  final List<CartItem> _cart = [];

  // delivery address (which users can manually edit)
  String _deliveryAddress = '99 Hollywood Bly';

  /*
   *  G E T T E R S
   */

  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;
  String get deliveryAddress => _deliveryAddress;

  /*
   *  O P E R A T I O N S
   */

  // add to the cart
  void addToCart(Food food, List<Addon> selectedAddons) {
    // see if there is a cart item already with the same food and selected addons
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      // check if the food items are the same
      bool isSameFood = item.food == food;

      //check if the list of selected addons are the same
      bool isSameAddons = ListEquality().equals(
        item.selectedAddons,
        selectedAddons,
      );
      return isSameFood && isSameAddons;
    });

    // if item already exists, just increase the quantity
    if (cartItem != null) {
      cartItem.quantity++;
    }
    // otherwise, add a new item to the cart
    else {
      _cart.add(CartItem(food: food, selectedAddons: selectedAddons));
    }
    notifyListeners();
  }

  // remove from the cart
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }

    notifyListeners();
  }

  // get total price of the cart
  double getTotalPrice() {
    double total = 0.0;

    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;

      for (Addon addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }

      total += itemTotal * cartItem.quantity;
    }

    return total;
  }

  // get total number of items in cart
  int getTotalItemCount() {
    int totalItemCount = 0;

    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }

    return totalItemCount;
  }

  // clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  // update the deliver address
  void updateDeliveryAddress(String newAddress) {
    _deliveryAddress = newAddress;
    notifyListeners();
  }

  /*
   *  H E L P E R S
   */
  //  generate a receipt
  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("Here's your receipt");
    receipt.writeln();

    // format the date to include up to seconds only
    String formattedDate = DateFormat(
      'yyyy-MM-dd HH:mm:ss',
    ).format(DateTime.now());

    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("-----------------");

    for (final cartItem in _cart) {
      receipt.writeln(
        "${cartItem.quantity} x ${cartItem.food.name} - ${_formatPrice(cartItem.food.price)}",
      );
      if (cartItem.selectedAddons.isNotEmpty) {
        receipt.writeln("\tAdd-ons: ${_formatAddons(cartItem.selectedAddons)}");
      }
      receipt.writeln();
    }

    receipt.writeln("-----------------");
    receipt.writeln();
    receipt.writeln("Total Items: ${getTotalItemCount()}");
    receipt.writeln("Total Price: ${_formatPrice(getTotalPrice())}");

    return receipt.toString();
  }

  //  format double value into money
  String _formatPrice(double price) {
    return "₹${price.toStringAsFixed(2)}";
  }

  //  format list of addons into a string summary
  String _formatAddons(List<Addon> addons) {
    return addons
        .map((addons) => "${addons.name} (${_formatPrice(addons.price)})")
        .join(", ");
  }
}
