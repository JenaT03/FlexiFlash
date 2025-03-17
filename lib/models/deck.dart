import 'dart:io';

class Deck {
  final String? id;
  final String title;
  final String type;
  final String imageBg;
  bool isFavorite;
  final String? userId;
  final File? imageBgFile;
  final DateTime? createdAt;

  Deck(
      {this.id,
      required this.title,
      required this.type,
      this.imageBg = '',
      this.imageBgFile,
      this.isFavorite = false,
      this.userId,
      this.createdAt});

  Deck copyWith({
    String? id,
    String? title,
    String? type,
    String? imageBg,
    File? imageBgFile,
    bool? isFavorite,
    String? userId,
    DateTime? createdAt,
  }) {
    return Deck(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      imageBg: imageBg ?? this.imageBg,
      imageBgFile: imageBgFile ?? this.imageBgFile,
      isFavorite: isFavorite ?? this.isFavorite,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
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
    };
  }

  factory Deck.fromJson(Map<String, dynamic> json) {
    return Deck(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      imageBg: json['imageBg'],
      isFavorite:
          json['isFavorite'] == 1 || json['isFavorite'] == true ? true : false,
      userId: json['userId'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }
}
