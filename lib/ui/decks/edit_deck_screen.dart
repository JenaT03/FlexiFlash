import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../decks/decks_manager.dart';
import '../../models/deck.dart';
import '../screen.dart';

class EditDeckScreen extends StatefulWidget {
  EditDeckScreen(Deck deck, {super.key}) {
    this.deck = deck;
  }
  late final Deck deck;
  @override
  State<EditDeckScreen> createState() => _EditDeckScreenState();
}

class _EditDeckScreenState extends State<EditDeckScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _editForm = GlobalKey<FormState>();
  late Deck _editedDeck;

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
    _editedDeck = widget.deck;
    _imageUrlController.text = _editedDeck.imageBg;
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
            const Text(
              'CHỈNH SỬA BỘ THẺ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Form(
              child: ListView(
                children: <Widget>[
                  _buildTitleDeck(),
                  _buildImageURLField(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ShortButton(
                  text: "Lưu",
                  onPressed: _saveForm,
                ),
              ],
            ),

            //List các flashcard
          ],
        ),
      ),
    );
  }

  TextFormField _buildTitleDeck() {
    return TextFormField(
      initialValue: _editedDeck.title,
      decoration: const InputDecoration(labelText: 'Tên bộ thẻ'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Không được để trống';
        }
        return null;
      },
      onSaved: (value) {
        _editedDeck = _editedDeck.copyWith(title: value);
      },
    );
  }

  TextFormField _buildImageURLField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Đường dẫn ảnh nền'),
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
        _editedDeck = _editedDeck.copyWith(imageBg: value);
      },
    );
  }

  Future<void> _saveForm() async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }

    _editForm.currentState!.save();
    try {
      final deckManager = context.read<DecksManager>();

      deckManager.updateDeck(_editedDeck);
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
