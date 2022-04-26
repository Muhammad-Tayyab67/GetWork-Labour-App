// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:labour_app_wg/Allscreens/TabScreens/earningScreen.dart';
import 'package:labour_app_wg/Allscreens/TabScreens/ratingScreen.dart';
import 'package:labour_app_wg/Allscreens/mainscreen.dart';

class HomeScreen extends StatefulWidget {
  static const String idScreen = "Home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabcontroller;
  int selectIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectIndex = index;
      tabcontroller.index = selectIndex;
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    tabcontroller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    tabcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabcontroller,
          children: [
            mainscreen(),
            rationScreen(),
            earningScreen(),
          ]),
      // ignore: prefer_const_literals_to_create_immutables
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_max),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_score),
            label: "Earnings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rate_review_rounded),
            label: "Rating",
          ),
        ],
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontFamily: "Brand-Bold"),
        showUnselectedLabels: true,
        currentIndex: selectIndex,
        onTap: _onItemTapped,
        elevation: 1,
      ),
    );
  }
}
