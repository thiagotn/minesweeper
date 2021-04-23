import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minesweeper/themes/theme.dart';

import 'game.page.dart';

class SplashPage extends StatelessWidget {
  Future delay(context) async {
    await new Future.delayed(
        new Duration(
          milliseconds: 3000,
        ), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => GamePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    delay(context);
    return Scaffold(
      body: Container(
        color: Color(0xffbcbcbc),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8.0, top: 8.0, bottom: 16.0),
                  child: Text(
                    "Campo Minado",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'TickingTimebombBB',
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: buildBoxDecorationOut(),
                  width: 80,
                  height: 80,
                  child: SvgPicture.asset("assets/images/face-smile.svg"),
                ),
                Container(
                  decoration: buildBoxDecorationOut(),
                  width: 80,
                  height: 80,
                  child: SvgPicture.asset("assets/images/flag.svg"),
                ),
                Container(
                  decoration: buildBoxDecorationOut(),
                  width: 80,
                  height: 80,
                  child: SvgPicture.asset("assets/images/mine.svg"),
                ),
                Container(
                  decoration: buildBoxDecorationOut(),
                  width: 80,
                  height: 80,
                  child: SvgPicture.asset("assets/images/face-sad.svg"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
