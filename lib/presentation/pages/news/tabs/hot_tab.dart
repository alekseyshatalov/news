import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/data/models/article.dart';
import 'package:news/domain/bloc/hot/hot_bloc.dart';
import 'package:news/presentation/pages/article_page.dart';

class HotTab extends StatelessWidget {
  HotTab({super.key});

  final ScrollController scrollController = ScrollController();
  final List<ListTile> tiles = [];

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(
      () {
        if (scrollController.position.maxScrollExtent ==
            scrollController.position.pixels) {
          context.read<HotBloc>().add(LoadNextPage());
        }
      },
    );

    return BlocBuilder<HotBloc, HotState>(
      builder: (context, state) {
        if (state is HotInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is HotLoaded) {
          tiles.clear();
          for (Article article in state.articles) {
            tiles.add(
              ListTile(
                leading: SizedBox(
                  width: 100,
                  child: Hero(
                    tag: article.urlToImage ?? 'hero',
                    child: article.urlToImage != null
                        ? Image.network(article.urlToImage!)
                        : const FlutterLogo(),
                  ),
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
          Future.delayed(Duration(milliseconds: 100)).then((value) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Hot updated'),
                duration: Duration(milliseconds: 500),
              ),
            );
          });
          return ListView.builder(
            controller: scrollController,
            itemCount: tiles.length,
            itemBuilder: (context, index) {
              return tiles[index];
            },
          );
        }
        return const Center(child: Text('error'));
      },
    );
  }
}
