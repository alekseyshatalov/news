import 'package:flutter/material.dart';
import 'package:news/presentation/pages/news/tabs/all_tab.dart';
import 'package:news/presentation/pages/news/tabs/hot_tab.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.local_fire_department),
              text: 'Hot',
            ),
            Tab(
              icon: Icon(Icons.list_alt),
              text: 'All',
            ),
          ],
        ),
        body: TabBarView(
          children: [
            HotTab(),
            AllTab(),
          ],
        ),
      ),
    );
  }
}
