import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp_projrct/layout/cubit/cubit.dart';
import 'package:gp_projrct/modules/Cart/Store_Cart.dart';
import 'package:gp_projrct/modules/Products/product_Provider.dart';

import 'ecommerceStoreList.dart';

const homeBackgroundColor = Color(0XFFF6F5F2);
const cartBarItem = 100.0;
const panelTransition = Duration(milliseconds: 500);

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bloc = EcommerceCubit();
  void onVerticalGesture(DragUpdateDetails details) {
    print(details.primaryDelta);
    if (details.primaryDelta! < -7) {
      bloc.changeToCart();
    } else if (details.primaryDelta! > 12) {
      bloc.changeToNormal();
    }
  }

  double? getTopForWhitePanel(CartState state, Size size) {
    if (state == CartState.normal) {
      return -cartBarItem / 20;
    } else if (state == CartState.cart) {
      return -(size.height - kToolbarHeight - cartBarItem / 2);
    }
    return 0.0;
  }

  double? getTopForBlackPanel(CartState state, Size size) {
    if (state == CartState.normal) {
      return size.height - kToolbarHeight - cartBarItem;
    } else if (state == CartState.cart) {
      return cartBarItem / 2;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ProductProvider(
      bloc: bloc,
      child: AnimatedBuilder(
          animation: bloc,
          builder: (context, _) {
            return Scaffold(
              appBar: AppBar(
                title: Text("fefesf"),
              ),
              backgroundColor: Colors.black,
              body: Stack(
                children: [
                  AnimatedPositioned(
                    left: 0,
                    right: 0,
                    top: getTopForWhitePanel(bloc.cart_state, size),
                    height: size.height - kToolbarHeight,
                    duration: panelTransition,
                    curve: Curves.decelerate,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: StoreList(),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    left: 0,
                    right: 0,
                    top: getTopForBlackPanel(bloc.cart_state, size),
                    height: size.height - kToolbarHeight * 2.5,
                    duration: panelTransition,
                    curve: Curves.decelerate,
                    child: GestureDetector(
                      onVerticalDragUpdate: onVerticalGesture,
                      child: Container(
                        color: Colors.black,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: AnimatedSwitcher(
                                  duration: panelTransition,
                                  child: bloc.cart_state == CartState.normal
                                      ? Row(
                                          children: [
                                            Text(
                                              "Cart",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                            Expanded(
                                              child: SingleChildScrollView(
                                                physics:
                                                    BouncingScrollPhysics(),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: Row(
                                                      children: List.generate(
                                                    bloc.cart.length,
                                                    (index) => Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0),
                                                      child: Stack(
                                                        children: [
                                                          Hero(
                                                            tag:
                                                                "list_${bloc.cart[index].product.name}details",
                                                            child: CircleAvatar(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              //backgroundImage: bloc.cart[index].product.image,
                                                            ),
                                                          ),
                                                          Positioned(
                                                            right: 0,
                                                            child: CircleAvatar(
                                                              radius: 10,
                                                              backgroundColor:
                                                                  Colors.red,
                                                              child: Text(
                                                                bloc.cart[index]
                                                                    .quantity
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                                ),
                                              ),
                                            ),
                                            CircleAvatar(
                                              backgroundColor: Colors.yellow,
                                              child: Text(bloc
                                                  .totalCartElements()
                                                  .toString()),
                                            ),
                                          ],
                                        )
                                      : const SizedBox.shrink()),
                            ),
                            Expanded(child: StoreCart()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
