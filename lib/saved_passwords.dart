import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:password_generator/bottom.navigation.bar.dart';
import 'package:password_generator/hive.adapter.dart';
import 'package:password_generator/savedpasswords_logic.dart';

class SavedPasswordsPage extends StatefulWidget {
  const SavedPasswordsPage({super.key});

  @override
  SavedPasswordsPageState createState() => SavedPasswordsPageState();
}

class SavedPasswordsPageState extends State<SavedPasswordsPage> {
  final Box<SavedPassword> _passwordBox = Hive.box<SavedPassword>('passwords');

  void _editPassword(int index) {
    var password = _passwordBox.getAt(index);
    if (password == null) return;


    showDialog(
      context: context,
      builder: (context) => EditPasswordDialog(
        index: index,
        password: password,
        onSave: (updatedPassword) {
          _passwordBox.putAt(index, updatedPassword);
          setState(() {});
        },
      ),
    );
  }

  void _deletePassword(int index) {
    _passwordBox.deleteAt(index);
    setState(() {});
  }

  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade900,
      bottomNavigationBar: CustomNavigationBar(
  selectedIndex: selectedIndex,
  onItemTapped: (index){
    setState(() {
      selectedIndex = index;
    });
    TwoButtonNavigation.onItemTapped(context, index);
  }
),
      body: SafeArea(
          child: PasswordList(
          passwordBox: _passwordBox,
          onEdit: _editPassword,
          onDelete: _deletePassword,
        ),
      ),
    );
  }
}