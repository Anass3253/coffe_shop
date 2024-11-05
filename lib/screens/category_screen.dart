import 'package:app/providers/coffee_provider.dart';
import 'package:app/widgets/coffees.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({
    super.key,
    required this.category,
  });
  final String category;

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    ref.read(coffeeProvider.notifier).fetchCoffees(widget.category);
    var coffeeList = ref.watch(coffeeProvider);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Container(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                size: 35,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          actions: [
            IconButton(
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
              ),
            ),
          ],
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            widget.category,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
            maxLines: 2,
          ),
          toolbarHeight: 150,
        ),
        body: Container(
          color: Theme.of(context).colorScheme.secondary,
          child: ListView.builder(
            itemCount: coffeeList.length,
            itemBuilder: (context, index) {
              return Coffees(
                coffeeName: coffeeList[index].name,
                coffeePrice: coffeeList[index].price.toDouble(),
                coffeeImgPath: coffeeList[index].imagePath,
              );
            },
          ),
        ));
  }
}
