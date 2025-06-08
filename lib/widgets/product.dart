// models/product.dart
import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final String subtitle;
  final double price;
  final String brand;
  final Color? color;
  final String category;
  final double rating;
  final String imageUrl; 

  Product({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.brand,
    this.color,
    required this.category,
    this.rating = 4.0,
    this.imageUrl = '',
  });
  
 
}