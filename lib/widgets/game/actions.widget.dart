import 'package:flutter/material.dart';
import 'package:minesweeper/blocs/game.bloc.dart';
import 'package:minesweeper/themes/theme.dart';
import 'package:provider/provider.dart';

class GameActions extends StatelessWidget {
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
        replacement: Container(),
        child: Container(
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
