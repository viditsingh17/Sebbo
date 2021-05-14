import 'package:flutter/material.dart';
import 'package:sebbo/models/product.dart';
import 'package:intl/intl.dart';

class ProductView extends StatefulWidget {
  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  var dummyProduct = Product(
    id: 'a1',
    description:
        'uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuei i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i i bfvbipbipbipbipbipbipbipbipbipbipbipbipbipbipbipbipw gap',
    price: 153.32,
    imageUrl: 'https://picsum.photos/200',
    listedOn: DateTime.now(),
    owner: 'Rakesh Roshan',
    title: 'Nayana: A Thrilling Mystery',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product View'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dummyProduct.title,
              style: TextStyle(
                fontSize: 26,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              child: Image.network(
                dummyProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Price: \u20B9' + dummyProduct.price.toString(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green[500],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Listed by: ' + dummyProduct.owner,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Listed on: ' + DateFormat.yMMMd().format(dummyProduct.listedOn),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Description',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              dummyProduct.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
