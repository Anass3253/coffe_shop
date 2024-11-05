import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.coffeeName,
    required this.coffeePrice,
    required this.coffeeImgPath,
  });
  final String coffeeName;
  final double coffeePrice;
  final String coffeeImgPath;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        color: Theme.of(context).colorScheme.tertiary,
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage(coffeeImgPath),
                fit: BoxFit.fill,
                height: 150,
                width: 165,
              ),
            ),
            Column(
                children: [
                  Text(
                    coffeeName,
                    style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  Text(
                    '\$$coffeePrice',
                    style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  )
                ],
              ),
            
          ],
        ),
      ),
    );
  }
}
