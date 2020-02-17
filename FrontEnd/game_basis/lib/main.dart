import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

//Work on neutral territory next

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Risk',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red,
      ),
      home: SelectTeam(),
    );
  }
}

class SelectTeam extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Your Team")
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
          new MaterialButton(
            onPressed:  () { Navigator.push(context,MaterialPageRoute(builder: (context) => MyHomePage(title: 'Risk')),);},
            child: new Text("Red", style: TextStyle(fontSize: 30)),
            color: Colors.red,
            height: 125,
            minWidth: 125,
            ),
            new MaterialButton(
              onPressed:  () { Navigator.push(context,MaterialPageRoute(builder: (context) => MyHomePage(title: 'Risk')),);},
              child: new Text("Blue", style: TextStyle(fontSize: 30)),
              color: Colors.blue,
              height: 125,
              minWidth: 125,
            ),
            ],
          ),
          new ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              new MaterialButton(
                onPressed:  () { Navigator.push(context,MaterialPageRoute(builder: (context) => MyHomePage(title: 'Risk')),);},
                child: new Text("Green", style: TextStyle(fontSize: 30)),
                color: Colors.green,
                height: 125,
                minWidth: 125,
              ),
              new MaterialButton(
                onPressed:  () { Navigator.push(context,MaterialPageRoute(builder: (context) => MyHomePage(title: 'Risk')),);},
                child: new Text("Yellow", style: TextStyle(fontSize: 30)),
                color: Colors.yellow,
                height: 125,
                minWidth: 125,
              ),
            ],
          ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class GameState
{
  int redArmy = 20;
  bool isRed = false;
  int blueArmy = 20;
  bool isBlue = false;
  int greenArmy = 20;
  bool isGreen = false;
  int yellowArmy = 20;
  bool isYellow = false;
  static NeutralArmy n1 = new NeutralArmy();
  static NeutralArmy n2 = new NeutralArmy();
  static NeutralArmy n3 = new NeutralArmy();
  static NeutralArmy n4 = new NeutralArmy();
  static NeutralArmy n5 = new NeutralArmy();
  static NeutralArmy n6 = new NeutralArmy();
  static NeutralArmy n7 = new NeutralArmy();
  static NeutralArmy n8 = new NeutralArmy();
  static List<NeutralArmy> arr = [n1, n2, n3, n4, n5, n6, n7, n8];

  List<NeutralArmy> returnArr()
  {
    return arr;
  }

  NeutralArmy getArmyNum(int n)
  {
    if (n == 1)
      return n1;
    if (n == 2)
      return n2;
    if (n == 3)
      return n3;
    if (n == 4)
      return n4;
    if (n == 5)
      return n5;
    if (n == 6)
      return n6;
    if (n == 7)
      return n7;
    if (n == 8)
      return n8;
    return null;
  }

}

class NeutralArmy
{
  //If a neutral territory is captured it should count as a colored one, add implementation
  int grayArmy = 5;
  bool isGray = false;
  String color = 'gray';

  int getArmy()
  {
    return grayArmy;
  }

  void setArmy(int n)
  {
    grayArmy = n;
  }

  bool getGray()
  {
      return isGray;
  }

  void setGray(bool b)
  {
    isGray = b;
  }

  String getColor()
  {
    return color;
  }

