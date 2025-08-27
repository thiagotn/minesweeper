import 'package:flutter/material.dart';
import 'package:minesweeper/blocs/game.bloc.dart';
import 'package:minesweeper/themes/theme.dart';
import 'package:provider/provider.dart';

class GameActions extends StatelessWidget {
  final double? width;
  
  const GameActions({Key? key, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<GameBloc>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Visibility(
        visible: (bloc.lose || bloc.win),
        maintainState: false,
        maintainAnimation: false,
        maintainSize: false,
        replacement: Container(width: width), // Apply width to replacement as well
        child: Container(
          width: width, // Use specified width if provided
          decoration: buildBoxDecorationIn(),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: buildBoxDecorationOut(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            bloc.win
                                ? "Parabéns! Recomeçar?"
                                : bloc.lose
                                    ? "Você perdeu! Recomeçar?"
                                    : "Iniciar",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'TickingTimebombBB',
                                color: bloc.win ? Colors.green : Colors.black),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      print("clicando em restart...");
                      bloc.restart();
                    },
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
