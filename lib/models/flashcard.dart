import 'dart:io';

class Flashcard {
  final String? id;
  final String text;
  final String imgURL;
  final String description;
  final String language;
  final bool isMarked;
  final String deckId;
  final File? imageFile;

  Flashcard({
    this.id,
    required this.text,
    this.imgURL = '',
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
    File? imageFile,
    String? description,
    String? language,
    bool? isMarked,
    String? deckId,
  }) {
    return Flashcard(
      id: id ?? this.id,
      text: text ?? this.text,
      imgURL: imgURL ?? this.imgURL,
      imageFile: imageFile ?? this.imageFile,
      description: description ?? this.description,
      language: language ?? this.language,
      isMarked: isMarked ?? this.isMarked,
      deckId: deckId ?? this.deckId,
    );
  }

  bool hasImage() {
    return imageFile != null || imgURL.isNotEmpty;
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'description': description,
      'language': language,
      'isMarked': isMarked ? 1 : 0,
      'deckId': deckId,
    };
  }

  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      id: json['id'],
      text: json['text'],
      imgURL: json['imgUrl'],
      description: json['description'] ?? '',
      language: json['language'],
      isMarked:
          json['isMarked'] == 1 || json['isMarked'] == true ? true : false,
      deckId: json['deckId'],
    );
  }
}
