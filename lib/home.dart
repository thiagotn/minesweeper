import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sprintf/sprintf.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int played = 0;
  int score = 0;
  bool lose = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Campo Minado",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            fontFamily: 'BungeeShade',
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
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
                            "${sprintf("%03i", [score])}",
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
                          child: SvgPicture.asset((lose)
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
                            "${sprintf("%03i", [played])}",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: buildBoxDecorationIn(),
                  child: Container(
                    decoration: buildBoxDecorationIn(),
                    child: buildTable(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecorationScoreBoard() {
    return BoxDecoration(
      color: Colors.red.shade900,
      border: Border(
        top: BorderSide(color: Colors.red.shade50, width: 3.0),
        left: BorderSide(color: Colors.red.shade50, width: 3.0),
        bottom: BorderSide(color: Colors.red.shade300, width: 3.0),
        right: BorderSide(color: Colors.red.shade300, width: 3.0),
      ),
    );
  }

  BoxDecoration buildBoxDecorationIn() {
    return BoxDecoration(
      color: Color(0xffbcbcbc),
      border: Border(
        top: BorderSide(color: Colors.grey, width: 3.0),
        left: BorderSide(color: Colors.grey, width: 3.0),
        bottom: BorderSide(color: Colors.white, width: 3.0),
        right: BorderSide(color: Colors.white, width: 3.0),
      ),
    );
  }

  BoxDecoration buildBoxDecorationOut() {
    return BoxDecoration(
      color: Color(0xeeeeee),
      border: Border(
        top: BorderSide(color: Colors.white, width: 3.0),
        left: BorderSide(color: Colors.white, width: 3.0),
        bottom: BorderSide(color: Colors.grey, width: 3.0),
        right: BorderSide(color: Colors.grey, width: 3.0),
      ),
    );
  }

  Table buildTable() {
    return Table(
      children: buildRows(16, 16),
    );
  }

  List<TableRow> buildRows(int row, int col) {
    var items = List<TableRow>.filled(row, null);
    for (var i = 0; i < row; i++) {
      items[i] = TableRow(
        children: buildItems(i, col),
      );
    }
    return items;
  }

  List<Widget> buildItems(int rowIndex, int length) {
    List<Widget> widgets = List<Widget>.filled(length, null);
    for (var i = 0; i < length; i++) {
      widgets[i] = GestureDetector(
        child: Container(
          height: 25,
          width: 25,
          decoration: buildBoxDecorationOut(),
          child:
              (lose) ? SvgPicture.asset("assets/images/bomb.svg") : Container(),
        ),
        onTap: () {
          print("item [$rowIndex][$i] clicked!");
          setState(() {
            if (rowIndex == 0 && i == 0) {
              lose = !lose;
            }
            played++;
            score++;
          });
        },
      );
    }
    return widgets;
  }
}
