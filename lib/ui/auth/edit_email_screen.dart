import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screen.dart';

class EditEmailScreen extends StatefulWidget {
  static const routeName = '/edit_email';

  const EditEmailScreen({super.key});

  @override
  State<EditEmailScreen> createState() => _EditEmailScreenState();
}

class _EditEmailScreenState extends State<EditEmailScreen> {
  late String? userEmail;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSaving = false;

  @override
  void initState() {
    userEmail = context.read<AuthManager>().getEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Center(
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Căn giữa các children trong Row
            children: [
              Image.asset('assets/images/logo.png', height: 36),
            ],
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'CHỈNH SỬA EMAIL',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Form(
                  key: _formKey,
                  child: TextFormField(
                    initialValue: userEmail,
                    decoration: const InputDecoration(
                      labelText: 'Email của bạn',
                      filled: false,
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Email không hợp lệ!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      userEmail = value;
                    },
                  )),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ShortButton(
                  text: 'Lưu thay đổi',
                  onPressed: _isSaving ? null : () => _saveForm(),
                  isDisabled: _isSaving,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _saveForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    if (!mounted) return;
    setState(() {
      _isSaving = true;
    });

    try {
      await context.read<AuthManager>().changeEmail(userEmail!);
      await showSucessDialog(context, 'Email của bạn đã được thay đổi');
      Navigator.of(context).pop();
    } catch (error) {
      print("Lỗi xảy ra: $error");
      await showErrorDialog(context, 'Xin lỗi không thay đổi email');
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }
}
