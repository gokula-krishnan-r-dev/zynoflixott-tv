import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

class BannerHome extends StatefulWidget {
  const BannerHome({Key? key}) : super(key: key);

  @override
  _BannerHomeState createState() => _BannerHomeState();
}

class _BannerHomeState extends State<BannerHome> {
  List<dynamic> bannerVideos = [];
  bool isLoading = true;
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.networkUrl(Uri.parse(
        'https://etubees.s3.us-east-1.amazonaws.com/zynoflix-ott/1724585856283-Mufasa%C3%AF%C2%BC%C2%9A+The+Lion+King+%C3%AF%C2%BD%C2%9C+Official+Trailer%281%29.mp4'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _videoController.play();
          _videoController.setLooping(true);
          _videoController.setVolume(0);
          _videoController.setPlaybackSpeed(1.0);
        });
      });
    fetchBannerVideos();
  }

  Future<void> fetchBannerVideos() async {
    try {
      final response =
          await http.get(Uri.parse('https://api.zynoflixott.com/api/banner'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        log('message: $data');
        setState(() {
          bannerVideos = data['video'];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load banner videos');
      }
    } catch (e) {
      log("Error fetching banner videos: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Overlay
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Positioned(
                
                  child: SizedBox(
                    height: 450, // Fixed height for carousel
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 450,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 10),
                        aspectRatio: 19 / 6,
                        autoPlayCurve: Curves.easeInOut,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 1000),
                        enableInfiniteScroll: true,
                        viewportFraction: 1.0, // Full width
                      ),
                      items: bannerVideos.map((video) {
                        return Builder(
                          builder: (BuildContext context) {
                            return ClipRRect(
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  // Video thumbnail
                                  // Background video
                                  _videoController.value.isInitialized
                                      ? Container(
                                          height: 450,
                                          width: double.infinity,
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              // VideoPlayer widget (Background Video)
                                              VideoPlayer(_videoController),

                                              // Overlay color with shadow effect
                                              Container(
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.black.withOpacity(
                                                          0.1), // Dark color at bottom
                                                      Colors
                                                          .transparent, // Transparent at top
                                                    ],
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                  ),
                                                ),
                                              ),

                                              // Shadow block effect at the bottom
                                              Positioned(
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                child: Container(
                                                  height:
                                                      450, // Height for shadow block
                                                  decoration: BoxDecoration(
                                                    color: Colors.black.withOpacity(
                                                        0.1), // Semi-transparent block
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(
                                                                0.1), // Shadow color
                                                        offset: const Offset(0,
                                                            5), // Shadow direction and distance
                                                        blurRadius:
                                                            10, // Shadow blur
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : const Center(
                                          child: CircularProgressIndicator()),

                                  // Video details overlay
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                          bottom: Radius.circular(15),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            video['title'],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            video['description'],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              log('message: Watch Now');
                                              // Add your onPressed functionality here
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30), // Rounded corners
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical:
                                                          5), // Button padding
                                              elevation: 5, // Shadow depth
                                              shadowColor: Colors.black
                                                  .withOpacity(
                                                      0.3), // Shadow color
                                            ),
                                            child: const Text(
                                              'Watch Now',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16, // Text size
                                                fontWeight: FontWeight
                                                    .bold, // Bold text
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }
}
