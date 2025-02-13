import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_generator/bottom.navigation.bar.dart';
import 'package:password_generator/generated/l10n.dart';
import 'package:password_generator/homepage_logic.dart';


class PasswordGeneratorPage extends StatefulWidget {
  final Function onLocaleChange;

  const PasswordGeneratorPage({super.key, required this.onLocaleChange});

  @override
  State<PasswordGeneratorPage> createState() => _PasswordGeneratorPageState();
}

class _PasswordGeneratorPageState extends State<PasswordGeneratorPage> {
  late PasswordLogic _passwordLogic;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _passwordLogic = PasswordLogic();
    _passwordLogic.openBox();
  }


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
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 14, right: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: TextEditingController(text: _passwordLogic.password),
                readOnly: true,
                style: const TextStyle(fontSize: 26, color: Colors.white),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                )
                ),
              ),
              const SizedBox(height: 29),
              Slider(
                value: _passwordLogic.passwordLength,
                inactiveColor: Colors.deepPurple.shade700,
                activeColor: Colors.white, 
                thumbColor: Colors.deepPurple.shade200,
                overlayColor:WidgetStateProperty.all(Colors.black.withOpacity(0.2)),
                min: 6,
                max: 20,
                divisions: 14,
                label: _passwordLogic.passwordLength.toInt().toString(),
                onChanged: (value) {
                  setState((){
                     _passwordLogic.setPasswordLength(value);
                });
                },
              ),
              CheckboxListTile(
              title: Text(S.of(context).uppercaseLetters, style:const TextStyle(color: Colors.white)),
              value: _passwordLogic.useUppercase,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                    _passwordLogic.setUseUppercase(value!);
                  });
                },
              ),

            CheckboxListTile(
              title: Text(S.of(context).lowercaseLetters, style:const TextStyle(color: Colors.white)),
              value: _passwordLogic.useLowercase,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                    _passwordLogic.setUseLowercase(value!);
                  });
                },
              ),

            CheckboxListTile(
              title: Text(S.of(context).numbers, style:const TextStyle(color: Colors.white)),
              value: _passwordLogic.useNumbers,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                    _passwordLogic.setUseNumbers(value!);
                  });
                },
              ),

            CheckboxListTile(
              title: Text(S.of(context).specialSymbols, style:const TextStyle(color: Colors.white)),
              value: _passwordLogic.useSpecial,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                    _passwordLogic.setUseSpecial(value!);
                  });
                },
              ),
              const SizedBox(height: 60),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: (){
                  widget.onLocaleChange(); 
                },
                    style:ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal:15, vertical: 15)),
                    child: const Icon(Icons.language, color: Colors.white)),
                    const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed:() {
                      showDialog(context: context, builder: (context) => SavePasswordDialog(
                        onSave: (name){
                      _passwordLogic.savePassword(name, _passwordLogic.password);
                      },
                      ),
                      );
                    },
                    style:ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal:15, vertical: 15)), 
                    child: const Icon(Icons.save, color: Colors.white)),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: _passwordLogic.password));
                      },
                      style:ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal:15, vertical: 15)),
                    child: const Icon(Icons.copy,color: Colors.white)),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _passwordLogic.generatePassword();
                      });
                    },
                  style:ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal:15, vertical: 15)), 
                  child: const Icon(Icons.play_arrow_outlined, color: Colors.white)),
                ],
              ),
            ]
        ),
        ),
      )
    );
  }
} 