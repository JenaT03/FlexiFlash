import 'dart:io';
// import 'flashcard.dart';

class Deck {
  final String? id;
  final String title;
  final String type;
  final String imageBg;
  final bool isFavorite;
  // final String userId;
  final bool isSuperUser;
  // final List<Flashcard>? flashcards;
  final File? imageBgFile;

  // int? get flashcardCount {
  //   return flashcards?.length;
  // }

  Deck({
    this.id,
    required this.title,
    required this.type,
    // this.type = 'yours',
    this.imageBg = '',
    this.isFavorite = false,
    // required this.userId,
    this.isSuperUser = false,
    // this.flashcards,
    this.imageBgFile,
  });

  Deck copyWith({
    String? id,
    String? title,
    String? type,
    String? imageBg,
    bool? isFavorite,
    // String? userId,
    bool? isSuperUser,
    // List<Flashcard>? flashcards,
  }) {
    return Deck(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      imageBg: imageBg ?? this.imageBg,
      isFavorite: isFavorite ?? this.isFavorite,
      // userId: userId ?? this.userId,
      isSuperUser: isSuperUser ?? this.isSuperUser,
      // flashcards: flashcards ?? this.flashcards,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'type': type,
      'isFavorite': isFavorite,
      // 'userId': userId,
      'isSuperUser': isSuperUser,
      // 'flashcards': flashcards.map((flashcard) => flashcard.toJson()).toList(),
    };
  }

  factory Deck.fromJson(Map<String, dynamic> json) {
    return Deck(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      imageBg: json['imageBg'],
      isFavorite: json['isFavorite'],
      // userId: json['userId'],
      isSuperUser: json['isSuperUser'],
      // flashcards: (json['flashcards'] as List)
      //     .map((flashcardJson) => Flashcard.fromJson(flashcardJson))
      //     .toList(),
    );
  }
}
