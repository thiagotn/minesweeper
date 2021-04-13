import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minesweeper/blocs/game.bloc.dart';
import 'package:minesweeper/themes/theme.dart';
import 'package:provider/provider.dart';
import 'package:sprintf/sprintf.dart';

class Scoreboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<GameBloc>(context);
    return Container(
      decoration: buildBoxDecorationIn(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              alignment: Alignment.center,
              width: 90,
              height: 60,
              decoration: buildBoxDecorationScoreBoard(),
              child: Text(
                "${sprintf("%03i", [bloc.score])}",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              width: 50,
              height: 60,
              decoration: buildBoxDecorationOut(),
              child: SvgPicture.asset((bloc.lose)
                  ? "assets/images/face-sad.svg"
                  : "assets/images/face-smile.svg"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              width: 90,
              height: 60,
              decoration: buildBoxDecorationScoreBoard(),
              child: Text(
                "${sprintf("%03i", [bloc.played])}",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
