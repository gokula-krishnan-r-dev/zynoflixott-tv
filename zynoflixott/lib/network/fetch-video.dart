import 'dart:convert';
import 'package:http/http.dart' as http;

class Video {
  final String title;
  final String description;
  final String thumbnail;
  final String previewVideo;

  Video({
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.previewVideo,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      title: json['title'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      previewVideo: json['preview_video'],
    );
  }
}

Future<List<Video>> fetchBannerVideos() async {
  final response =
      await http.get(Uri.parse('https://api.zynoflixott.com/api/banner'));
  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final List<dynamic> videoList = jsonData['video'];
    return videoList.map((json) => Video.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load videos');
  }
}
