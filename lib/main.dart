import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/domain/bloc/all/all_bloc.dart' as all;
import 'package:news/domain/bloc/hot/hot_bloc.dart' as hot;
import 'package:news/presentation/pages/fav_page.dart';
import 'package:news/presentation/pages/news/news_page.dart';

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => hot.HotBloc()
            ..add(
              hot.LoadArticles(),
            ),
        ),
        BlocProvider(
          create: (context) => all.AllBloc()
            ..add(
              all.LoadArticles(),
            ),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: const _MainPage(),
      ),
    );
  }
}

class _MainPage extends StatefulWidget {
  const _MainPage();
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<_MainPage> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: pageIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.newspaper),
            label: 'News',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('0'),
              child: Icon(Icons.bookmark),
            ),
            label: 'Bookmarks',
          ),
        ],
        onDestinationSelected: (selectedIndex) {
          setState(() => pageIndex = selectedIndex);
        },
      ),
      body: SafeArea(
        child: [
          const NewsPage(),
          const FavPage(),
        ][pageIndex],
      ),
    );
  }
}
