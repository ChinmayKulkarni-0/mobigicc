// ignore_for_file: deprecated_member_use, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:word_search/word_search.dart';
import 'Crossword.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController row = TextEditingController();
  TextEditingController column = TextEditingController();
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
  int rowC = 5;
  int colC = 5;
  final List<String> wl = ['hello', 'world', 'foo', 'bar', 'baz', 'dart'];
  // Create the puzzle sessting object

  final WordSearch wordSearch = WordSearch();
  late final WSNewPuzzle newPuzzle;
  List<String> letters = [];
  initState() {
    generateRandomWord();
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
    for (var i = 0; i < newPuzzle.puzzle.length; i++) {
      letters = letters + newPuzzle.puzzle[i];
    }
    if (newPuzzle.errors.isEmpty) {
      // The puzzle output
      print('Puzzle 2D List');
      print(newPuzzle.puzzle.toString());

      // Solve puzzle for given word list
      final WSSolved solved =
          wordSearch.solvePuzzle(newPuzzle.puzzle, ['hello', 'foo']);
      // All found words by solving the puzzle
      print('Found Words!');
      solved.found.forEach((element) {
        print('word: ${element.word}, orientation: ${element.orientation}');
        print('x:${element.x}, y:${element.y}');
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

  @override
  Widget build(BuildContext context) {
    print(generateRandomWord.toString());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("search"),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: MySearchDelegate());
              },
              icon: Icon(Icons.search))
        ],
      ),
      //  key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  //  height: MediaQuery.of(context).size.height/1.6,
                  child: GridView.builder(
                      itemCount: rowC * colC,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: rowC,
                          childAspectRatio: colC * rowC / 30,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      shrinkWrap: true,
                      //String char = listChars.value.expand((e) => e).toList()[index];
                      itemBuilder: (context, index) {
                        String char = letters.toList()[index];
                        return Container(
                            child: Center(
                              child: Text(char),
                            ),
                            color: Color.fromARGB(255, 251, 255, 253));
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: row,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      label: Text(
                        'Column',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      label: Text(
                        'Row',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  controller: column,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  rowC = int.parse(row.text);
                  colC = int.parse(column.text);

                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Home()));
                  setState(() {
                    _isElevated = !_isElevated;
                    generateRandomWord();
                  });
                },
                child: AnimatedContainer(
                  child: Center(
                      child: Text("Add",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  duration: Duration(microseconds: 200),
                  height: 50,
                  width: 80,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
