import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../flashcard/flashcards_manager.dart';
import '../../models/flashcard.dart';
import '../screen.dart';

class AddFlashCardScreen extends StatefulWidget {
  AddFlashCardScreen(Flashcard? flashcard, {super.key}) {
    this.flashcard = Flashcard(text: '', imgURL: '', deckId: '');
  }
  late final Flashcard flashcard;
  @override
  State<AddFlashCardScreen> createState() => _AddFlashCardScreenState();
}

class _AddFlashCardScreenState extends State<AddFlashCardScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _addForm = GlobalKey<FormState>();
  late Flashcard _addedflashcard;

  bool _isValidImageUrl(String value) {
    return (value.startsWith('http') || value.startsWith('https')) &&
        (value.endsWith('.png') ||
            value.endsWith('.jpg') ||
            value.endsWith('jpeg'));
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(() {
      if (!_imageUrlFocusNode.hasFocus) {
        if (!_isValidImageUrl(_imageUrlController.text)) {
          return;
        }
        setState(() {});
      }
    });
    _addedflashcard = widget.flashcard;
    _imageUrlController.text = _addedflashcard.imgURL;
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 36),
            ],
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 40, left: 10, right: 10),
        child: Column(
          children: [
            Text(
              'Tên bộ thẻ'.toUpperCase(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Form(
                child: ListView(
                  children: <Widget>[
                    _buildTitleflashcard(),
                    const SizedBox(height: 10),
                    _buildImageURLField(),
                    _buildDescriptionField()
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShortButton(
                  text: "Hoàn thành",
                  onPressed: () => {},
                ),
                ShortButton(
                  text: "Tiếp tục",
                  onPressed: _saveForm,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  TextFormField _buildTitleflashcard() {
    return TextFormField(
      initialValue: '',
      decoration: const InputDecoration(
        labelText: 'Tên thẻ',
        filled: false,
        border: UnderlineInputBorder(),
      ),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Không được để trống';
        }
        return null;
      },
      onSaved: (value) {
        _addedflashcard = _addedflashcard.copyWith(text: value);
      },
    );
  }

  TextFormField _buildImageURLField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Đường dẫn ảnh minh họa',
        filled: false,
        border: UnderlineInputBorder(),
      ),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      controller: _imageUrlController,
      focusNode: _imageUrlFocusNode,
      onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Không được để trống';
        }
        if (!_isValidImageUrl(value)) {
          return 'Hãy nhập đường dẫn chính xác';
        }
        return null;
      },
      onSaved: (value) {
        _addedflashcard = _addedflashcard.copyWith(imgURL: value);
      },
    );
  }

  TextFormField _buildDescriptionField() {
    return TextFormField(
      initialValue: '',
      decoration: const InputDecoration(
        labelText: 'Mô tả',
        filled: false,
        border: UnderlineInputBorder(),
      ),
      maxLines: 4,
      keyboardType: TextInputType.multiline,
      onSaved: (value) {
        _addedflashcard = _addedflashcard.copyWith(description: value);
      },
    );
  }

  Future<void> _saveForm() async {
    final isValid = _addForm.currentState!.validate();
    if (!isValid) {
      return;
    }

    _addForm.currentState!.save();
    try {
      final flashcardManager = context.read<FlashcardManager>();

      flashcardManager.addFlashcard(_addedflashcard);
    } catch (error) {
      await showErrorDialog(context, 'Có lỗi xảy ra');
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> showErrorDialog(BuildContext context, String message) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
                icon: const Icon(Icons.error),
                title: const Text('Lỗi trong quá trính lưu!'),
                content: Text(message),
                actions: <Widget>[
                  ActionButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ]));
  }
}
