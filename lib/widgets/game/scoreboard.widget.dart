import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minesweeper/blocs/game.bloc.dart';
import 'package:minesweeper/themes/theme.dart';
import 'package:provider/provider.dart';

class Scoreboard extends StatelessWidget {
  final double? width;
  
  const Scoreboard({Key? key, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<GameBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width, // Use specified width if provided
        decoration: buildBoxDecorationIn(),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = constraints.maxWidth * 0.35;
            final itemHeight = itemWidth * 0.5;
            final fontSize = itemHeight * 0.5;
            final iconHeight = itemHeight * 0.4;

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    width: itemWidth,
                    height: itemHeight,
                    alignment: Alignment.center,
                    decoration: buildBoxDecorationScoreBoard(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/images/mine.svg",
                                  color: Colors.red,
                                  height: iconHeight,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "${bloc.mines}",
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'TickingTimebombBB',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => bloc.restart(),
                    child: Container(
                      width: itemHeight,
                      height: itemHeight,
                      alignment: Alignment.center,
                      decoration: buildBoxDecorationOut(),
                      child: SvgPicture.asset(
                        (bloc.lose)
                            ? "assets/images/face-sad.svg"
                            : "assets/images/face-smile.svg",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: itemWidth,
                    height: itemHeight,
                    alignment: Alignment.center,
                    decoration: buildBoxDecorationScoreBoard(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/images/timer.svg",
                                  color: Colors.red,
                                  height: iconHeight,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "${_printDuration(Duration(seconds: bloc.seconds.toInt()))}",
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'TickingTimebombBB',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
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
