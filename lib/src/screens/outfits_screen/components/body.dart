import 'package:flutter/material.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'package:tayt_app/src/screens/outfits_screen/components/outfit_card.dart';
import 'package:tuple/tuple.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);
  final _clothingItems = List.generate(100, (index) => 'Clothing ${index + 1}');

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 10),
            child: Text(
              'Ready to enter your changing room?\n\n Manage your outfits below, and \nchoose one to try on!',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.black,
                  fontFamily: 'Helvetica Neue',
                  fontSize: 16,
                  height: 1.2),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return OutfitCard(
                    outfitItems: Tuple2<Tuple3<String, String, String>,
                            Tuple3<String, String, String>>(
                        Tuple3<String, String, String>(
                            'assets/images/clothing/front${index + 1}.jpeg',
                            'Clothing ${index + 1}',
                            'Description ${index + 1}'),
                        Tuple3<String, String, String>(
                            'assets/images/clothing/front${24 - index - 5}.jpeg',
                            'Clothing ${24 - index - 5}',
                            'Description ${24 - index - 5}')),
                    numItems: 2);
              },
            ),
          ),
          SizedBox(height: 0),
        ],
      ),
    );
  }
}
