import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../decks/decks_manager.dart';
import '../../models/deck.dart';
import '../screen.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddDeckScreen extends StatefulWidget {
  static const routeName = '/add_deck';
  AddDeckScreen({super.key});
  final Deck deck = Deck(title: '', type: '');
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
                key: _addForm,
                child: ListView(
                  children: <Widget>[
                    _buildTitleDeck(),
                    const SizedBox(height: 20),
                    _buildSelectType(),
                    const SizedBox(height: 20),
                    _buildProductPreview(),
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

  Widget _buildSelectType() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: "Chọn chủ đề",
        filled: false,
        border: OutlineInputBorder(),
      ),
      items: const [
        DropdownMenuItem(value: "Sinh học", child: Text("Sinh học")),
        DropdownMenuItem(value: "Vật lý", child: Text("Vật lý")),
        DropdownMenuItem(value: "Hóa học", child: Text("Hóa học")),
        DropdownMenuItem(value: "Lịch sử", child: Text("Lịch sử")),
        DropdownMenuItem(value: "Địa lý", child: Text("Địa lý")),
      ],
      validator: (value) => value == null ? 'Vui lòng chọn một giá trị' : null,
      onChanged: (value) {
        setState(() {});
      },
      onSaved: (value) {
        _addedDeck = _addedDeck.copyWith(type: value);
      },
    );
  }

  Widget _buildProductPreview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(top: 8, right: 10),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: !_addedDeck.hasImage()
              ? const Center(child: Text('Trống'))
              : FittedBox(
                  child: Image.file(
                    _addedDeck.imageBgFile!,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        Expanded(
          child: SizedBox(
            height: 100,
            child: _buildImagePickerButton(),
          ),
        ),
      ],
    );
  }

  TextButton _buildImagePickerButton() {
    return TextButton.icon(
      icon: const Icon(Icons.image),
      label: const Text('Chọn hình ảnh'),
      onPressed: () async {
        final imagePicker = ImagePicker();
        try {
          final imageFile =
              await imagePicker.pickImage(source: ImageSource.gallery);
          if (imageFile == null) {
            return;
          }
          _addedDeck = _addedDeck.copyWith(
            imageBgFile: File(imageFile.path),
            imageBg: imageFile.path,
          );
          setState(() {});
        } catch (error) {
          if (mounted) {
            showErrorDialog(context, 'Something went wrong');
          }
        }
      },
    );
  }

  Future<void> _saveForm() async {
    final isValid = _addForm.currentState!.validate();

    if (!isValid) {
      return;
    }
    _addForm.currentState!.save();
    final File? ex = _addedDeck.imageBgFile;
    print('_addedDeck $ex');

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
                title: const Text('Lỗi trong quá trình lưu!'),
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
