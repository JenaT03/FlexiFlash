import 'package:flutter/foundation.dart';
import '../../models/flashcard.dart';

class FlashcardManager with ChangeNotifier {
  final List<Flashcard> _flashcards = [
    Flashcard(
      id: 'f1',
      frontText: 'Git là gì?',
      backText:
          'Git là phần mềm quản lý mã nguồn phân tán được phát triển bởi Linus Torvalds vào năm 2005, ban đầu dành cho việc phát triển nhân Linux. Hiện nay, Git trở thành một trong các phần mềm quản lý mã nguồn phổ biến nhất.',
      deckId: 'd1',
    ),
    Flashcard(
      id: 'f2',
      frontText: 'Contract',
      backText: 'Hợp đồng',
      deckId: 'd2',
    ),
    Flashcard(
      id: 'f3',
      frontText: 'Offer',
      backText: 'Lời đề nghị',
      deckId: 'd2',
    ),
    Flashcard(
      id: 'f4',
      frontText: 'Recruit',
      backText: 'Tuyển dụng',
      deckId: 'd2',
    ),
    Flashcard(
      id: 'f5',
      frontText: 'Reference',
      backText: 'Thư giới thiệu',
      deckId: 'd2',
    ),
    Flashcard(
      id: 'f6',
      frontText: 'Qualification',
      backText: 'Trình độ chuyên môn',
      deckId: 'd2',
    ),
    Flashcard(
      id: 'f7',
      frontText: 'Resume',
      backText: 'Sơ yếu lý lịch',
      deckId: 'd2',
    ),
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
  void addFlashcard(Flashcard flashcard) {
    final newFlashcard = flashcard.copyWith(
      id: 'f${DateTime.now().toIso8601String()}',
    );
    _flashcards.add(newFlashcard);
    notifyListeners();
  }

  // Thêm nhiều flashcard cùng lúc
  void addMultipleFlashcards(List<Flashcard> flashcards) {
    for (var flashcard in flashcards) {
      addFlashcard(flashcard);
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

  // Đếm số flashcard trong một deck
  int countFlashcardsInDeck(String deckId) {
    return _flashcards.where((flashcard) => flashcard.deckId == deckId).length;
  }
}
