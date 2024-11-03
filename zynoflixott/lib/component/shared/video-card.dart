import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VideoCarousel extends StatefulWidget {
  @override
  _VideoCarouselState createState() => _VideoCarouselState();
}

class _VideoCarouselState extends State<VideoCarousel> {
  List<dynamic> videos = [];

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  // Function to fetch videos from API
  Future<void> fetchVideos() async {
    final response =
        await http.get(Uri.parse('https://api.zynoflixott.com/api/videos'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        videos = jsonResponse['videos'];
      });
    } else {
      throw Exception('Failed to load videos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Text(
              'Watch The Latest Cinema Releases',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          videos.isEmpty
              ? Center(child: CircularProgressIndicator())
              : CarouselSlider(
                  options: CarouselOptions(
                    height: 400,
                    enlargeCenterPage: false,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayInterval: Duration(seconds: 5),
                    viewportFraction: 0.8,
                    disableCenter: true,
                  ),
                  items: videos.map((video) {
                    return buildVideoCard(video);
                  }).toList(),
                ),
        ],
      ),
    );
  }

  // Function to build individual video card
  Widget buildVideoCard(dynamic video) {
    return Card(
      color: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.network(
              video['thumbnail'],
              height: 200, // Adjust the thumbnail height
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              video['title'],
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12, // Adjust font size for better fit
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '1hr 40mins', // Placeholder for the duration
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
                TextButton(
                  onPressed: () {
                    // Handle button press
                    log('message');
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Play', // Placeholder for the category
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
