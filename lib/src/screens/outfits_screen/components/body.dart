import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tayt_app/src/deps/colors.dart';
import 'package:tayt_app/src/screens/outfits_screen/components/outfit_card.dart';
import 'package:tuple/tuple.dart';
import '../../../../provider/outfit_provider.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);
  final _clothingItems = List.generate(100, (index) => 'Clothing ${index + 1}');

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    OutfitProvider outfitProvider = Provider.of<OutfitProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: outfitProvider.outfits.length > 0
              ? [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 10),
                    child: Text(
                      'Manage your outfits below, and \nchoose one to try on!',
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
                      itemCount: outfitProvider.outfits.length,
                      itemBuilder: (context, index) {
                        final outfit = outfitProvider.outfits[index];
                        final numItems = outfit.items.length;
                        return OutfitCard(outfit: outfit, numItems: numItems);
                      },
                    ),
                  ),
                ]
              : [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 10),
                    child: Text(
                      'You have no outfits yet. \nGo to a clothing item and create one now!',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.black,
                          fontFamily: 'Helvetica Neue',
                          fontSize: 16,
                          height: 1.2),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // icon
                  Expanded(
                    child: Center(
                      child: Transform.rotate(
                        angle: pi / 4,
                        child: Icon(
                          Icons.add_circle,
                          size: 150,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ]),
    );
  }
}
