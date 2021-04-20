import 'package:flutter/material.dart';
import 'package:minesweeper/blocs/game.bloc.dart';
import 'package:minesweeper/themes/theme-simple.dart';
import 'package:minesweeper/widgets/game/actions.widget.dart';
import 'package:minesweeper/widgets/game/app-bar.widget.dart';
import 'package:minesweeper/widgets/game/game.widget.dart';
import 'package:minesweeper/widgets/game/scoreboard.widget.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gameAppBar(),
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Scoreboard(),
          SizedBox(
            height: 10,
          ),
          Game(),
          SizedBox(
            height: 10,
          ),
          // ResultWidget(),
          GameActions(),
        ],
      ),
    );
  }
}

// class ResultWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final bloc = Provider.of<GameBloc>(context);
//     return Visibility(
//       visible: bloc.win,
//       maintainSize: true,
//       maintainState: true,
//       maintainAnimation: true,
//       replacement: Container(),
//       child: Center(
//         child: GestureDetector(
//           onTap: bloc.restart(),
//           child: Container(
//             decoration: buildBoxDecorationOut(),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 "Parabéns! Recomeçar?",
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
