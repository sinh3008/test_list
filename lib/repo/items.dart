import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_list/model/item_model.dart';

const item_list = 'item_list';

class Item {
  late SharedPreferences sharedPreferences;

  Future<List<ItemModel>> getItemList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(item_list) ?? '[]';
    final List jsonDecoded = jsonDecode(jsonString) as List;
    return jsonDecoded.map((e) => ItemModel.fromJson(e)).toList();
  }

  void saveTodoList(List<ItemModel> list) {
    final String jsonString = json.encode(list);
    sharedPreferences.setString('item_list', jsonString);
  }
}
