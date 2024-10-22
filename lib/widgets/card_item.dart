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
  final String coffeePrice;
  final String coffeeImgPath;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.tertiary,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage(coffeeImgPath),
                fit: BoxFit.fill,
                height: 150,
                width: 200,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
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
            )
          ],
        ),
      ),
    );
  }
}
