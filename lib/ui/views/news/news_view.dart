import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'news_viewmodel.dart';

class NewsView extends StackedView<NewsViewModel> {
  const NewsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    NewsViewModel viewModel,
    Widget? child,
  ) {
    final newsData = viewModel.responseGetNews?.data;
    print('Masuk NewsView : ${newsData?.posts!.length}');

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : viewModel.errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, color: Colors.red, size: 50),
                      const SizedBox(height: 10),
                      Text(
                        viewModel.errorMessage!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: viewModel.getApi,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : newsData == null ||
                      newsData.posts == null ||
                      newsData.posts!.isEmpty
                  ? const Center(child: Text("No news available"))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      itemCount: newsData.posts!.length,
                      itemBuilder: (context, index) {
                        final post = newsData.posts![index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(post.title ?? "No title"),
                            subtitle:
                                Text(post.description ?? "No description"),
                            leading: post.thumbnail != null
                                ? Image.network(post.thumbnail!,
                                    width: 50, height: 50)
                                : null,
                          ),
                        );
                      },
                    ),
    );
  }

  @override
  NewsViewModel viewModelBuilder(BuildContext context) => NewsViewModel();

  @override
  void onViewModelReady(NewsViewModel viewModel) {
    viewModel.getApi();
  }
}