  void setColor(String c)
  {
    color = c;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  var rng = new Random();
  GameState game = new GameState();

  void redSelect() {
    setState(() {
      if (game.isRed){
        game.isRed = false;
      }
      else if (!game.isRed)
      {
        game.isRed = true;
      }
      if (game.isRed && game.isBlue)
      {
        attack(game, "Red", "Blue");
      }
      if (game.isRed && game.isGreen)
      {
        attack(game, "Red", "Green");
      }
      if (game.isRed && game.isYellow)
      {
        attack(game, "Red", "Yellow");
      }
      for (NeutralArmy n in game.returnArr())
      {
        if (game.isRed && n.isGray)
          {
            attack(game, "Red", "Gray", n);
          }
      }
    });
  }

  void blueSelect() {
    setState(() {
      if (game.isBlue) {
        game.isBlue = false;
        }
      else if (!game.isBlue)
      {
        game.isBlue = true;
      }
      if (game.isBlue && game.isRed)
      {
        attack(game, "Blue", "Red");
      }
      if (game.isBlue && game.isGreen)
      {
        attack(game, "Blue", "Green");
      }
      if (game.isBlue && game.isYellow)
      {
        attack(game, "Blue", "Yellow");
      }
      for (NeutralArmy n in game.returnArr())
      {
        if (game.isBlue && n.isGray)
        {
          attack(game, "Blue", "Gray", n);
        }
      }
    });
  }
  void greenSelect() {
    setState(() {
      if (game.isGreen){
        game.isGreen = false;
      }
      else if (!game.isGreen)
      {
        game.isGreen = true;
      }
      if (game.isGreen && game.isRed)
      {
        attack(game, "Green", "Red");
      }
      if (game.isGreen && game.isBlue)
      {
        attack(game, "Green", "Blue");
      }
      if (game.isGreen && game.isYellow)
      {
        attack(game, "Green", "Yellow");
      }
      for (NeutralArmy n in game.returnArr())
      {
        if (game.isGreen && n.isGray)
        {
          attack(game, "Green", "Gray", n);
        }
      }
    });
  }
  void yellowSelect() {
    setState(() {
      if (game.isYellow){
        game.isYellow = false;
      }
      else if (!game.isYellow)
      {
        game.isYellow = true;
      }
      if (game.isYellow && game.isRed)
      {
        attack(game, "Yellow", "Red");
      }
      if (game.isYellow && game.isBlue)
      {
        attack(game, "Yellow", "Blue");
      }
      if (game.isYellow && game.isGreen)
      {
        attack(game, "Yellow", "Green");
      }
      for (NeutralArmy n in game.returnArr())
      {
        if (game.isYellow && n.isGray)
        {
          attack(game, "Yellow", "Gray", n);
        }
      }
    });
  }
  void graySelect(NeutralArmy n) {
    setState(() {
      if (n.isGray){
        n.isGray = false;
      }
      else if (!n.isGray)
      {
        n.isGray = true;
      }
      if (n.isGray && game.isRed)
      {
        attack(game, "Gray", "Red", n);
      }
      if (n.isGray && game.isBlue)
      {
        attack(game, "Gray", "Blue", n);
      }
      if (n.isGray && game.isGreen)
      {
        attack(game, "Gray", "Green", n);
      }
      if (n.isGray && game.isYellow)
      {
        attack(game, "Gray", "Yellow", n);
      }
    });
  }

  void attack(GameState game, String army1, String army2, [NeutralArmy n])
  {
    if (army1 == "Red" && army2 == "Blue" || army1 == "Blue" && army2 == "Red") {
        (game.blueArmy > game.redArmy) ? game.redArmy = game.redArmy - 5 : game.blueArmy = game.blueArmy - 5;
        game.isRed = !game.isRed;
        game.isBlue = !game.isBlue;
      }
    if (army1 == "Red" && army2 == "Green" || army1 == "Green" && army2 == "Red") {
      (game.greenArmy > game.redArmy) ? game.redArmy = game.redArmy - 5 : game.greenArmy = game.greenArmy - 5;
      game.isRed = !game.isRed;
      game.isGreen = !game.isGreen;
    }
    if (army1 == "Red" && army2 == "Yellow" || army1 == "Yellow" && army2 == "Red") {
      (game.yellowArmy > game.redArmy) ? game.redArmy = game.redArmy - 5 : game.yellowArmy = game.yellowArmy - 5;
      game.isRed = !game.isRed;
      game.isYellow = !game.isYellow;
    }
    if (army1 == "Green" && army2 == "Blue" || army1 == "Blue" && army2 == "Green") {
      (game.greenArmy > game.blueArmy) ? game.blueArmy = game.blueArmy - 5 : game.greenArmy = game.greenArmy - 5;
      game.isBlue = !game.isBlue;
      game.isGreen = !game.isGreen;
    }
    if (army1 == "Green" && army2 == "Yellow" || army1 == "Yellow" && army2 == "Green") {
      (game.greenArmy > game.yellowArmy) ? game.yellowArmy = game.yellowArmy - 5 : game.greenArmy = game.greenArmy - 5;
      game.isYellow = !game.isYellow;
      game.isGreen = !game.isGreen;
    }
    if (army1 == "Yellow" && army2 == "Blue" || army1 == "Blue" && army2 == "Yellow") {
      (game.yellowArmy > game.blueArmy) ? game.blueArmy = game.blueArmy - 5 : game.yellowArmy = game.yellowArmy - 5;
      game.isYellow = !game.isYellow;
      game.isBlue = !game.isBlue;
    }
    if (army1 == "Gray" && army2 == "Red" || army1 == "Red" && army2 == "Gray") {
      (n.getArmy() > game.redArmy) ? game.redArmy = game.redArmy - 5 : n.setArmy(n.getArmy() - 5);
      if (n.getArmy() == 0)
      {
          n.setColor("Red");
          n.setArmy(5);
      }
      n.setGray(!n.getGray());
      game.isRed = !game.isRed;
    }
    if (army1 == "Gray" && army2 == "Blue" || army1 == "Blue" && army2 == "Gray") {
      (n.getArmy() > game.blueArmy) ? game.blueArmy = game.blueArmy - 5 : n.setArmy(n.getArmy() - 5);
      if (n.getArmy() == 0)
      {
        n.setColor("Blue");
        n.setArmy(5);
      }
      n.setGray(!n.getGray());
      game.isBlue = !game.isBlue;
    }
    if (army1 == "Gray" && army2 == "Yellow" || army1 == "Yellow" && army2 == "Gray") {
      (n.getArmy() > game.yellowArmy) ? game.yellowArmy = game.yellowArmy - 5 : n.setArmy(n.getArmy() - 5);
      if (n.getArmy() == 0)
      {
        n.setColor("Yellow");
        n.setArmy(5);
      }
      n.setGray(!n.getGray());
      game.isYellow = !game.isYellow;
    }
    if (army1 == "Gray" && army2 == "Green" || army1 == "Green" && army2 == "Gray") {
      (n.getArmy() > game.greenArmy) ? game.greenArmy = game.greenArmy - 5 : n.setArmy(n.getArmy() - 5);
      if (n.getArmy() == 0)
      {
        n.setColor("Green");
        n.setArmy(5);
      }
      n.setGray(!n.getGray());
      game.isGreen = !game.isGreen;
    }
  }




  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);
    return Scaffold(
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
      child: AppBar(
        title: Text(widget.title),
      ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PassiveScreen(game: this.game)));
        },
        child: Text("\$"),
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  new MaterialButton(
                    onPressed: greenSelect,
                    child: new Text(game.greenArmy.toString(), style: TextStyle(fontSize: 30)),
                    shape: Border.all(color: game.isGreen ? Colors.white : Colors.black, width: 5),
                    color: Colors.green,
                    height: 100,
                    minWidth: 100,

                  ),
                  new MaterialButton(
                    onPressed: () => graySelect(game.getArmyNum(1)),
                    child: new Text(game.getArmyNum(1).getArmy().toString(), style: TextStyle(fontSize: 30)),
                    shape: Border.all(color: game.getArmyNum(1).getGray() ? Colors.white : Colors.black, width: 5),
                    color: game.getArmyNum(1).getColor() == "Red" ? Colors.red : game.getArmyNum(1).getColor() == "Blue" ? Colors.blue : game.getArmyNum(1).getColor() == "Green" ? Colors.green : game.getArmyNum(1).getColor() == "Yellow" ? Colors.yellow : Colors.grey,
                    height: 100,
                    minWidth: 100,
                  ),
                  new MaterialButton(
                    onPressed: () => graySelect(game.getArmyNum(2)),
                    child: new Text(game.getArmyNum(2).getArmy().toString(), style: TextStyle(fontSize: 30)),
                    shape: Border.all(color: game.getArmyNum(2).getGray() ? Colors.white : Colors.black, width: 5),
                    color: game.getArmyNum(2).getColor() == "Red" ? Colors.red : game.getArmyNum(2).getColor() == "Blue" ? Colors.blue : game.getArmyNum(2).getColor() == "Green" ? Colors.green : game.getArmyNum(2).getColor() == "Yellow" ? Colors.yellow : Colors.grey,
                    height: 100,
                    minWidth: 100,

                  ),
                  new MaterialButton(
                    onPressed: redSelect,
                    child: new Text(game.redArmy.toString(), style: TextStyle(fontSize: 30)),
                    color: Colors.red,
                    shape: Border.all(color: game.isRed ? Colors.white : Colors.black, width: 5),
                    height: 100,
                    minWidth: 100,
                  ),
                ],
              ),
            new ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                new MaterialButton(
                  onPressed: () => graySelect(game.getArmyNum(3)),
                  child: new Text(game.getArmyNum(3).getArmy().toString(), style: TextStyle(fontSize: 30)),
                  shape: Border.all(color: game.getArmyNum(3).getGray() ? Colors.white : Colors.black, width: 5),
                  color: game.getArmyNum(3).getColor() == "Red" ? Colors.red : game.getArmyNum(3).getColor() == "Blue" ? Colors.blue : game.getArmyNum(3).getColor() == "Green" ? Colors.green : game.getArmyNum(3).getColor() == "Yellow" ? Colors.yellow : Colors.grey,
                  height: 100,
                  minWidth: 100,

                ),
                new MaterialButton(
                  onPressed: () => graySelect(game.getArmyNum(4)),
                  child: new Text(game.getArmyNum(4).getArmy().toString(), style: TextStyle(fontSize: 30)),
                  shape: Border.all(color: game.getArmyNum(4).getGray() ? Colors.white : Colors.black, width: 5),
                  color: game.getArmyNum(4).getColor() == "Red" ? Colors.red : game.getArmyNum(4).getColor() == "Blue" ? Colors.blue : game.getArmyNum(4).getColor() == "Green" ? Colors.green : game.getArmyNum(4).getColor() == "Yellow" ? Colors.yellow : Colors.grey,
                  height: 100,
                  minWidth: 100,

                ),
                new MaterialButton(
                  onPressed: () => graySelect(game.getArmyNum(5)),
                  child: new Text(game.getArmyNum(5).getArmy().toString(), style: TextStyle(fontSize: 30)),
                  shape: Border.all(color: game.getArmyNum(5).getGray() ? Colors.white : Colors.black, width: 5),
                  color: game.getArmyNum(5).getColor() == "Red" ? Colors.red : game.getArmyNum(5).getColor() == "Blue" ? Colors.blue : game.getArmyNum(5).getColor() == "Green" ? Colors.green : game.getArmyNum(5).getColor() == "Yellow" ? Colors.yellow : Colors.grey,
                  height: 100,
                  minWidth: 100,

                ),
                new MaterialButton(
                  onPressed: () => graySelect(game.getArmyNum(6)),
                  child: new Text(game.getArmyNum(6).getArmy().toString(), style: TextStyle(fontSize: 30)),
                  shape: Border.all(color: game.getArmyNum(6).getGray() ? Colors.white : Colors.black, width: 5),
                  color: game.getArmyNum(6).getColor() == "Red" ? Colors.red : game.getArmyNum(6).getColor() == "Blue" ? Colors.blue : game.getArmyNum(6).getColor() == "Green" ? Colors.green : game.getArmyNum(6).getColor() == "Yellow" ? Colors.yellow : Colors.grey,
                  height: 100,
                  minWidth: 100,

                ),
              ],
            ),
             new ButtonBar(
               alignment: MainAxisAlignment.center,
               children: <Widget>[
                 new MaterialButton(
                   onPressed: blueSelect,
                   child: new Text(game.blueArmy.toString(), style: TextStyle(fontSize: 30)),
                   shape: Border.all(color: game.isBlue ? Colors.white : Colors.black, width: 5),
                   color: Colors.blue,
                   height: 100,
                   minWidth: 100,
                  ),
                 new MaterialButton(
                   onPressed: () => graySelect(game.getArmyNum(7)),
                   child: new Text(game.getArmyNum(7).getArmy().toString(), style: TextStyle(fontSize: 30)),
                   shape: Border.all(color: game.getArmyNum(7).getGray() ? Colors.white : Colors.black, width: 5),
                   color: game.getArmyNum(7).getColor() == "Red" ? Colors.red : game.getArmyNum(7).getColor() == "Blue" ? Colors.blue : game.getArmyNum(7).getColor() == "Green" ? Colors.green : game.getArmyNum(7).getColor() == "Yellow" ? Colors.yellow : Colors.grey,
                   height: 100,
                   minWidth: 100,

                 ),
                 new MaterialButton(
                   onPressed: () => graySelect(game.getArmyNum(8)),
                   child: new Text(game.getArmyNum(8).getArmy().toString(), style: TextStyle(fontSize: 30)),
                   shape: Border.all(color: game.getArmyNum(8).getGray() ? Colors.white : Colors.black, width: 5),
                   color: game.getArmyNum(8).getColor() == "Red" ? Colors.red : game.getArmyNum(8).getColor() == "Blue" ? Colors.blue : game.getArmyNum(8).getColor() == "Green" ? Colors.green : game.getArmyNum(8).getColor() == "Yellow" ? Colors.yellow : Colors.grey,
                   height: 100,
                   minWidth: 100,

                 ),
                  new MaterialButton(
                   onPressed: yellowSelect,
                   child: new Text(game.yellowArmy.toString(), style: TextStyle(fontSize: 30)),
                    shape: Border.all(color: game.isYellow ? Colors.white : Colors.black, width: 5),
                   color: Colors.yellow,
                    height: 100,
                    minWidth: 100,
                  ),
                ],
              ),
            ],
        ),
      ),
    );
  }
}

