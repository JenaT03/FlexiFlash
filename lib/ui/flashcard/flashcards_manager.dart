import 'package:ct484_project/services/flashcards_service.dart';
import 'package:flutter/foundation.dart';
import '../../models/flashcard.dart';

class FlashcardManager with ChangeNotifier {
  final FlashcardsService _flashcardsService = FlashcardsService();
  List<Flashcard> _flashcards = [
    Flashcard(
        id: 'f1',
        text: 'Nấm độc tán trắng',
        imgURL:
            'https://toongadventure.vn/wp-content/uploads/2021/05/lucie-hosova-EFw-2XoOt6w-unsplash-768x512.jpg',
        description:
            '10 loại nấm độc khi trekking xuyên rừng quốc gia Việt Nam. Các trekkers đã ít nhất một lần đến khám phá các khu rừng quốc gia Việt Nam sẽ bất ngờ với hệ sinh thái đa dạng nơi đây. Từ các loài hoa đến các loại quả, đều là những loại thực vật lần đầu tiên bạn nhìn thấy. Việc bắt gặp những loài hoa, thức quả rừng lạ có thể mang đến nhiều trải nghiệm và kiến thức mới lạ. Có thể đó là thứ bạn có thể dùng như một món ăn. Nhưng cũng có những loại thực vật bạn tuyệt đối không thể ăn, đặc biệt là nấm. Bài viết này sẽ giúp bạn hiểu rõ hơn về những loài nấm độc bạn có thể bắt gặp trên chặng đường trekking của mình.Nấm độc tán trắng Loại nấm này có tên khoa học là Amanita Verna. Bạn có thể bắt gặp loại nấm này mọc thành từng cụm hoặc đơn chiếc. Tại Việt Nam, bạn sẽ tìm thấy loài nấm tán trắng này ở các tỉnh phía Bắc như Hà Giang, Tuyên Quang, Thái Nguyên, Yên Bái, Bắc Cạn, Phú Thọ…',
        deckId: 'd1',
        language: 'vi-VN'),
  ];

  // Getter để lấy tất cả flashcard
  List<Flashcard> get flashcards => [..._flashcards];

  // Getter để lấy số lượng flashcard
  int get flashcardCount => _flashcards.length;

  // Tìm flashcard theo id
  Flashcard? findById(String id) {
    try {
      return _flashcards.firstWhere((flashcard) => flashcard.id == id);
    } catch (error) {
      return null;
    }
  }

  // Lấy flashcard theo deckId
  List<Flashcard> getFlashcardsByDeck(String deckId) {
    return _flashcards
        .where((flashcard) => flashcard.deckId == deckId)
        .toList();
  }

  // Thêm flashcard mới
  Future<void> addFlashcard(String id, Flashcard flashcard) async {
    final newFlashcard =
        await _flashcardsService.addFlashcard(deckId: id, flashcard: flashcard);

    if (newFlashcard != null) {
      _flashcards.add(newFlashcard);

      notifyListeners();
    }
  }

  // Thêm nhiều flashcard cùng lúc
  void addMultipleFlashcards(List<Flashcard> flashcards) {
    for (var flashcard in flashcards) {
      //addFlashcard(flashcard);
    }
  }

  // Cập nhật flashcard
  void updateFlashcard(Flashcard flashcard) {
    final index = _flashcards.indexWhere((item) => item.id == flashcard.id);
    if (index >= 0) {
      _flashcards[index] = flashcard;
      notifyListeners();
    }
  }

  // Xóa flashcard
  void deleteFlashcard(String id) {
    final index = _flashcards.indexWhere((flashcard) => flashcard.id == id);
    if (index >= 0) {
      _flashcards.removeAt(index);
      notifyListeners();
    }
  }

  // Xóa tất cả flashcard của một deck
  void deleteFlashcardsInDeck(String deckId) {
    _flashcards.removeWhere((flashcard) => flashcard.deckId == deckId);
    notifyListeners();
  }

  Future<void> fetchFlashCards(String deckId) async {
    _flashcards = await _flashcardsService.fetchFlashcards(deckId: deckId);
    notifyListeners();
  }

  // Đếm số flashcard trong một deck
  Future<int> countFlashcardsInDeck(String deckId) async {
    await fetchFlashCards(deckId);
    int count =
        _flashcards.where((flashcard) => flashcard.deckId == deckId).length;

    return count;
  }
}
