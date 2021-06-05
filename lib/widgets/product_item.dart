import 'package:flutter/material.dart';
import 'package:sebbo/models/product.dart';
import 'package:intl/intl.dart';

class ProductItem extends StatefulWidget {
  final Product product;
  var addedToCart;
  ProductItem({this.product, this.addedToCart: false});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat.yMMMd().format(widget.product.listedOn),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          Image.network(widget.product.imageUrl),
          Text(
            widget.product.title.toUpperCase(),
            style: TextStyle(
              fontSize: size.width > 350 ? 18 : 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '\u20B9' + widget.product.price.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.addedToCart = !widget.addedToCart;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          widget.addedToCart ? 'Remove' : 'Add to cart',
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          widget.addedToCart
                              ? Icons.remove_shopping_cart
                              : Icons.add_shopping_cart,
                          size: size.width > 350 ? 24 : 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
