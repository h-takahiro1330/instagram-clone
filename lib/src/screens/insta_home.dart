import 'package:flutter/material.dart';

class Instahome extends StatefulWidget {
  _InstahomeState createState() => _InstahomeState();
}

class _InstahomeState extends State<Instahome> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: bottomNavBar(),
    );
  }

  Widget bottomNavBar() {
    final List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
        title: Text('home'),
        icon: Icon(
          Icons.home,
          color: Colors.pink,
        )
      ),
      BottomNavigationBarItem(
        title: Text('serach'),
        icon: Icon(
          Icons.search,
          color: Colors.pink,
        )
      ),
      BottomNavigationBarItem(
        title: Text('add'),
        icon: Icon(
          Icons.add,
          color: Colors.pink,
        )
      ),
      BottomNavigationBarItem(
        title: Text('favorite'),
        icon: Icon(
          Icons.favorite,
          color: Colors.pink,
        )
      ),
      BottomNavigationBarItem(
        title: Text('profile'),
        icon: Icon(
          Icons.person,
          color: Colors.pink,
        )
      )
    ];
    return BottomNavigationBar(
      items: items,
      onTap: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
      currentIndex: currentIndex,
      iconSize: 24.0,
      unselectedItemColor: Colors.black,
      selectedItemColor: Colors.pink,
      type: BottomNavigationBarType.fixed,
    );
  }
}