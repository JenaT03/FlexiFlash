import 'dart:io';

class Deck {
  final String? id;
  final String title;
  final String type;
  final String imageBg;
  bool isFavorite;
  bool isSuperUser;
  final String? userId;
  final File? imageBgFile;

  Deck({
    this.id,
    required this.title,
    required this.type,
    this.imageBg = '',
    this.imageBgFile,
    this.isFavorite = false,
    this.isSuperUser = false,
    this.userId,
  });

  Deck copyWith({
    String? id,
    String? title,
    String? type,
    String? imageBg,
    File? imageBgFile,
    bool? isFavorite,
    String? userId,
  }) {
    return Deck(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      imageBg: imageBg ?? this.imageBg,
      imageBgFile: imageBgFile ?? this.imageBgFile,
      isFavorite: isFavorite ?? this.isFavorite,
      isSuperUser: isSuperUser ?? this.isSuperUser,
      userId: userId ?? this.userId,
    );
  }

  bool hasImage() {
    return imageBgFile != null || imageBg.isNotEmpty;
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
      id: json['id'],
      title: json['title'],
      type: json['type'],
      imageBg: json['imageBg'],
      isFavorite: json['isFavorite'] == 1 ? true : false,
      isSuperUser: json['isSuperUser'] == 1 ? true : false,
      userId: json['userId'],
    );
  }
}
