import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:risk/gameLayer/Tile.dart';
import 'package:risk/gameLayer/globalVars.dart';
import 'package:risk/models/gameStateObjects/gameState.dart';
import 'package:risk/src/utils/serviceProviders.dart';
import 'package:risk/models/gameStateObjects/gameBoard.dart' as gb;
import 'package:risk/models/gameStateObjects/tile.dart' as t;
import 'package:risk/src/utils/toaster.dart';
import 'Tile.dart';


class GameBoard extends StatefulWidget {
  GameBoard({Key key, this.title}) : super(key: key);
  final String title;
  int dimensions = locator<GameState>().board.dimensions;
  ValueNotifier<GameState> gameState = ValueNotifier(locator<GameState>());
  gb.GameBoard board = locator<GameState>().board;
  @override
  _GameBoard createState() => _GameBoard();
}

class _GameBoard extends State<GameBoard> {

  void createBoard() {
    if (locator<GameState>().board.dimensions == null) {
      locator<GameState>().board.dimensions = widget.dimensions;
    }
    int dim = locator<GameState>().board.dimensions;
    List<t.Tile> tiles = new List();
    widget.board = gb.GameBoard(dim, tiles);
    widget.board.tiles = tiles;
    widget.board.tiles[0].power = 20;
    widget.board.tiles[0].ownership = 0;
    widget.board.tiles[dim - 1].power = 20;
    widget.board.tiles[dim - 1].ownership = 3;
    widget.board.tiles[dim * dim - 1].power = 20;
    widget.board.tiles[dim * dim - 1].ownership = 1;
    widget.board.tiles[dim * dim - dim ].power = 20;
    widget.board.tiles[dim * dim - dim ].ownership = 2;
    locator<GameState>().turn = 0;
    locator<GameState>().board = widget.board;
    }


  void updateBoard() {
    debugPrint("Board updating");
    setState(() {});
    locator<GameState>().board = gb.GameBoard(widget.dimensions, widget.board.tiles);
    locator<GameState>().fromGameState(locator<GameState>());
    debugPrint(locator<GameState>().board.tiles[1].power.toString());
  }

  @override
  void initState() {
    createBoard();
    widget.gameState.addListener(() => parseGameState());
    Toaster.successToast("Turn is: " + ColorToString(turn));
  }

  void parseGameState()
  {
    debugPrint("Is Parsing");
    widget.dimensions = locator<GameState>().board.dimensions;
    widget.board.tiles = locator<GameState>().board.tiles;
    setState(() {});
  }


  //Add array object
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: new SizedBox(
          width: widget.dimensions * 130.0,
          child: new ListView.builder(
            cacheExtent: widget.dimensions * 130.0,
            //Important to update so flutter doesn't try to constantly reload the buttons. 7 - 16 is the items in a row, 125 is the height
            itemCount: widget.dimensions,
            //Creates variable rows
            itemBuilder: (BuildContext context, int i) {
              return new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: new List.generate(widget.dimensions, (int j) {
                  if (widget.board.tiles[i * widget.dimensions + j].ownership != -1)
                  {
                    return Tile(updateBoard, NumToColor(widget.board.tiles[i * widget.dimensions + j].ownership), locator<GameState>().initArmyNum, i, j);
                  }
                  else
                    return Tile(updateBoard, Colors.grey, locator<GameState>().initAINum, i, j);
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}



