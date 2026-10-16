import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Teks di paling atas (SafeArea test)',
          ),
        ),

        const Center(
          child: Text('Page 2'),
        ),
      ],
    );
  }
}