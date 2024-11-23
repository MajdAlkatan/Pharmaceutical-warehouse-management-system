import 'package:app5/generated/l10n.dart';
import 'package:app5/widget/customecard.dart';
import 'package:flutter/material.dart';

class favorite extends StatelessWidget {
  const favorite({super.key});
  static String id = 'fav';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).myFavorites,
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontFamily: 'Merienda',
          ),
        ),
        backgroundColor: Color(0xff1B185B),
      ),
      backgroundColor: Color(0xff1B185B),
      body: FavoriteCard(),
    );
  }
}
