import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/deck.dart';
import '../screen.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddDeckScreen extends StatefulWidget {
  static const routeName = '/add_deck';
  AddDeckScreen(Deck? deck, {super.key}) {
    if (deck == null) {
      this.deck = Deck(title: '', type: '');
    } else {
      this.deck = deck;
    }
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
        centerTitle: true,
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
            _addedDeck.id == null
                ? const Text(
                    'TẠO BỘ THẺ MỚI',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  )
                : const Text(
                    'CHỈNH SỬA BỘ THẺ',
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
                    const SizedBox(height: 30),
                    _buildSelectType(),
                    const SizedBox(height: 30),
                    _buildDeckPreview(),
                  ],
                ),
              ),
            ),
            _addedDeck.id == null
                ? Row(
                    children: [
                      Spacer(),
                      ShortButton(
                        text: "Tiếp tục",
                        onPressed: _saveForm,
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShortButton(
                        text: 'Chỉnh sửa thẻ',
                        onPressed: () => Navigator.of(context).pushNamed(
                            EditFlashcardListScreen.routeName,
                            arguments: _addedDeck.id),
                      ),
                      ShortButton(
                        text: "Lưu",
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
      initialValue: _addedDeck.title,
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
      value: _addedDeck.type.isNotEmpty ? _addedDeck.type : null,
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

  Widget _buildDeckPreview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: !_addedDeck.hasImage()
              ? const Center(child: Text('Trống'))
              : FittedBox(
                  child: _addedDeck.imageBgFile != null
                      ? Image.file(
                          _addedDeck.imageBgFile!,
                          fit: BoxFit.cover,
                        )
                      : Image.network(_addedDeck.imageBg, fit: BoxFit.cover),
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
    final isValid = _addForm.currentState!.validate() && _addedDeck.hasImage();

    if (!isValid) {
      await showInforDialog(
          context, 'Có vấn đề với nội dung của bạn, vui lòng xem lại');
      return;
    }
    _addForm.currentState!.save();

    try {
      final deckManager = context.read<DecksManager>();
      if (_addedDeck.id == null) {
        String? deckId = await deckManager.addDeck(_addedDeck);
        if (mounted) {
          Navigator.of(context).pushNamed(AddFlashCardScreen.routeName,
              arguments: {'deckId': deckId});
        }
      } else {
        String? deckId = await deckManager.updateDeck(_addedDeck);
        FocusScope.of(context).unfocus();
        await Future.delayed(Duration(milliseconds: 200));
        if (mounted) {
          Navigator.of(context).pushNamed(
            DeckDetailScreen.routeName,
            arguments: deckId,
          );
        }
      }
    } catch (error) {
      print("Lỗi xảy ra: $error");
      await showErrorDialog(context, 'Xin lỗi không thể lưu bộ thẻ này');
    }
  }
}
