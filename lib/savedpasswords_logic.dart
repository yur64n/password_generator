import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:password_generator/generated/l10n.dart';
import 'package:password_generator/hive.adapter.dart';


class EditPasswordDialog extends StatelessWidget {
  final int index;
  final SavedPassword password;
  final Function(SavedPassword) onSave;

  const EditPasswordDialog({
    super.key,
    required this.index,
    required this.password,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: password.name);
    TextEditingController passwordController = TextEditingController(text: password.password);

    return AlertDialog(
      title: Text(S.of(context).editPassword),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: nameController, decoration: InputDecoration(labelText: S.of(context).name)),
          TextField(controller: passwordController, decoration: InputDecoration(labelText: S.of(context).password)),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text(S.of(context).cancel)),
        TextButton(
          onPressed: () {
            final updatedPassword = SavedPassword(name: nameController.text, password: passwordController.text);
            onSave(updatedPassword); 
            Navigator.pop(context);
          },
          child: Text(S.of(context).save),
        ),
      ],
    );
  }
}
class PasswordList extends StatelessWidget {
  final Box<SavedPassword> passwordBox;
  final Function(int) onEdit;
  final Function(int) onDelete;

  const PasswordList({
    super.key,
    required this.passwordBox,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: passwordBox.length,
      itemBuilder: (context, index) {
        final password = passwordBox.getAt(index);
        return ListTile(
          shape: BeveledRectangleBorder(
            side: BorderSide(color: Colors.deepPurple.shade600, width: 1),
          ),
          title: Text(password?.name ?? S.of(context).untitled, overflow: TextOverflow.ellipsis,),
          subtitle: Text(password?.password ?? '', overflow: TextOverflow.ellipsis,),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(icon: const Icon(Icons.edit), onPressed: () => onEdit(index)),
              IconButton(icon: const Icon(Icons.delete), onPressed: () => onDelete(index)),
              IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: password?.password ?? ''));
                },
                icon: const Icon(Icons.copy),
              ),
            ],
          ),
        );
      },
    );
  }
}