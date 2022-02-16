import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp_projrct/layout/home/DualView.dart';
import 'package:gp_projrct/models/product.dart';
import 'package:gp_projrct/modules/Products/Product_Details.dart';
import 'package:gp_projrct/modules/Products/product_Provider.dart';

import 'home_screen.dart';

class StoreList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = ProductProvider.of(context)!.bloc;

    return Container(
      color: homeBackgroundColor,
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: StraggeredDualView(
          aspectRatio: 0.7,
          offsetPercent: 0.3,
          spacing: 12,
          itemBuilder: (context, index) {
            final product = bloc.catalog[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 900),
                    pageBuilder: (context, animation, __) {
                      return FadeTransition(
                          opacity: animation,
                          child: ProductDetails(
                              product: product,
                              onProductAdded: () {
                                bloc.addProduct(product);
                              }));
                    },
                  ),
                );
              },
              child: Card(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 8,
                shadowColor: Colors.black,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Hero(
                          tag: "list_${product.name}",
                          child: Image.network(
                              "https://media.gettyimages.com/photos/kiwi-picture-id482728017?s=170667a",
                              fit: BoxFit.contain),
                        ),
                      ),
                      Text(
                        "\$${product.price}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "${product.name}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "${product.weight}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: bloc.catalog.length),
    );
  }
}