class PassiveScreen extends StatefulWidget {
  PassiveScreen({this.game});
  final GameState game;
  final PassiveState pState = new PassiveState();

  @override
  _PassiveScreenState createState() => _PassiveScreenState();
}

/**
 * a passive is an object that a user can purchase
 * it has a cost, duration, active status and one or more attributes (helpful only)
 */
class Passive {
  String description = "passive name:\n passive attributes";
  int cost = 0;
  int duration = 0;
  bool isActive = false;
  Color buttonColor = Colors.green;

  void setButtonColor(){
    if (isActive){
      buttonColor = Colors.grey[600];
    }
    else {
      buttonColor = Colors.green;
    }
  }

  void assign() {
    this.isActive = true;
  }

  void unassign() {
    this.isActive = false;
  }

  void setActive() {
    isActive = true;
  }

  bool getStatus() {
    return this.isActive;
  }

  int getCost() {
    return this.cost;
  }

  int getDuration() {
    return this.duration;
  }

  void simTurn() {
    if (this.duration > 0) {
      this.duration--;
    }
    if (this.duration == 0) {
      unassign();
    }
  }
}

/**
 * holds information about the state of the passive objects
 */
class PassiveState {
  static Passive p1 = new Passive();
  static Passive p2 = new Passive();
  static Passive p3 = new Passive();
  static Passive p4 = new Passive();
  static Passive p5 = new Passive();
  static Passive p6 = new Passive();
  List<Passive> passiveArr = [p1, p2, p3, p4, p5, p6];
}

