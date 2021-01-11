import '../models/maindish.dart';
import '../models/seconddish.dart';
import 'package:flutter/cupertino.dart';

class CartItem extends ChangeNotifier {
  List<Maindish> maindishes = [];
  List<Secondish> seconddishs = [];

  addProduct(Maindish maindishe) {
    maindishes.add(maindishe);
    notifyListeners();
  }

  deleteProduct(Maindish maindishe) {
    maindishes.remove(maindishe);
    notifyListeners();
  }

  addseconddishs(Secondish seconddish) {
    seconddishs.add(seconddish);
    notifyListeners();
  }

  deleteseconddishs(Secondish seconddish) {
    seconddishs.remove(seconddish);
    notifyListeners();
  }
}
