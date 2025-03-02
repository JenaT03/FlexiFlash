class Deck {
  final String? id;
  final String title;
  final String type;
  final String imageBg;
  bool isFavorite;
  final String userId;

  Deck({
    this.id,
    required this.title,
    this.type = 'yours',
    required this.imageBg,
    this.isFavorite = false,
    required this.userId,
  });

  Deck copyWith({
    String? id,
    String? title,
    String? type,
    String? imageBg,
    bool? isFavorite,
    String? userId,
  }) {
    return Deck(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      imageBg: imageBg ?? this.imageBg,
      isFavorite: isFavorite ?? this.isFavorite,
      userId: userId ?? this.userId,
    );
  }
}
