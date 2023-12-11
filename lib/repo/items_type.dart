import 'package:test_list/model/item_model.dart';

abstract class ItemType{
  List<ItemModel> getListItem();
}