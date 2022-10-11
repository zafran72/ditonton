import 'package:flutter/material.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/movie_page.dart';
import 'package:ditonton/presentation/pages/tv_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _botNavIndex = 0;

  final List<Widget> _listPage = [
    HomeMoviePage(),
    TvPage(),
  ];

  final List<BottomNavigationBarItem> _botNavBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movie'),
    BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'TV Series'),
  ];

  void _onBotNavTapped(int index) {
    setState(() {
      _botNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listPage[_botNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kMikadoYellow,
        currentIndex: _botNavIndex,
        items: _botNavBarItems,
        onTap: _onBotNavTapped,
      ),
    );
  }
}
