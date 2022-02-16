import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp_projrct/layout/cubit/cubit.dart';
import 'package:gp_projrct/modules/Products/product_Provider.dart';

class StoreCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = ProductProvider.of(context)!.bloc;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10 + .0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  "Cart",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              final item = bloc.cart[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      //backgroundImage: item.product.image,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(item.quantity.toString()),
                    SizedBox(
                      width: 10,
                    ),
                    Text("x"),
                    SizedBox(
                      width: 10,
                    ),
                    Text(item.product.name),
                    SizedBox(
                      width: 10,
                    ),
                    Spacer(),
                    Text(
                        "\$${(item.quantity * item.product.price).toStringAsFixed(2)}"),
                    IconButton(
                        onPressed: () {
                          bloc.deleteProduct(item);
                        },
                        icon: Icon(Icons.delete))
                  ],
                ),
              );
            },
          )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Text(
                  "Total : ",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text(
                  "${bloc.totalCartPrice()}",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            color: Color(0xFFF4C459),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                "Next",
              ),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: () => null,
          ),
        ],
      ),
    );
  }
}
