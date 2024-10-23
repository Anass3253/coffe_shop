import 'package:app/providers/coffee_provider.dart';
import 'package:app/widgets/card_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final _searchTxtController = TextEditingController();

  _onSearchBtn() {}

  @override
  Widget build(BuildContext context) {
    final coffeeList = ref.watch(coffeeProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Stack(
            children: [
              Positioned(
                child: IconButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        "Login",
                        (route) => false,
                      );
                    },
                    icon: Icon(
                      Icons.exit_to_app,
                      size: 35,
                      color: Theme.of(context).colorScheme.secondary,
                    )),
              ),
            ],
          )
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "FIND THE BEST COFFEE FOR YOU",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 35,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
          maxLines: 2,
        ),
        toolbarHeight: 200,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TextField(
                controller: _searchTxtController,
                decoration: InputDecoration(
                  icon: IconButton(
                    onPressed: _onSearchBtn,
                    icon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  label: Text(
                    "Search for your Coffee...",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.elliptical(10, 10),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardItem(coffeeName: 'Latte', coffeePrice: '5.5', coffeeImgPath: 'images/latte.jpg',),
                  CardItem(coffeeName: 'Latte', coffeePrice: '5.5', coffeeImgPath: 'images/latte.jpg',),
                  CardItem(coffeeName: 'Latte', coffeePrice: '5.5', coffeeImgPath: 'images/latte.jpg',),
                  // CardItem(),
                  // CardItem(),
                  // CardItem(),
                  // CardItem()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
