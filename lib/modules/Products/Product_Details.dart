import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp_projrct/models/product.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({
    Key? key,
    required this.product,
    required this.onProductAdded,
  }) : super(key: key);
  final Product product;
  final VoidCallback onProductAdded;

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String heroTag = "";

  void addToCart(BuildContext context) {
    setState(() {
      heroTag = "details";
    });

    widget.onProductAdded();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Hero(
                      tag: "list_${widget.product.name}$heroTag",
                      child: Image.network(
                        "https://media.gettyimages.com/photos/kiwi-picture-id482728017?s=170667a",
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.4,
                      ),
                    ),
                    Text(
                      widget.product.name,
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.product.weight,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: Colors.grey),
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Text(
                          "\$${widget.product.price}",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.product.description,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: RaisedButton(
                        color: Color(0xFFF4C459),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Text(
                            "Add to Cart",
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () => addToCart(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

/*Center(
        child:
      ),*/
