import 'package:flutter/material.dart';
import 'package:minesweeper/blocs/game.bloc.dart';
import 'package:minesweeper/blocs/game.config.dart';
import 'package:minesweeper/pages/game.page.dart';
import 'package:minesweeper/themes/theme.dart';
import 'package:minesweeper/widgets/game/app-bar.widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<GameBloc>(context);
    return Scaffold(
      appBar: gameAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 220,
              decoration: buildBoxDecorationOut(),
              child: TextButton(
                onPressed: () => {
                  print("fácil"),
                  bloc.select(EASY),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GamePage(),
                    ),
                  ),
                },
                child: Text(
                  "Facil ($easyRows X $easyColumns)",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'TickingTimebombBB',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 220,
              decoration: buildBoxDecorationOut(),
              child: TextButton(
                onPressed: () => {
                  print("intermediário"),
                  bloc.select(MEDIUM),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GamePage(),
                    ),
                  ),
                },
                child: Text(
                  "Intermediario ($mediumRows X $mediumColumns)",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'TickingTimebombBB',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 220,
              decoration: buildBoxDecorationOut(),
              child: TextButton(
                onPressed: () => {
                  print("difícil"),
                  bloc.select(HARD),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GamePage(),
                    ),
                  ),
                },
                child: Text(
                  "Dificil ($hardRows X $hardColumns)",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'TickingTimebombBB',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
