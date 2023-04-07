import 'package:flutter/material.dart';
import '../page/manage_post.dart';
import '../page/profile.dart';
import '../page/home_page.dart';
import '../page/post.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyPageController extends StatefulWidget {
  const MyPageController({super.key});

  @override
  State<MyPageController> createState() => _MyPageControllerState();
}

class _MyPageControllerState extends State<MyPageController> {
  int _selectedIndex = 0;
  Color? selectedColor = Colors.black;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = [
    HomePage(),
    ManagePost(),
    Post(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_filled),
            label: appLocalizations?.labelHome ?? '',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.article_outlined),
            label: appLocalizations?.managePosts ?? '',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.post_add),
            label: appLocalizations?.createPost ?? '',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: appLocalizations?.person ?? '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: selectedColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
