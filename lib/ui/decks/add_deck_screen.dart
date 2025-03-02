import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../decks/decks_manager.dart';
import '../../models/deck.dart';
import '../screen.dart';

class AddDeckScreen extends StatefulWidget {
  AddDeckScreen(Deck? deck, {super.key}) {
    this.deck = Deck(id: null, title: '', imageBg: '', userId: '');
  }
  late final Deck deck;
  @override
  State<AddDeckScreen> createState() => _AddDeckScreenState();
}

class _AddDeckScreenState extends State<AddDeckScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _addForm = GlobalKey<FormState>();
  late Deck _addedDeck;

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
    _addedDeck = widget.deck;
    _imageUrlController.text = _addedDeck.imageBg;
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
              'TẠO BỘ THẺ MỚI',
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
                    _buildTitleDeck(),
                    const SizedBox(height: 10),
                    _buildImageURLField(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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

  TextFormField _buildTitleDeck() {
    return TextFormField(
      initialValue: '',
      decoration: const InputDecoration(
        labelText: 'Tên bộ thẻ',
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
        _addedDeck = _addedDeck.copyWith(title: value);
      },
    );
  }

  TextFormField _buildImageURLField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Đường dẫn ảnh nền',
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
        _addedDeck = _addedDeck.copyWith(imageBg: value);
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
      final deckManager = context.read<DecksManager>();

      deckManager.addDeck(_addedDeck);
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
