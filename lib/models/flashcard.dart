import 'dart:io';

class Flashcard {
  final String? id;
  final String text;
  final String? imgURL;
  final String description;
  final String language;
  final bool isMarked;
  final String deckId;
  final File? imageFile;

  Flashcard({
    this.id,
    required this.text,
    this.imgURL,
    required this.description,
    required this.language,
    this.isMarked = false,
    required this.deckId,
    this.imageFile,
  });

  Flashcard copyWith({
    String? id,
    String? text,
    String? imgURL,
    String? description,
    String? language,
    bool? isMarked,
    String? deckId,
  }) {
    return Flashcard(
      id: id ?? this.id,
      text: text ?? this.text,
      imgURL: imgURL ?? this.imgURL,
      description: description ?? this.description,
      language: language ?? this.language,
      isMarked: isMarked ?? this.isMarked,
      deckId: deckId ?? this.deckId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'description': description,
      'language': language,
      'isMarked': isMarked,
      'deckId': deckId,
    };
  }

  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      id: json['id'],
      text: json['text'],
      imgURL: json['imgURL'],
      description: json['description'],
      language: json['language'],
      isMarked: json['isMarked'] ?? false,
      deckId: json['deckId'],
    );
  }
}
