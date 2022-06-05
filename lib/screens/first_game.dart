import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:programee2/models/item_model.dart';

class FirstGame extends StatefulWidget {
  const FirstGame({Key? key}) : super(key: key);

  @override
  State<FirstGame> createState() => _FirstGameState();
}

class _FirstGameState extends State<FirstGame> {
  var player =AudioCache();
  List<ItemModel> items = [];
  List<ItemModel> items2 = [];
  late int score;
  late bool gameOver;

  //The initiation of the game
  initGame(){
    gameOver = false;
    score = 0;
    items = [
      ItemModel(value: "بداية البرنامج", name: "بداية البرنامج"),
      ItemModel(value: "س = 1", name: "س = 1||ص = 2"),
      ItemModel(value: "ص = 2", name: "س = 1||ص = 2"),
      ItemModel(value: "ع = س + ص",name: "ع = س + ص"),
      ItemModel(value: "اطبع (ع)",name: "اطبع (ع)"),
      ItemModel(value: "نهاية البرنامج",name: "نهاية البرنامج"),

    ];
    items2 = List<ItemModel>.from(items);
    items.shuffle();


  }

  @override
  void initState(){
    super.initState();
    initGame();
  }

//الحاوي الذي يحتوي على كل عنصر
// The container that content every item
  Widget getBlock(ItemModel newItem, Color color1){
    Widget block = Container(
      color: color1,
      width: 100,
      child: Text(newItem.value,
        style: const TextStyle(fontSize: 18, color: Colors.white ),
        textAlign: TextAlign.center,),
    );
    if (color1==Colors.blue || color1==Colors.green) {
      block = Container(
      color: color1,
      width: 100,
          child: Text(newItem.value,
            style: const TextStyle(fontSize: 18, color: Colors.white ),
            textAlign: TextAlign.center,),
    );
    } else {
      block = Container(
      color: color1,
      width: 100,
      //height: 50,
      child: Text(newItem.value,
        style: const TextStyle(fontSize: 18, color: Colors.black ),
        textAlign: TextAlign.center,),
    );
    }
    return block;
  }

  @override
  Widget build(BuildContext context) {
    if(items.isEmpty) gameOver = true;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(" اللعبة الأولى | لُعبة توصيل الأوامر"),
      ),
      backgroundColor: Colors.yellow,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(" في هذه اللُّعبة اكتب برنامجاً لجمع عددين صحيحين بواسطة توصيل الأوامر إلى الأماكن المناسبة\t",
                style: TextStyle(fontSize: 20),textAlign: TextAlign.right,),
              if(!gameOver)
              Row(
                children: [
                  Column(
                    children: items.map((newItem){
                      return Container(
                        margin: const EdgeInsets.all(8),
                        child: Draggable<ItemModel>(
                          data: newItem,
                          child: getBlock(newItem, Colors.white),
                          feedback:Material(child: getBlock(newItem, Colors.green))  ,
                          childWhenDragging: getBlock(newItem, Colors.blue),

                        ),
                      );
                    }).toList(),
                  ),
                  const Spacer(),
                  Column(
                    children: items2.map((anItem)
                        {

                          return setDragTarget(anItem);
                        }
                    ).toList(),
                  )
                ],
              ),
              if(gameOver)
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text.rich(
                    TextSpan(
                        children: [
                          const TextSpan(
                            text: 'النتيجة: ',
                            style: TextStyle(fontSize: 20, fontFamily: "Aria") /*Theme.of(context).textTheme.subtitle1*/,
                          ),
                          TextSpan(
                            text: '$score',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(color: Colors.teal),

                          )
                        ]
                    )
                ),
              ),
                if(gameOver)
                Center(
                  child: Column(
                    children: [
                      Padding(padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'انتهت اللعبة',
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.red,
                        ),
                      ),
                      ),
                      Padding(
                         padding: const EdgeInsets.all(8.0),
                        child: Text(
                          result(),
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      )
                    ],
                  ),
                ),
             if(gameOver)
                Container(
                  //height: MediaQuery.of(context).size.width/18,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    /*borderRadius: BorderRadius.circular(8)*/),
    child: TextButton(
    onPressed: (){
      setState(() {
        initGame();
      });
    },
    child: const Text(
    'لعبة جديدة',
      style: TextStyle(color: Colors.black),
    ),
    ),
              )
            ],
          ),
        ),
      ),
    );


  }

  String result() {
    String res = "انتهت اللعبة";

    if(score == 100){
      player.play('assets/sounds/success.wav');
      res = 'رائع!';
    }else{
      //player.play('assets/sounds/tryAgain.wav');
      res = 'العب مُجدداً لتحصل على نتيجة أفضل';
    }
    if (kDebugMode) {
      print(res);
    }
    return res;
  }
  String? changeText(String text){

    return text;
  }
  Widget setDragTarget(ItemModel item){
    Color? itemColor = Colors.grey[200];
    String itemValue = item.value;
    const String t = "أسقط هذا الأمر هنا";
    Widget drag =
    DragTarget<ItemModel>(
      onLeave: (anItem){
        setState(() {

        });
      },
        builder: (context, receivedItems, rejectedItems) {
        if(item.accepting){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: getBlock(item, Colors.green),
          );
        }

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: itemColor,
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(t),
          ),
        ),
      );

    },
      onWillAccept: (item){
          if (kDebugMode) {
            print("onWillAccept");
          }
          return true;
      },
    onAccept: (receivedItem) {
          ///* if the item value was equal *///
          ///*     "س = 1"
          /// or
          /// "ص = 2"*///
          ///*then DragTarget will accept.*///
      ///
      if(itemValue.contains("س = 1")||itemValue.contains("ص = 2")){
        receivedItem.accepting=true;
        //itemColor = Colors.green;
        setState(() {
          items.remove(receivedItem);
        });

        //itemO = "itemValue";
      } else if(item.value==receivedItem.value){
        setState(() {
          items.remove(receivedItem);
        });
        score += 25;
        item.accepting=true;
        //player.play('true.wav');
      }else{
        setState(() {
          score -=4;
          item.accepting=false;
          //player.play('false.wav');
        });
      }
    }
    );
    if (kDebugMode) {
      print("onAccept");
    }
    return drag;
  }
  Widget checkedItem(ItemModel item){
    bool itemValueIsChecked = false ;
    if(item.value == "س = 1" || item.value == "ص = 2") {
      return getBlock(item, Colors.green);
    }
    return Text(item.value);
  }
}

