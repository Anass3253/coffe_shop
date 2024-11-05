import 'package:app/screens/category_screen.dart';
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
  final categoriesList = [
    "Brewed Coffee",
    "Cold Coffee Drinks",
    " Espresso-Based Drinks",
    " Non-Coffee Drinks",
    "Specialty Coffees",
  ];
  _onSearchBtn() {}
  _onTabGridChild(String category) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CategoryScreen(category: category),
      ),
    );
    print(category);
  }

  @override
  Widget build(BuildContext context) {
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
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(10.0),
              sliver: SliverToBoxAdapter(
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
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.elliptical(10, 10),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 10),
            ),
            SliverToBoxAdapter(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              height: 150, // Set a fixed height for horizontal scrollable area
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CardItem(
                    coffeeName: 'Latte',
                    coffeePrice: 5.5,
                    coffeeImgPath: 'images/latte.jpg',
                  ),
                  CardItem(
                    coffeeName: 'Espresso',
                    coffeePrice: 3.5,
                    coffeeImgPath: 'images/espresso.jpg',
                  ),
                  CardItem(
                    coffeeName: 'Cappuccino',
                    coffeePrice: 4.0,
                    coffeeImgPath: 'images/latte.jpg',
                  ),
                ],
              ),
            )),
            const SliverToBoxAdapter(
              child: SizedBox(height: 10),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                childCount: categoriesList.length,
                (context, index) {
                  return InkWell(
                    onTap: () => _onTabGridChild(categoriesList[index]),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context)
                                .colorScheme
                                .tertiary
                                .withOpacity(0.9),
                            Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.55),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Card(
                        elevation: 5,
                        color: Theme.of(context).colorScheme.tertiary,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_cafe,
                              size: 40,
                              color: Colors.brown[700], // Icon color
                            ),
                            const SizedBox(height: 10),
                            Text(
                              categoriesList[index],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.brown[900],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
