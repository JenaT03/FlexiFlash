import 'dart:io';

class Deck {
  final String? id;
  final String title;
  final String type;
  final String imageBg;
  bool isFavorite;
  bool isSuperUser;
  final String? userId;
  final File? featuredImage;

  Deck({
    this.id,
    required this.title,
    required this.type,
    this.imageBg = '',
    this.featuredImage,
    this.isFavorite = false,
    this.isSuperUser = false,
    this.userId,
  });

  Deck copyWith({
    String? id,
    String? title,
    String? type,
    String? imageBg,
    File? featuredImage,
    bool? isFavorite,
    String? userId,
  }) {
    return Deck(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      imageBg: imageBg ?? this.imageBg,
      featuredImage: featuredImage ?? this.featuredImage,
      isFavorite: isFavorite ?? this.isFavorite,
      isSuperUser: isSuperUser ?? this.isSuperUser,
      userId: userId ?? this.userId,
    );
  }

  bool hasFeaturedImage() {
    return featuredImage != null || imageBg.isNotEmpty;
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'type': type,
      'isFavorite': isFavorite ? 1 : 0,
      'isSuperUser': isSuperUser ? 1 : 0,
    };
  }

  factory Deck.fromJson(Map<String, dynamic> json) {
    return Deck(
      id: json['deck']['id'],
      title: json['deck']['title'],
      type: json['deck']['type'],
      imageBg: json['deck']['imageBg'],
      isFavorite: json['deck']['isFavorite'] == 1 ? true : false,
      isSuperUser: json['deck']['isSuperUser'] == 1 ? true : false,
    );
  }
}
