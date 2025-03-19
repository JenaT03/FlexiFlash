import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screen.dart';
import '../../models/flashcard.dart';

class Quiz extends StatefulWidget {
  static const routeName = '/flashcard_quiz';

  final String deckId;
  const Quiz({super.key, required this.deckId});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  late List<Flashcard> _flashcards;
  int _currentIndex = 0;
  int _correctAnswers = 0;
  int _wrongAnswers = 0;
  late bool _result;
  final TextEditingController _answerController = TextEditingController();
  String? _feedbackMessage;

  @override
  void initState() {
    super.initState();
    _flashcards = []; // Tránh lỗi truy cập danh sách trống
    _loadFlashcards();
  }

  Future<void> _loadFlashcards() async {
    await context
        .read<FlashcardManager>()
        .fetchAndShuffleFlashcards(widget.deckId);
    setState(() {
      _flashcards = context.read<FlashcardManager>().getFlashcards();
    });
  }

  void _checkAnswer() {
    String userAnswer = _answerController.text.trim().toLowerCase();
    String correctAnswer = _flashcards[_currentIndex].text.trim().toLowerCase();

    setState(() {
      if (userAnswer == correctAnswer) {
        _feedbackMessage = "Chính xác! 😉 Chuẩn không cần chỉnh 💯";
        _correctAnswers++;
        _result = true;
      } else {
        _feedbackMessage = "Sai mất rồi 😢... Đáp án đúng là $correctAnswer";
        _wrongAnswers++;
        _result = false;
      }
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _flashcards.length - 1) {
      setState(() {
        _currentIndex++;
        _answerController.clear();
        _feedbackMessage = null;
      });
    } else {
      showSummaryDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_flashcards.isEmpty) {
      return SafeArea(child: SplashScreen());
    }
    final flashcard = _flashcards[_currentIndex];
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Image.asset(
                'assets/images/logo.png',
                height: 36,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 228,
                      height: 214,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: NetworkImage(flashcard.imgURL),
                          fit: BoxFit.cover,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Đây là...',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _answerController,
                      decoration: InputDecoration(
                        labelText: "Nhập câu trả lời",
                        filled: false,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    if (_feedbackMessage == null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ShortButton(
                            text: "Trả lời",
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              _checkAnswer();
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
          if (_feedbackMessage != null)
            _showResult(), // Đặt dưới cùng, không bị tràn ra ngoài
        ],
      ),
    );
  }

  Container _showResult() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: BoxDecoration(
        color: _result == true ? Colors.green[100] : Colors.red[100],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                _feedbackMessage!,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.visible, // Xuống dòng khi quá dài
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: ShortButton(
              onPressed: _nextQuestion,
              text: "Tiếp theo",
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showSummaryDialog() {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Kết quả ️🏆',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min, //  Hạn chế chiều cao tối đa
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 250, // Đặt kích thước cụ thể
                height: 150,
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 4,
                          centerSpaceRadius:
                              40, // Biến PieChart thành Doughnut Chart
                          startDegreeOffset: -90,
                          sections: [
                            PieChartSectionData(
                              value: _correctAnswers.toDouble(),
                              color: Colors.green,
                              title: '',
                              radius: 20,
                            ),
                            PieChartSectionData(
                              value: _wrongAnswers.toDouble(),
                              color: Colors.red,
                              title: '',
                              radius: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                        flex: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LegendItem(
                                color: Colors.green,
                                text: 'Đúng $_correctAnswers câu'),
                            LegendItem(
                                color: Colors.red,
                                text: "Sai $_wrongAnswers câu"),
                          ],
                        ))
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Bạn muốn trở về bộ thẻ này hay trở về trang chủ?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustTextButton(
                text: "Đến bộ thẻ",
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  DeckDetailScreen.routeName,
                  arguments: widget.deckId,
                  (route) => false,
                ),
              ),
              CustFilledButton(
                text: "Trang chủ",
                onPressed: () {
                  Navigator.of(ctx).pushNamedAndRemoveUntil(
                    DecksOverviewScreen.routeName,
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget LegendItem({required Color color, required String text}) {
    return Row(
      children: [
        Container(width: 16, height: 16, color: color),
        SizedBox(width: 4),
        Text(text),
      ],
    );
  }
}
