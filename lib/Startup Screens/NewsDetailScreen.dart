import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:international_news_app/Startup%20Screens/HomeScreen.dart';
import 'package:intl/intl.dart';

class NewsDetailScreen extends StatefulWidget {

  final String newsImg, newsTitle, newsDate, newsAuthor, newsDescription, newsContent, newsSource;

  const NewsDetailScreen({super.key,
  required this.newsImg,
  required this.newsTitle,
  required this.newsDate,
  required this.newsAuthor,
  required this.newsDescription,
  required this.newsContent,
  required this.newsSource,
  });

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final format = DateFormat('MMMM dd, yyyy');

    DateTime dateTime = DateTime.parse(widget.newsDate);


    return Scaffold(

      appBar: AppBar(),

      body: Stack(
        children: [

          SizedBox(
            height: height * 0.45,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              child: CachedNetworkImage(
                imageUrl: widget.newsImg.isNotEmpty ? widget.newsImg : 'https://example.com/dummy-image.jpg',
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(child: spinKit2),
                errorWidget: (context, url, error) => Image.asset('assets/images/error-img.png'),
              ),
            ),
          ),

          Container(
            height: height * 0.6,
            margin: EdgeInsets.only(top: height * 0.4),
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(70), topRight: Radius.circular(70)),
            ),
            child: ListView(
              children: [

                Text(widget.newsTitle,
                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700),
                ),

                SizedBox(height: height * 0.02,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.newsSource.length > 12 ? widget.newsSource.substring(0, 6) : widget.newsSource,
                      style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.blue),
                    ),
                    Text(widget.newsAuthor.length > 20 ? widget.newsAuthor.substring(12, 20) : widget.newsAuthor,
                      style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.purpleAccent),
                    ),
                    Text(format.format(dateTime),
                      style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),

                SizedBox(height: height * 0.03,),

                Text(widget.newsDescription,
                  style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
                ),

                SizedBox(height: height * 0.03,),

                SingleChildScrollView(
                  child: Text("''${widget.newsContent}''",
                    style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.brown),
                  ),
                ),


              ]
            ),
          ),

        ],
      ),

    );
  }
}
