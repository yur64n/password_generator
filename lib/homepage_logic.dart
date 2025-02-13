import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:password_generator/generated/l10n.dart';
import 'hive.adapter.dart'; 

class PasswordLogic {
  late Box<SavedPassword> _passwordBox;

  String _password = '';
  double _passwordLength = 6;
  bool _useUppercase = true;
  bool _useLowercase = true;
  bool _useNumbers = true;
  bool _useSpecial = true;

  String get password => _password;
  double get passwordLength => _passwordLength;
  bool get useUppercase => _useUppercase;
  bool get useLowercase => _useLowercase;
  bool get useNumbers => _useNumbers;
  bool get useSpecial => _useSpecial;

  Future<void> openBox() async {
    _passwordBox = await Hive.openBox<SavedPassword>('passwords');
  }

  void generatePassword() {
    if (!_useUppercase && !_useLowercase && !_useNumbers && !_useSpecial) {
      _password = '';
      return;
    }
    _password = PasswordGenerator.generate(
      length: _passwordLength.toInt(),
      useUppercase: _useUppercase,
      useLowercase: _useLowercase,
      useNumbers: _useNumbers,
      useSpecial: _useSpecial,
    );
  }

void savePassword(String name, String password) {
if (name.isEmpty || password.isEmpty) {
    return;
  }
  _passwordBox.add(SavedPassword(name: name, password: password));
}

  void setPasswordLength(double length) {
    _passwordLength = length;
  }

  void setUseUppercase(bool value) {
    _useUppercase = value;
  }

  void setUseLowercase(bool value) {
    _useLowercase = value;
  }

  void setUseNumbers(bool value) {
    _useNumbers = value;
  }

  void setUseSpecial(bool value) {
    _useSpecial = value;
  }
}
class SavePasswordDialog extends StatefulWidget {
  final Function(String) onSave;

  const SavePasswordDialog({super.key, required this.onSave});

  @override
  SavePasswordDialogState createState() => SavePasswordDialogState();
}

class SavePasswordDialogState extends State<SavePasswordDialog> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).enterANameForThePassword),
      content: TextField(
        controller: nameController,
        decoration: InputDecoration(labelText: S.of(context).name),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); 
          },
          child: Text(S.of(context).cancel),
        ),
        TextButton(
          onPressed: () {
            if (nameController.text.isNotEmpty) {
              widget.onSave(nameController.text); 
              Navigator.pop(context); 
            }
          },
          child: Text(S.of(context).save),
        ),
      ],
    );
  }
}

class PasswordGenerator {
  static String generate({
    required int length,
    required bool useUppercase,
    required bool useLowercase,
    required bool useNumbers,
    required bool useSpecial,
  }) {
    const String uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const String lowercase = 'abcdefghijklmnopqrstuvwxyz';
    const String numbers = '0123456789';
    const String special = '!@#\$%^&*()_+-=[]{}|;:",.<>?/';

    String chars = '';
    if (useUppercase) chars += uppercase;
    if (useLowercase) chars += lowercase;
    if (useNumbers) chars += numbers;
    if (useSpecial) chars += special;

    if (chars.isEmpty) return '';

    return List.generate(
      length,
      (index) => chars[Random().nextInt(chars.length)],
    ).join();
  }
}