import 'package:flutter/material.dart';
import 'package:password_generator/generated/l10n.dart';


class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.deepPurple.shade600,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white60,
      currentIndex: selectedIndex,
      onTap: (index) {
        onItemTapped(index);
        if (index == 1) {
          Navigator.of(context).pushNamed('/saved');
        } else if (index == 0) {
          Navigator.of(context).pushNamed('/homepage');
        }
      },
      items: [
        BottomNavigationBarItem(icon: const Icon(Icons.password), label: S.of(context).generate),
        BottomNavigationBarItem(icon: const Icon(Icons.save), label: S.of(context).saved),
      ],
    );
  }
}

  class TwoButtonNavigation {
  static void onItemTapped(BuildContext context, int index) {
    if (index == 1) {
      Navigator.of(context).pushNamed('/saved');
    } else if (index == 0) {
      Navigator.of(context).pushNamed('/homepage');
    }
  }
}
