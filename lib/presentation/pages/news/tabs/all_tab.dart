import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/data/models/article.dart';
import 'package:news/domain/bloc/all/all_bloc.dart';

import '../../article_page.dart';

class AllTab extends StatelessWidget {
  AllTab({super.key});

  final ScrollController scrollController = ScrollController();
  final List<ListTile> tiles = [];

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(
      () {
        if (scrollController.position.maxScrollExtent ==
            scrollController.position.pixels) {
          context.read<AllBloc>().add(LoadNextPage());
        }
      },
    );

    return BlocBuilder<AllBloc, AllState>(
      builder: (context, state) {
        if (state is AllInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is AllLoaded) {
          for (Article article in state.articles) {
            tiles.add(
              ListTile(
                leading: SizedBox(
                  width: 100,
                  child: article.urlToImage != null
                      ? Image.network(article.urlToImage!)
                      : const FlutterLogo(),
                ),
                title: Text(article.title),
                subtitle: Text(article.description),
                trailing: IconButton(
                  icon: const Icon(Icons.bookmark_add),
                  onPressed: () {},
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ArticlePage(article: article);
                      },
                    ),
                  );
                },
              ),
            );
          }
          return RefreshIndicator(
            child: ListView.builder(
              controller: scrollController,
              itemCount: tiles.length,
              itemBuilder: (context, index) {
                return tiles[index];
              },
            ),
            onRefresh: () {
              //tiles.clear();
              //context.read<AllBloc>().add(LoadArticles());
              return Future.delayed(Duration.zero);
            },
          );
        }
        return const Center(child: Text('error'));
      },
    );
  }
}
