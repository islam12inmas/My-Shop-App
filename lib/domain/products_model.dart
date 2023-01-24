class ProductsModel {
  ProductsModel({
      this.NMQNL7YMbQkWUWPfTak, 
      this.NMQTD9MQPTH5tQBmVjG,});

  ProductsModel.fromJson(dynamic json) {
    NMQNL7YMbQkWUWPfTak = json['-NMQNL7YMbQkWUWPfTak'] != null ? Nmqnl7yMbQkWuwPfTak.fromJson(json['-NMQNL7YMbQkWUWPfTak']) : null;
    NMQTD9MQPTH5tQBmVjG = json['-NMQTD9MQPTH5tQBmVjG'] != null ? Nmqtd9mqpth5tQBmVjG.fromJson(json['-NMQTD9MQPTH5tQBmVjG']) : null;
  }
  Nmqnl7yMbQkWuwPfTak? NMQNL7YMbQkWUWPfTak;
  Nmqtd9mqpth5tQBmVjG? NMQTD9MQPTH5tQBmVjG;
ProductsModel copyWith({  Nmqnl7yMbQkWuwPfTak? NMQNL7YMbQkWUWPfTak,
  Nmqtd9mqpth5tQBmVjG? NMQTD9MQPTH5tQBmVjG,
}) => ProductsModel(  NMQNL7YMbQkWUWPfTak: NMQNL7YMbQkWUWPfTak ?? this.NMQNL7YMbQkWUWPfTak,
  NMQTD9MQPTH5tQBmVjG: NMQTD9MQPTH5tQBmVjG ?? this.NMQTD9MQPTH5tQBmVjG,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (NMQNL7YMbQkWUWPfTak != null) {
      map['-NMQNL7YMbQkWUWPfTak'] = NMQNL7YMbQkWUWPfTak?.toJson();
    }
    if (NMQTD9MQPTH5tQBmVjG != null) {
      map['-NMQTD9MQPTH5tQBmVjG'] = NMQTD9MQPTH5tQBmVjG?.toJson();
    }
    return map;
  }

}

class Nmqtd9mqpth5tQBmVjG {
  Nmqtd9mqpth5tQBmVjG({
      this.description, 
      this.imageUrl, 
      this.isFavorite, 
      this.price, 
      this.title,});

  Nmqtd9mqpth5tQBmVjG.fromJson(dynamic json) {
    description = json['description'];
    imageUrl = json['imageUrl'];
    isFavorite = json['isFavorite'];
    price = json['price'];
    title = json['title'];
  }
  String? description;
  String? imageUrl;
  bool? isFavorite;
  num? price;
  String? title;
Nmqtd9mqpth5tQBmVjG copyWith({  String? description,
  String? imageUrl,
  bool? isFavorite,
  num? price,
  String? title,
}) => Nmqtd9mqpth5tQBmVjG(  description: description ?? this.description,
  imageUrl: imageUrl ?? this.imageUrl,
  isFavorite: isFavorite ?? this.isFavorite,
  price: price ?? this.price,
  title: title ?? this.title,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['description'] = description;
    map['imageUrl'] = imageUrl;
    map['isFavorite'] = isFavorite;
    map['price'] = price;
    map['title'] = title;
    return map;
  }

}

class Nmqnl7yMbQkWuwPfTak {
  Nmqnl7yMbQkWuwPfTak({
      this.description, 
      this.imageUrl, 
      this.isFavorite, 
      this.price, 
      this.title,});

  Nmqnl7yMbQkWuwPfTak.fromJson(dynamic json) {
    description = json['description'];
    imageUrl = json['imageUrl'];
    isFavorite = json['isFavorite'];
    price = json['price'];
    title = json['title'];
  }
  String? description;
  String? imageUrl;
  bool? isFavorite;
  num? price;
  String? title;
Nmqnl7yMbQkWuwPfTak copyWith({  String? description,
  String? imageUrl,
  bool? isFavorite,
  num? price,
  String? title,
}) => Nmqnl7yMbQkWuwPfTak(  description: description ?? this.description,
  imageUrl: imageUrl ?? this.imageUrl,
  isFavorite: isFavorite ?? this.isFavorite,
  price: price ?? this.price,
  title: title ?? this.title,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['description'] = description;
    map['imageUrl'] = imageUrl;
    map['isFavorite'] = isFavorite;
    map['price'] = price;
    map['title'] = title;
    return map;
  }

}