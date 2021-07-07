import 'package:flutter/foundation.dart';
import 'package:sebbo/models/userData.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final List<String> moreImagesUrl;
  final UserData owner;
  final DateTime listedOn;

  Product({
    @required this.id,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    @required this.listedOn,
    @required this.owner,
    @required this.title,
    this.moreImagesUrl,
  });
}
