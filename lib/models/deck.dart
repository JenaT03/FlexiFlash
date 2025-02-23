class Deck {
  final String? id;
  final String title;
  final String imageBg;
  final bool isFavorite;
  final String userId;

  Deck({
    this.id,
    required this.title,
    required this.imageBg,
    this.isFavorite = false,
    required this.userId,
  });

  Deck copyWith({
    String? id,
    String? title,
    String? imageBg,
    bool? isFavorite,
    String? userId,
  }) {
    return Deck(
      id: id ?? this.id,
      title: title ?? this.title,
      imageBg: imageBg ?? this.imageBg,
      isFavorite: isFavorite ?? this.isFavorite,
      userId: userId ?? this.userId,
    );
  }
}