import 'package:flutter/material.dart';
import 'package:project1/shopping_list.dart';
import 'package:provider/provider.dart';

import '../database.dart';
import '../provider.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {

  DataBaseSupport? dbs = DataBaseSupport();
  @override
  Widget build(BuildContext context) {
    final shoppingCart = Provider.of<ShoppingListProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Shopping lists"),
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.orange),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Column(
          children: [
            FutureBuilder(
              future: shoppingCart.getData(),
              builder: (context, AsyncSnapshot<List<ShoppingList>> snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[

                                  Column(
                                    children: [

                                      Text(
                                        snapshot.data![index].productNames
                                            .toString(),
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(
                                          height: 200,
                                          width: 200,
                                          child: Image.asset(
                                            snapshot.data![index].productData
                                                .toString(),
                                          )),
                                    ],
                                  ),
                                  FloatingActionButton(
                                    onPressed: () {
                                      int total = snapshot.data![index].totalNumberOfProducts!;
                                      total--;

                                      if(total > 0){
                                        dbs!.totalItems(
                                            ShoppingList(
                                                id: snapshot.data![index].id!,
                                                productId: snapshot.data![index].id!.toString(),
                                                productNames:snapshot.data![index].productNames!,
                                                productData: snapshot.data![index].productData!,
                                                totalNumberOfProducts: total)
                                        ).then((value) {
                                          total = 0;
                                        }).onError((error, stackTrace) {
                                        });
                                      }

                                    },
                                    backgroundColor: Colors.white,
                                    child: const Icon(Icons.remove,
                                        color: Colors.black),
                                  ),

                                  Text(snapshot.data![index].totalNumberOfProducts.toString()),

                                  FloatingActionButton(
                                    backgroundColor: Colors.white,
                                    onPressed: () {
                                      int total = snapshot.data![index].totalNumberOfProducts!;
                                      total++;
                                      dbs!.totalItems(
                                          ShoppingList(
                                              id: snapshot.data![index].id!,
                                              productId: snapshot.data![index].id!.toString(),
                                              productNames:snapshot.data![index].productNames!,
                                              productData: snapshot.data![index].productData!,
                                              totalNumberOfProducts: total)
                                      ).then((value) {
                                        total = 0;
                                      }).onError((error, stackTrace) {
                                      });
                                    },

                                    child: const Icon(Icons.add,
                                        color: Colors.black87),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                        dbs!.delete(snapshot.data![index].id!);
                                        shoppingCart.removeCount();
                                    }, icon: const Icon(Icons.delete),
                                  ),

                                ],
                              ),
                            ),
                          );
                        }),
                  );
                } else {
                }
                return const Text("");
              },
            ),
          ],
        ),
      ),
    );
  }
}
