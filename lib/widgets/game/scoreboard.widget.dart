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
              width: 110,
              alignment: Alignment.center,
              decoration: buildBoxDecorationScoreBoard(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${sprintf("%04i", [bloc.score])}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              decoration: buildBoxDecorationOut(),
              child: SvgPicture.asset((bloc.lose)
                  ? "assets/images/face-sad.svg"
                  : "assets/images/face-smile.svg"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 110,
              alignment: Alignment.center,
              decoration: buildBoxDecorationScoreBoard(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${_printDuration(Duration(seconds: bloc.seconds.toInt()))}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours > 0) {
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
