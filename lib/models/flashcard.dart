class Flashcard {
  final String? id;
  final String frontText;
  final String backText;
  final String deckId;

  Flashcard({
    this.id,
    required this.frontText,
    required this.backText,
    required this.deckId,
  });

  Flashcard copyWith({
    String? id,
    String? frontText,
    String? backText,
    String? deckId,
  }) {
    return Flashcard(
      id: id ?? this.id,
      frontText: frontText ?? this.frontText,
      backText: backText ?? this.backText,
      deckId: deckId ?? this.deckId,
    );
  }
}
