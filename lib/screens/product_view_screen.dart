import 'package:flutter/material.dart';
import 'package:sebbo/config/constants.dart';
import 'package:sebbo/models/product.dart';
import 'package:intl/intl.dart';
import 'package:sebbo/widgets/custom_header_back.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductView extends StatefulWidget {
  static const String productViewRoute = '/home/product/productView';
  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  Widget _buildSellerBox(name, date) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          margin: const EdgeInsets.only(left: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      minRadius: 14,
                      backgroundImage:
                          AssetImage('./assets/images/default.png'),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMd().format(date),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final args =
        ModalRoute.of(context).settings.arguments as ProductViewArguments;
    bool addedToCart = args.addedToCart;
    var images = [];
    images.add(args.product.imageUrl);
    images += args.product.moreImagesUrl;
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
            child: CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 1,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 10),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
              items: images.map((i) {
                return Image.network(
                  i,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitHeight,
                );
              }).toList(),
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
                fontSize: width > 350 ? 30 : 20,
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
                        fontSize: width > 350 ? 30 : 20,
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
            height: 20,
          ),
          _buildSellerBox(args.product.owner.name, args.product.listedOn),
          SizedBox(
            height: 30,
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
