// Square Values
const String empty = "-";
const String hasMine = "X";
const String hasFlag = "F";
const String opened = "0";

const String EASY = "EASY";
const String MEDIUM = "MEDIUM";
const String HARD = "HARD";

class Level {
  static int rows = 16;
  static int columns = 16;
  static int mines = 30;

  static setLevel(String level) {
    switch (level) {
      case EASY:
        rows = 3;
        columns = 3;
        mines = 3;
        break;
      case MEDIUM:
        rows = 16;
        columns = 16;
        mines = 30;
        break;
      case HARD:
        rows = 30;
        columns = 30;
        mines = 30;
        break;
      default:
        rows = 16;
        columns = 16;
        mines = 30;
        break;
    }
  }
}