class _PassiveScreenState extends State<PassiveScreen> {

  /**
   * TODO:
   * purchasePassive needs access to the current users team color/name 
   * to determine who the passive should be assigned to.
   * Also updates the state of the FloatingActionButton colors and return value
   */
  void purchasePassive(Passive p, GameState game) {
    setState(() {
      // assign the given Passive p to the user
      p.assign();
      p.setButtonColor();
    });
  }

  void removePassive(Passive p) {
    setState(() {
      // unassing a passive to the user
      p.unassign();
      p.setButtonColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PassiveScreen',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red,
      ),
      home: Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            title: Text("Passive Selection"),
            automaticallyImplyLeading: true,
            leading: BackButton(
              onPressed: () => Navigator.pop(context),
            ),
          ),
          preferredSize: Size.fromHeight(30.0),
        ),
        body: Container(
          // this container holds the entire widget tree for this screen
          constraints: BoxConstraints(
            maxHeight: 500,
          ),
          alignment: Alignment.bottomLeft,
          // padding: EdgeInsets.all(0),
          // color: Colors.blueGrey,
          child: ListView(
            // this is the list of passive descriptions
            shrinkWrap: true,
            controller: ScrollController(initialScrollOffset: 0),
            children: <Widget>[
              Container(
                // tihs container is a row containing the passive description string and purchase button
                constraints: BoxConstraints(maxHeight: 60, minHeight: 60),
                color: Colors.blue,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(4),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.assessment),
                    Text('\t'),
                    Text(widget.pState.passiveArr[0].description),
                    Spacer(
                      flex: 1,
                    ),
                    FlatButton(
                      child: Text("Buy"),
                      clipBehavior: Clip.antiAlias,
                      autofocus: true,
                      color: widget.pState.passiveArr[0].buttonColor,
                      onPressed: () => purchasePassive(widget.pState.passiveArr[0], widget.game),
                      shape: RoundedRectangleBorder(),
                    ),
                  ],
                ),
              ),
              Container(
                // tihs container is a row containing the passive description string and purchase button
                constraints: BoxConstraints(maxHeight: 60, minHeight: 60),
                color: Colors.blue,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(4),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.assessment),
                    Text('\t'),
                    Text(widget.pState.passiveArr[1].description),
                    Spacer(
                      flex: 1,
                    ),
                    FlatButton(
                      child: Text("Buy"),
                      clipBehavior: Clip.antiAlias,
                      autofocus: true,
                      color: widget.pState.passiveArr[1].buttonColor,
                      onPressed: () => purchasePassive(widget.pState.passiveArr[1], widget.game),
                      shape: RoundedRectangleBorder(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}