class ItemModel {
  String name;
  bool isActive;

  ItemModel(this.name, this.isActive);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isActive': isActive,
    };
  }
}
