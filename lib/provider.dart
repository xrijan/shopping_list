import 'package:flutter/cupertino.dart';
import 'package:project1/database.dart';
import 'package:project1/shopping_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingListProvider with ChangeNotifier {

  DataBaseSupport db = DataBaseSupport();
  int count = 0;
  int get counter => count;

  late Future<List<ShoppingList>> _cart;
  Future<List<ShoppingList>> get cart => _cart;

  Future<List<ShoppingList>> getData() async{
    _cart = db.getShoppingList();
    return _cart;
  }


  //using shared pref to preserbe data when ever app is killed

  void _setPrefItems () async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("items",count);
    notifyListeners();
  }

  void _getPrefItems () async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    count = prefs.getInt("items") ?? 0;
    prefs.setInt("items",count);
    notifyListeners();
  }

  void addCount () {
    count++;
    _setPrefItems();
    _getPrefItems();
  }

  void removeCount () {
    count--;
    _setPrefItems();
    _getPrefItems();
  }

  int getCount () {
    _getPrefItems();
    return count;
  }

}