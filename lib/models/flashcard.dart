class Flashcard {
  final String? id;
  final String text;
  final String imgURL;
  final String description;
  final bool isFavorite;
  final String deckId;

  Flashcard({
    this.id,
    required this.text,
    required this.imgURL,
    this.description = '',
    this.isFavorite = false,
    required this.deckId,
  });

  Flashcard copyWith({
    String? id,
    String? text,
    String? imgURL,
    String? description,
    bool? isFavorite,
    String? deckId,
  }) {
    return Flashcard(
      id: id ?? this.id,
      text: text ?? this.text,
      imgURL: imgURL ?? this.imgURL,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
      deckId: deckId ?? this.deckId,
    );
  }
}
