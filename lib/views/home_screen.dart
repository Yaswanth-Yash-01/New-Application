
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:blocnews/blocs/newsbloc/news_bloc.dart';
import 'package:blocnews/blocs/newsbloc/news_states.dart';
import 'package:blocnews/models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: height * 0.01),
            Padding(
              padding: EdgeInsets.only(),
              child: Text(
                "News".toUpperCase(),
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: height * 0.01),
            Container(
              height: 1,
              color: Colors.grey.withOpacity(0.7),
              width: width,
              margin: EdgeInsets.symmetric(horizontal: width * 0.05),
            ),
            Expanded(
              child: BlocBuilder<NewsBloc, NewsStates>(
                builder: (context, state) {
                  if (state is NewsLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is NewsLoadedState) {
                    final articleList = state.articleList;

                    return ListView.builder(
                      itemCount: articleList.length,
                      itemBuilder: (context, index) {
                        final article = articleList[index];
                        final imageUrl = article.urlToImage ??
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSojwMMYZgtiupM4Vzdb5iBeE4b0Mamf3AgrxQJR19Xa4oIWV5xun9a02Ggyh4bZAurP_c&usqp=CAU";

                        return GestureDetector(
                          onTap: () async {
                           
                          // if (Platform.isAndroid) {
                          //     await FlutterWebBrowser.openWebPage(
                          //       url: article.url,
                          //       customTabsOptions: const CustomTabsOptions(
                          //         colorScheme: CustomTabsColorScheme.dark,
                          //         toolbarColor: Colors.deepPurple,
                          //         secondaryToolbarColor: Colors.green,
                          //         navigationBarColor: Colors.amber,
                          //         addDefaultShareMenuItem: true,
                          //         instantAppsEnabled: true,
                          //         showTitle: true,
                          //         urlBarHidingEnabled: true,
                          //       ),
                          //     );
                          //   } else if (Platform.isIOS) {
                          //     await FlutterWebBrowser.openWebPage(
                          //       url: article.url,
                          //       safariVCOptions: const SafariViewControllerOptions(
                          //         barCollapsingEnabled: true,
                          //         preferredBarTintColor: Colors.green,
                          //         preferredControlTintColor: Colors.amber,
                          //         dismissButtonStyle:
                          //             SafariViewControllerDismissButtonStyle.close,
                          //         modalPresentationCapturesStatusBarAppearance: true,
                          //       ),
                          //     );
                          //   } else {

                            openArticleUrl(article.url);
                       
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1,
                                  color: Colors.grey,
                           
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            height: height * 0.15,
                            margin: EdgeInsets.symmetric(
                              vertical: height * 0.01,
                              horizontal: width * 0.02,
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(10),
                                  ),
                                  child: Image.network(
                                    imageUrl,
                                    width: width * 0.3,
                                    height: height * 0.15,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => const Icon(Icons.image),
                                  ),
                                ),
                                SizedBox(width: width * 0.03),
                                SizedBox(
                                  width: width * 0.55,
                                  height: height * 0.15,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                                    child: Text(
                                      article.title,
                                      overflow: TextOverflow.clip,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is NewsErrorState) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> openArticleUrl(String url) async {
  final uri = Uri.parse(url);

  if (!await launchUrl(
    uri,
    mode: LaunchMode.externalApplication, // opens in browser
  )) {
    throw Exception('Could not launch $url');
  }
}
}
