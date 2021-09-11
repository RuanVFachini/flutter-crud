import 'dart:math';

import 'package:curd_flutter/data/dummy_users.dart';
import 'package:curd_flutter/models/user.dart';
import 'package:flutter/material.dart';

class Users with ChangeNotifier {
  final Map<String, User> _items = {... DUMMY_USERS};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put (User user) {

    if (user.id.isNotEmpty && _items.containsKey(user.id)) {
      _items.update(user.id, (_) => User(
        user.id,
        user.name,
        user.email,
        user.avatarUrl));

    } else {
      double nextId =_items.keys.map((e) => double.parse(e)).reduce(max) + 1;

      _items.putIfAbsent(nextId.toString(), () => User(
        nextId.toString(),
        user.name,
        user.email,
        user.avatarUrl
      ));
    }
    notifyListeners();
  }

  void remove (String id) {
    if(_items.containsKey(id))
      _items.remove(id);

    notifyListeners();
  }
}