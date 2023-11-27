import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 200,
          vertical: 14,
        ),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 100, 72, 92),
        ),
        child: Text(
          'Tayt',
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: Colors.white,
              ),
        )
        // Add your content here
        );
  }
}
