import 'package:flutter/material.dart';

import 'page1.dart';
import 'page2.dart';
import 'page3.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final PageController pageController = PageController();

  final List<Widget> pages = const [Page1(), Page2(), Page3()];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: pageController,
          children: pages,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });

          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Page 1'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Page 2'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Page 3'),
        ],
      ),
    );
  }
}
