import 'package:flutter/cupertino.dart';
import 'package:gp_projrct/models/product.dart';

enum CartState {
  normal,
  details,
  cart,
}

class EcommerceCubit with ChangeNotifier {
  CartState cart_state = CartState.normal;

  List<Product> catalog = List.unmodifiable(commerceProducts);
  List<ProductItem> cart = [];

  void changeToNormal() {
    cart_state = CartState.normal;
    notifyListeners();
  }

  void changeToCart() {
    cart_state = CartState.cart;
    notifyListeners();
  }

  void addProduct(Product product) {
    for (ProductItem item in cart) {
      if (item.product.name == product.name) {
        item.increment();
        notifyListeners();
      }
    }
    cart.add(ProductItem(product: product));
    notifyListeners();
    return;
  }

  void deleteProduct(ProductItem productitem) {
    cart.remove(productitem);
    notifyListeners();
  }

  int totalCartElements() => cart.fold<int>(
      0, (previousValue, element) => previousValue + element.quantity);

  double totalCartPrice() => cart.fold<double>(
      0.0,
      (previousValue, element) =>
          previousValue + (element.quantity * element.product.price));
}

class ProductItem {
  ProductItem({this.quantity = 1, required this.product});

  int quantity;
  final Product product;

  void increment() {
    quantity++;
  }

  void decrement() {}
}
