import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:international_news_app/Startup%20Screens/CategoriesScreen.dart';
import 'package:international_news_app/Startup%20Screens/NewsDetailScreen.dart';
import 'package:international_news_app/models/NewsChannelHeadlinesModel.dart';
import 'package:international_news_app/view%20model/NewsViewModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import '../models/CategoriesNewsModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList {
  bbcNews,
  aryNews,
  espn,
  googleNews,
  cnn,
  alJazeera
}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  FilterList? selectedMenuItem;
  final format = DateFormat('MMMM dd, yyyy');
  String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoriesScreen()));
          },
          icon: Image.asset(
            'assets/images/category_img.png',
            width: 25,
            height: 25,
          ),
        ),
        title: Center(
          child: Text(
            'News',
            style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
        actions: [
          PopupMenuButton<FilterList>(
            initialValue: selectedMenuItem,
            onSelected: (FilterList item) {
              setState(() {
                selectedMenuItem = item;
                name = _getNewsChannelName(item);
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterList>>[
               PopupMenuItem<FilterList>(
                value: FilterList.bbcNews,
                child: ListTile(
                  leading: CircleAvatar(child: Image.asset('assets/images/bbc-logo.png'),),
                  title: const Text('BBC News'),
                ),
              ),
               PopupMenuItem<FilterList>(
                value: FilterList.aryNews,
                child: ListTile(
                  leading: CircleAvatar(child: Image.asset('assets/images/ary-logo.png'),),
                  title: const Text('ARY News'),
                ),
              ),
               PopupMenuItem<FilterList>(
                value: FilterList.espn,
                child: ListTile(
                  leading: CircleAvatar(child: Image.asset('assets/images/espn-logo.png'),),
                  title: const Text('ESPN'),
                ),
              ),
               PopupMenuItem<FilterList>(
                value: FilterList.googleNews,
                child: ListTile(
                  leading: CircleAvatar(child: Image.asset('assets/images/google-logo.png'),),
                  title: const Text('Google News'),
                ),
              ),
               PopupMenuItem<FilterList>(
                value: FilterList.cnn,
                child: ListTile(
                  leading: CircleAvatar(child: Image.asset('assets/images/cnn-logo.png'),),
                  title: const Text('CNN'),
                ),
              ),
               PopupMenuItem<FilterList>(
                value: FilterList.alJazeera,
                child: ListTile(
                  leading: CircleAvatar(child: Image.asset('assets/images/aljazeera-logo.png'),),
                  title: const Text('Al - Jazeera'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: height * 0.55,
                width: width,
                child: FutureBuilder<NewsChannelHeadlinesModel>(
                  future: newsViewModel.fetchNewsHeadlinesApi(name),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitCircle(color: Colors.blue),
                      );
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.articles.length,
                        itemBuilder: (context, index) {

                          DateTime dateTime = DateTime.parse(snapshot.data!.articles[index].publishedAt.toString());

                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>

                                  NewsDetailScreen(

                                  newsImg: snapshot.data!.articles[index].urlToImage.toString(),
                                  newsTitle: snapshot.data!.articles[index].title.toString(),
                                  newsDate: snapshot.data!.articles[index].publishedAt.toString(),
                                  newsAuthor: snapshot.data!.articles[index].author.toString(),
                                  newsDescription: snapshot.data!.articles[index].description.toString(),
                                  newsContent: snapshot.data!.articles[index].content.toString(),
                                  newsSource: snapshot.data!.articles[index].source.name.toString(),

                                  )));
                            },
                            child: SizedBox(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: height * 0.6,
                                    width: width * 0.9,
                                    padding: EdgeInsets.symmetric(horizontal: height * 0.02),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot.data!.articles[index].urlToImage.toString(),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Container(child: spinKit2),
                                        errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    child: Card(
                                      elevation: 5,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        padding: const EdgeInsets.all(15),
                                        height: height * 0.22,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: width * 0.7,
                                              child: Text(
                                                snapshot.data!.articles[index].title.toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                            const Spacer(),
                                            SizedBox(
                                              width: width * 0.7,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot.data!.articles[index].source.name.toString(),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.blue),
                                                  ),
                                                  Text(
                                                    format.format(dateTime),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );


                        },
                      );
                    }
                  },
                ),
              ),
            ]),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: FutureBuilder<CategoriesNewsModel>(
                future: newsViewModel.fetchCategoriesNewsApi('General'),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitCircle(color: Colors.blue),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.articles.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(snapshot.data!.articles[index].publishedAt.toString());
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>

                                NewsDetailScreen(

                                  newsImg: snapshot.data!.articles[index].urlToImage.toString(),
                                  newsTitle: snapshot.data!.articles[index].title.toString(),
                                  newsDate: snapshot.data!.articles[index].publishedAt.toString(),
                                  newsAuthor: snapshot.data!.articles[index].author.toString(),
                                  newsDescription: snapshot.data!.articles[index].description.toString(),
                                  newsContent: snapshot.data!.articles[index].content.toString(),
                                  newsSource: snapshot.data!.articles[index].source!.name.toString(),

                                )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data!.articles[index].urlToImage.toString(),
                                    fit: BoxFit.cover,
                                    height: height * 0.18,
                                    width: width * 0.3,
                                    placeholder: (context, url) => Container(child: spinKit2),
                                    errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: height * 0.18,
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Column(
                                      children: [
                                        Text(
                                          snapshot.data!.articles[index].title.toString(),
                                          maxLines: 3,
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.brown,
                                          ),
                                        ),
                                        const Spacer(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data!.articles[index].source!.name.length > 12
                                                  ? snapshot.data!.articles[index].source!.name.substring(0, 6)
                                                  : snapshot.data!.articles[index].source!.name,
                                              style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            Text(
                                              format.format(dateTime),
                                              style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getNewsChannelName(FilterList item) {
    switch (item) {
      case FilterList.bbcNews:
        return 'bbc-news';
      case FilterList.aryNews:
        return 'ary-news';
      case FilterList.espn:
        return 'espn';
      case FilterList.googleNews:
        return 'google-news';
      case FilterList.cnn:
        return 'cnn';
      case FilterList.alJazeera:
        return 'al-jazeera-english';
    }
  }
}

const spinKit2 = SpinKitFadingCircle(
  color: Colors.blue,
);
