// @dart=2.9
// ig//
import 'package:flutter/material.dart';
import 'package:word_search/word_search.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  get newPuzzle => null;

  @override
  // ignore: no_logic_in_create_state
  State<Home> createState() => _HomeState(newPuzzle);
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController row = TextEditingController();
  TextEditingController column = TextEditingController();
  TextEditingController word = TextEditingController();
  // ignore: non_constant_identifier_names
  // List<String> letters = [
  //   'M',
  //   'A',
  //   'N',
  //   'G',
  //   'O',
  //   'I',
  //   'N',
  //   'D',
  //   'I',
  //   'A',
  //   'M',
  //   'A',
  //   'N',
  //   'G',
  //   'O',
  //   'I',
  //   'N',
  //   'D',
  //   'I',
  //   'A',
  //   'M',
  //   'A',
  //   'N',
  //   'G',
  //   'O',
  //   'I',
  //   'N',
  //   'D',
  //   'I',
  //   'A',
  //   'M',
  //   'A',
  //   'N',
  //   'G',
  //   'O',
  //   'I',
  //   'N',
  //   'D',
  //   'I',
  //   'A'
  // ];

  bool _isElevated = false;
  bool _isReset = false;
  int rowC = 5;
  int colC = 5;

  String wordSelect;
  final List<String> wl = [
    'INDIA',
    'MANGO',
    'EARTH',
    'MOBILE',
    'ALIVE',
    'DEATH',
    'EAT',
    'MILK',
    'BUTTER',
    'COCOA',
    'DONE',
    'MOBIGIC'
  ];
  // Create the puzzle sessting object

  final WordSearch wordSearch = WordSearch();
  WSNewPuzzle newPuzzle;
  List<String> letters = [];
  final List<String> cells = [];

  _HomeState(newPuzzle);

  initState() {
    // _controller = TextEditingController();
    generateRandomWord();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  // this words we want put on crossword game
  void generateRandomWord() {
    final WSSettings ws = WSSettings(
      width: rowC,
      height: colC,
      orientations: List.from([
        WSOrientation.horizontal,
        WSOrientation.vertical,
        WSOrientation.diagonal,
      ]),
    );
    newPuzzle = wordSearch.newPuzzle(wl, ws);
  }

  void solvePuzzle() {
    if (newPuzzle.errors.isEmpty) {
      // The puzzle output
      print('Puzzle 2D List');
      print(newPuzzle.puzzle.toString());

      // Solve puzzle for given word list
      print(wordSelect);
      final WSSolved solved =
          wordSearch.solvePuzzle(newPuzzle.puzzle, [wordSelect]);
      // All found words by solving the puzzle
      print('Found Words!');
      solved.found.forEach((element) {
        if (element.orientation == WSOrientation.horizontal) {
          for (var i = 0; i < element.word.length; i++) {
            cells
                .add((element.x + i).toString() + '-' + (element.y).toString());
          }
        } else {
          if (element.orientation == WSOrientation.vertical) {
            for (var i = 0; i < element.word.length; i++) {
              cells.add(
                  (element.x).toString() + '-' + (element.y + i).toString());
            }
          } else {
            if (element.orientation == WSOrientation.diagonal) {
              for (var i = 0; i < element.word.length; i++) {
                cells.add((element.x + i).toString() +
                    '-' +
                    (element.y + i).toString());
              }
            }
            print('word: ${element.word}, orientation: ${element.orientation}');
            print('x:${element.x}, y:${element.y}');
          }
        }
      });

      // All words that could not be found
      print('Not found Words!');
      solved.notFound.forEach((element) {
        print('word: ${element}');
      });
    } else {
      // Notify the user of the errors
      newPuzzle.errors.forEach((error) {
        print(error);
      });
    }
  }

  bool shouldhightlight(x, y) {
    return cells.contains(y.toString() + '-' + x.toString());
  }

  @override
  Widget build(BuildContext context) {
    print(generateRandomWord.toString());
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 5, 5, 5),
        appBar:
            AppBar(backgroundColor: Colors.black, title: Text("Mobigic Test")),
        body: SingleChildScrollView(
          child: _buildGameBody(),
        ));
  }

  Widget _buildGameBody() {
    int colC = newPuzzle.puzzle.length;
    return Column(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2.0)),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: rowC,
              ),
              itemBuilder: _buildGridItems,
              itemCount: colC * rowC,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: word,
            decoration: const InputDecoration(
                fillColor: Colors.white,
                filled: true,
                label: Text(
                  'Search..',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            wordSelect = word.text.toUpperCase();
            print(wordSelect);
            solvePuzzle();
            //    generateRandomWord();
            setState(() {
              _isElevated = !_isElevated;
            });
          },
          child: AnimatedContainer(
            child: Center(
                child: Text("Search",
                    style: TextStyle(fontWeight: FontWeight.bold))),
            duration: Duration(microseconds: 200),
            height: 50,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: _isElevated
                    ? [
                        const BoxShadow(
                            color: Colors.white10,
                            offset: Offset(4, 4),
                            blurRadius: 15,
                            spreadRadius: 1),
                        const BoxShadow(
                            color: Colors.white,
                            offset: const Offset(-4, -4),
                            blurRadius: 15,
                            spreadRadius: 1)
                      ]
                    : null),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text("Row"),
        TextField(
          controller: row,
          decoration: const InputDecoration(
              fillColor: Colors.white,
              filled: true,
              label: Text(
                'Search..',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Column",
        ),
        TextField(
          controller: column,
          decoration: const InputDecoration(
              fillColor: Colors.white,
              filled: true,
              label: Text(
                'Search..',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
        ),
        SizedBox(
          height: 20,
        ),
        FlatButton(
            onPressed: () {
              rowC = int.parse(row.text);
              colC = int.parse(column.text);
              setState(() {});
            },
            child: Container(
                color: Colors.purple,
                padding: EdgeInsets.all(20),
                child: Text("Add"))),
        GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
              (Route<dynamic> route) => false,
            );
          },
          child: AnimatedContainer(
            child: const Center(
                child: Text("Reset",
                    style: TextStyle(fontWeight: FontWeight.bold))),
            duration: const Duration(microseconds: 200),
            height: 50,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: _isReset
                    ? [
                        const BoxShadow(
                            color: Colors.white10,
                            offset: Offset(4, 4),
                            blurRadius: 15,
                            spreadRadius: 1),
                        const BoxShadow(
                            color: Colors.white,
                            offset: const Offset(-4, -4),
                            blurRadius: 15,
                            spreadRadius: 1)
                      ]
                    : null),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: TextField(
        //     controller: row,
        //     decoration: const InputDecoration(
        //         fillColor: Colors.white,
        //         filled: true,
        //         label: Text(
        //           'Row & Column ',
        //           style: TextStyle(
        //               color: Colors.black, fontWeight: FontWeight.bold),
        //         )),
        //   ),
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        // GestureDetector(
        //   onTap: () {
        //     rowC = int.parse(row.text);
        //     colC = int.parse(column.text);
        //     generateRandomWord();
        //     setState(() {});
        //   },
        //   child: AnimatedContainer(
        //     child: Center(
        //         child: Text("Add",
        //             style: TextStyle(
        //                 color: Colors.black, fontWeight: FontWeight.bold))),
        //     duration: Duration(microseconds: 200),
        //     height: 50,
        //     width: MediaQuery.of(context).size.width / 2,
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(30), color: Colors.white),
        //   ),
        // )
      ],
    );
  }

  Widget _buildGridItems(BuildContext context, int index) {
    int gridStateLength = newPuzzle.puzzle.length;
    int x, y = 0;
    x = (index / gridStateLength).floor();
    y = (index % gridStateLength);
    return GestureDetector(
      // onTap: () => _gridItemTapped(x, y),
      child: GridTile(
        child: Container(
          decoration: BoxDecoration(
              color: shouldhightlight(x, y) ? Colors.green : Colors.black,
              border: Border.all(width: 0.5)),
          child: Center(
            child: Text(
              newPuzzle.puzzle[x][y].toString().toUpperCase(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
