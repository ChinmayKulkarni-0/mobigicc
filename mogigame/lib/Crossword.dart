// // import 'package:flutter/material.dart';
// // import 'package:word_search/word_search.dart';

// // /**
// //  * The main file to test out the word search library
// //  */
// // class Search extends StatefulWidget {
// //   const Search({Key? key}) : super(key: key);

// //   @override
// //   State<Search> createState() => _SearchState();
// // }

// // class _SearchState extends State<Search> {

// // // final List<List<String>> newPuzzle = [
// // //     ["a", "b", "c"],
// // //     ["e", "f", "g"]
// // //   ];
// //   @override
// //   void initState() {
// //     final WSNewPuzzle newPuzzle = wordSearch.newPuzzle(wl, ws);
// //     if (newPuzzle.errors.isEmpty) {
// //       // The puzzle output
// //       print('Puzzle 2D List');
// //       print(newPuzzle.puzzle.toString());

// //       // Solve puzzle for given word list
// //       final WSSolved solved =
// //           wordSearch.solvePuzzle(newPuzzle.puzzle, ['hello', 'foo']);
// //       // All found words by solving the puzzle
// //       print('Found Words!');
// //       solved.found.forEach((element) {
// //         print('word: ${element.word}, orientation: ${element.orientation}');
// //         print('x:${element.x}, y:${element.y}');
// //       });

// //       // All words that could not be found
// //       print('Not found Words!');
// //       solved.notFound.forEach((element) {
// //         print('word: ${element}');
// //       });
// //     } else {
// //       // Notify the user of the errors
// //       newPuzzle.errors.forEach((error) {
// //         print(error);
// //       });
// //     }
// //     super.initState();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     // TODO: implement build
// //     return Scaffold(
// //       body: GestureDetector(
// //           onTap: () {
// //             //   print(newPuzzle.toString());
// //           },
// //           child: Container(
// //             height: 50,
// //             width: 50,
// //             color: Colors.white,
// //           )),
// //     );
// //   }
// // }
// //    // Create a list of words to be jumbled into a puzzle
// import 'package:flutter/material.dart';
// import 'package:flutter_search_bar/flutter_search_bar.dart';

// class SearchBarDemoApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//         title: 'Search Bar Demo',
//         theme: new ThemeData(primarySwatch: Colors.blue),
//         home: new SearchBarDemoHome());
//   }
// }

// class SearchBarDemoHome extends StatefulWidget {
//   @override
//   _SearchBarDemoHomeState createState() => new _SearchBarDemoHomeState();
// }

// class _SearchBarDemoHomeState extends State<SearchBarDemoHome> {
//   SearchBar searchBar;
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//   AppBar buildAppBar(BuildContext context) {
//     return new AppBar(
//         title: new Text('Search Bar Demo'),
//         actions: [searchBar.getSearchAction(context)]);
//   }

//   void onSubmitted(String value) {
//     setState(() => _scaffoldKey.currentState
//         ?.showSnackBar(new SnackBar(content: new Text('You wrote $value!'))));
//   }

//   _SearchBarDemoHomeState() {
//     searchBar = new SearchBar(
//         inBar: false,
//         buildDefaultAppBar: buildAppBar,
//         setState: setState,
//         onSubmitted: onSubmitted,
//         onCleared: () {
//           print("cleared");
//         },
//         onClosed: () {
//           print("closed");
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: searchBar.build(context),
//       key: _scaffoldKey,
//       body: new Center(
//           child: new Text("Don't look at me! Press the search button!")),
//     );
//   }
// }
import 'package:flutter/material.dart';

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Center(
      child: Text(
        query,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Container();
  }
}
