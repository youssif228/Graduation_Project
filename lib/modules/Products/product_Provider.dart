import 'package:flutter/cupertino.dart';
import 'package:gp_projrct/layout/cubit/cubit.dart';

class ProductProvider extends InheritedWidget {
  final EcommerceCubit bloc;
  final Widget child;

  ProductProvider({required this.bloc, required this.child})
      : super(child: child);

  static ProductProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ProductProvider>();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
