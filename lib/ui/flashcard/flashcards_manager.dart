import 'package:ct484_project/services/flashcards_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';
import '../../models/flashcard.dart';

class FlashcardManager with ChangeNotifier {
  final FlashcardsService _flashcardsService = FlashcardsService();
  final FlutterTts _tts = FlutterTts();
  List<Flashcard> _flashcards = [];

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
  Future<List<Flashcard>> getFlashcardsByDeck(String deckId) async {
    await fetchFlashCards(deckId);
    return _flashcards
        .where((flashcard) => flashcard.deckId == deckId)
        .toList();
  }

  List<Flashcard> getFlashcards() {
    return _flashcards.toList();
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
  Future<void> updateFlashcard(Flashcard flashcard, String deckId) async {
    final index = _flashcards.indexWhere((item) => item.id == flashcard.id);
    if (index >= 0) {
      final updatedFlashcard = await _flashcardsService.updateFlashcard(
          deckId: deckId, flashcard: flashcard);
      if (updatedFlashcard != null) {
        _flashcards[index] = updatedFlashcard;

        notifyListeners();
      }
    }
  }

  // Xóa flashcard
  Future<void> deleteFlashcard(String flashId, String deckId) async {
    final index =
        _flashcards.indexWhere((flashcard) => flashcard.id == flashId);
    if (index >= 0 &&
        !await _flashcardsService.deleteFlashcard(
            deckId: deckId, flashcardId: flashId)) {
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

  Future<void> fetchAndShuffleFlashcards(String deckId) async {
    await fetchFlashCards(deckId);
    _flashcards = List.from(_flashcards)..shuffle();
    notifyListeners();
  }

  Future<void> fetchMarkedFlashCards() async {
    _flashcards = await _flashcardsService.fetchMarkedFlashcards();
    notifyListeners();
  }

  // Đếm số flashcard trong một deck
  Future<int> countFlashcardsInDeck(String deckId) async {
    await fetchFlashCards(deckId);
    int count =
        _flashcards.where((flashcard) => flashcard.deckId == deckId).length;

    return count;
  }

  Future<void> Function(BuildContext, Flashcard)? onDeleteFlashcard;

  void setOnDeleteFunction(
      Future<void> Function(BuildContext, Flashcard) func) {
    onDeleteFlashcard = func;
  }

  Future<void> speak(Flashcard flashcard, String text) async {
    await _tts.setLanguage(flashcard.language);
    await _tts.setSpeechRate(0.6); // Tốc độ đọc
    await _tts.speak(text);
  }

  void stop() {
    _tts.stop();
  }
}
