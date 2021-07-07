import 'package:flutter/material.dart';
import 'package:sebbo/config/constants.dart';
import 'package:sebbo/models/product.dart';
import 'package:intl/intl.dart';
import 'package:sebbo/widgets/custom_header_back.dart';

class ProductView extends StatefulWidget {
  static const String productViewRoute = '/home/product/productView';
  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as ProductViewArguments;
    bool addedToCart = args.addedToCart;
    return Scaffold(
      body: ListView(
        shrinkWrap: false,
        children: [
          CustomHeaderBack(
            title: 'Book Details',
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            child: Image.network(
              args.product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Text(
              args.product.title,
              style: TextStyle(
                fontSize: 30,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.green[400],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\u20B9' + args.product.price.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Price',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                margin: const EdgeInsets.only(left: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(),
                        Text(
                          args.product.owner.name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      DateFormat.yMMMd().format(args.product.listedOn),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Description',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              args.product.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          myRaisedButton(
            label: 'Contact seller',
            onPressed: () {},
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class ProductViewArguments {
  final Product product;
  final bool addedToCart;
  ProductViewArguments({this.addedToCart, this.product});
}
