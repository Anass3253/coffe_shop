import 'package:flutter/material.dart';

class Coffees extends StatefulWidget {
  const Coffees({
    super.key,
    required this.coffeeName,
    required this.coffeePrice,
    required this.coffeeImgPath,
  });
  final String coffeeName;
  final double coffeePrice;
  final String coffeeImgPath;

  @override
  State<Coffees> createState() => _CoffeesState();
}

class _CoffeesState extends State<Coffees> {
  @override
  Widget build(BuildContext context) {
    return Text('');
  }
}
