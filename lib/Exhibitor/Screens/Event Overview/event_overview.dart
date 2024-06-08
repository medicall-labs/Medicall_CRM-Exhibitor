import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          // title: FlutterLogo(colors: Colors.green, size: 25),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.grey,
              onPressed: () {}),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.menu), color: Colors.grey, onPressed: () {})
          ],
        ),
        body: buildBody());
  }

  ListView buildBody() {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        SizedBox(height: 40),
        buildInstructionRow(),
        SizedBox(height: 10),
        buildGridView(),
      ],
    );
  }

  Container buildGridView() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 4,
        shrinkWrap: true,
        primary: false,
        childAspectRatio: 1 / 1.2,
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            color: Colors.lightBlueAccent,
          ),
          Container(
            width: 100,
            height: 100,
            color: Colors.lightBlueAccent,
          ),
          Container(
            width: 100,
            height: 100,
            color: Colors.lightBlueAccent,
          ),
          Container(
            width: 100,
            height: 100,
            color: Colors.lightBlueAccent,
          ),
          Container(
            width: 100,
            height: 100,
            color: Colors.lightBlueAccent,
          ),
          Container(
            width: 100,
            height: 100,
            color: Colors.lightBlueAccent,
          ),
          Container(
            width: 100,
            height: 100,
            color: Colors.lightBlueAccent,
          ),
          Container(
            width: 100,
            height: 100,
            color: Colors.lightBlueAccent,
          ),
        ],
      ),
    );
  }

  Container buildInstructionRow() {
    return Container(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'MY COACHES',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'VIEW PAST SESSIONS',
            style: TextStyle(
              color: Colors.green,
              fontSize: 12,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
