import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_model.g.dart';
part 'item_model.freezed.dart';

@freezed
class ItemModel with _$ItemModel {
  factory ItemModel({
    required String name,
    required bool isActive,
  }) = _ItemModel;


  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);
}
