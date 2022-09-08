import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:project1/screens/shopping_cart.dart';
import 'package:project1/shopping_list.dart';
import 'package:provider/provider.dart';

import '../database.dart';
import '../provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> productNames = ["Mac Book", "Iphone", "Ipad"];

  List<String> productData = [
    "products/product1.jpg", //mac book
    "products/product2.jpg", // iphone
    "products/product3.jpg" //ipad
  ];


  DataBaseSupport? dbs = DataBaseSupport();

  @override
  Widget build(BuildContext context) {
    final shoppingCart = Provider.of<ShoppingListProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Products"),
          backgroundColor: Colors.black,
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (
                          context) => const ShoppingCartScreen()
                      ),
                    );
                  },
                  child: Badge(
                    badgeContent: Consumer<ShoppingListProvider>(
                      builder: (context, value, child) {
                        return Text(
                          value.getCount().toString(),
                        );
                      },
                    ),
                    animationDuration: const Duration(microseconds: 300),
                    child:  const Icon(Icons.shopping_cart),
                  ),
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: productNames.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.asset(
                            productData[index].toString(),
                          ),
                          Column(
                            children: [
                              Text(
                                productNames[index].toString(),
                                style: const TextStyle(fontSize: 20),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black),
                                    //    style: TextStyle(fontSize: 14)
                                    onPressed: () {
                                      dbs!.insert(
                                        ShoppingList(
                                            id: index,
                                            productId: index.toString(),
                                            productNames:
                                            productNames[index].toString(),
                                            productData:
                                            productData[index].toString(),
                                            totalNumberOfProducts: 1),)
                                          .then((value) {
                                        shoppingCart.addCount();
                                      }).onError((error, stackTrace) {
                                      });
                                    },
                                    child: const Text("Add"),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
