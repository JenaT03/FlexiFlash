import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/flashcard.dart';
import '../screen.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddFlashCardScreen extends StatefulWidget {
  static const routeName = '/add_flashcard';
  final String deckId;
  AddFlashCardScreen(Flashcard? flashcard, {super.key, required this.deckId}) {
    if (flashcard == null) {
      this.flashcard =
          Flashcard(text: '', description: '', language: '', deckId: '');
    } else {
      this.flashcard = flashcard;
    }
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
  late String _deckId;
  bool _isSaving = false;

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
    _deckId = widget.deckId;
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
        margin: EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Column(
          children: [
            Text(
              getTitle().toUpperCase(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Form(
                key: _addForm,
                child: ListView(
                  children: <Widget>[
                    _buildSelectLangue(),
                    const SizedBox(height: 20),
                    _buildTitleflashcard(),
                    const SizedBox(height: 20),
                    _buildFlashCardPreview(),
                    const SizedBox(height: 20),
                    _buildDescriptionField()
                  ],
                ),
              ),
            ),
            _addedflashcard.id == null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShortButton(
                        text: "Hoàn thành",
                        onPressed: _isSaving ? null : () => _saveForm('finish'),
                        isDisabled: _isSaving,
                      ),
                      ShortButton(
                        text: "Tiếp tục",
                        onPressed: _isSaving ? null : () => _saveForm('next'),
                        isDisabled: _isSaving,
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ShortButton(
                        text: "Lưu",
                        onPressed:
                            _isSaving ? null : () => _saveForm('save edit'),
                        isDisabled: _isSaving,
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }

  String getTitle() {
    String title = '';
    final deckManager = context.read<DecksManager>();
    final deck = deckManager.findById(_deckId);
    title = deck!.title;
    return title;
  }

  TextFormField _buildTitleflashcard() {
    return TextFormField(
      initialValue: _addedflashcard.text,
      decoration: const InputDecoration(
        labelText: 'Tên thẻ',
        filled: false,
        border: OutlineInputBorder(),
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

  Widget _buildSelectLangue() {
    String selectedLanguage = 'vi-VN';
    _addedflashcard.language.isNotEmpty
        ? selectedLanguage = _addedflashcard.language
        : 'vi-VN';
    return DropdownButtonFormField<String>(
      value: selectedLanguage,
      decoration: InputDecoration(
        labelText: "Chọn ngôn ngữ",
        filled: false,
        border: OutlineInputBorder(),
      ),
      items: const [
        DropdownMenuItem(value: "vi-VN", child: Text("Tiếng Việt")),
        DropdownMenuItem(value: "en-GB", child: Text("Tiếng Anh")),
        DropdownMenuItem(value: "fr-FR", child: Text("Tiếng Pháp")),
        DropdownMenuItem(value: "de-DE", child: Text("Tiếng Đức")),
        DropdownMenuItem(value: "es-ES", child: Text("Tiếng Tây Ban Nha")),
        DropdownMenuItem(value: "ja-JP", child: Text("Tiếng Nhật")),
        DropdownMenuItem(value: "ko_KR", child: Text("Tiếng Hàn")),
        DropdownMenuItem(value: "zh-CN", child: Text("Tiếng Trung")),
        DropdownMenuItem(value: "ru_RU", child: Text("Tiếng Nga")),
      ],
      validator: (value) => value == null ? 'Vui lòng chọn một giá trị' : null,
      onChanged: (value) {
        setState(() {
          selectedLanguage = value!;
        });
      },
      onSaved: (value) {
        _addedflashcard = _addedflashcard.copyWith(language: value);
      },
    );
  }

  Widget _buildFlashCardPreview() {
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
          child: !_addedflashcard.hasImage()
              ? const Center(child: Text('Trống'))
              : FittedBox(
                  child: _addedflashcard.imageFile != null
                      ? Image.file(
                          _addedflashcard.imageFile!,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          _addedflashcard.imgURL,
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
          _addedflashcard = _addedflashcard.copyWith(
            imageFile: File(imageFile.path),
            imgURL: imageFile.path,
          );
          setState(() {});
        } catch (error) {
          if (mounted) {
            await showErrorDialog(context, 'Lỗi không thể chọn ảnh');
          }
        }
      },
    );
  }

  TextFormField _buildDescriptionField() {
    return TextFormField(
      initialValue: _addedflashcard.description,
      decoration: const InputDecoration(
        labelText: 'Mô tả',
        filled: false,
        border: OutlineInputBorder(),
      ),
      maxLines: 8,
      keyboardType: TextInputType.multiline,
      onSaved: (value) {
        _addedflashcard = _addedflashcard.copyWith(description: value);
      },
    );
  }

  Future<void> _saveForm(String text) async {
    final isValid =
        _addForm.currentState!.validate() && _addedflashcard.hasImage();
    if (!isValid) {
      await showInforDialog(
          context, 'Có vấn đề với nội dung của bạn, vui lòng xem lại');
      return;
    }

    if (!mounted) return; // Kiểm tra trước khi gọi setState
    setState(() {
      _isSaving = true;
    });

    _addForm.currentState!.save();
    try {
      final flashcardManager = context.read<FlashcardManager>();

      if (_addedflashcard.id == null) {
        await flashcardManager.addFlashcard(_deckId, _addedflashcard);
      } else {
        await flashcardManager.updateFlashcard(_addedflashcard, _deckId);
      }

      if (!mounted) return;

      if (text == 'next') {
        Navigator.of(context).pushNamed(
          AddFlashCardScreen.routeName,
          arguments: {'deckId': _deckId},
        );
      } else if (text == 'finish') {
        int count = await flashcardManager.countFlashcardsInDeck(_deckId);
        await showFinishDialog(context, count, _deckId);
      } else {
        Navigator.of(context).pushReplacementNamed(
          EditFlashcardListScreen.routeName,
          arguments: _deckId,
        );
      }
    } catch (error) {
      if (mounted) {
        await showErrorDialog(context, 'Xin lỗi không thể lưu thẻ này');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Future<void> showFinishDialog(BuildContext context, int count, String id) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Hoàn thành 🎉',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Text(
              'Bộ thẻ đã có $count thẻ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Bạn muốn đi đến bộ thẻ này hay trở về trang chủ?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustTextButton(
                text: "Xem bộ thẻ",
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  DeckDetailScreen.routeName,
                  arguments: id,
                  (route) => false,
                ),
              ),
              CustFilledButton(
                text: "Trở về",
                onPressed: () {
                  Navigator.of(ctx).pushNamedAndRemoveUntil(
                    UserDecksScreen.routeName,
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
}
