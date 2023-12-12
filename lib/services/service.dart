import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:basic_app/models/post.dart';

class Services {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';
  var client = http.Client();

  Future<List<Posts>?> getPosts() async {
    var url = Uri.parse('$baseUrl/posts');
    var response = await client.get(url);

    if (response.statusCode == 200) {
      try {
        return postsFromJson(response.body);
      } catch (e) {
        print('Error parsing JSON response: $e');
        return null;
      }
    } else {
      print('Request failed with status code: ${response.statusCode}');
      return null;
    }
  }

  Future<Posts?> getPostById(int postId) async {
    var url = Uri.parse('$baseUrl/posts/$postId');
    var response = await client.get(url);

    if (response.statusCode == 200) {
      try {
        var jsonResponse = json.decode(response.body);
        return Posts.fromJson(jsonResponse);
      } catch (e) {
        print('Error parsing JSON response: $e');
        return null;
      }
    } else {
      print('Request failed with status code: ${response.statusCode}');
      return null;
    }
  }

  Future<Posts?> createPost(Posts newPost) async {
    var url = Uri.parse('$baseUrl/posts');

    var headers = {'Content-Type': 'application/json'};

    var body = json.encode(newPost.toJson());
    var response = await client.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 201) {
      try {
        var jsonResponse = json.decode(response.body);
        var createdPost = Posts.fromJson(jsonResponse);
        return createdPost;
      } catch (e) {
        print('Error parsing JSON response: $e');
        return null;
      }
    } else {
      print('Request failed with status code: ${response.statusCode}');
      return null;
    }
  }

  Future<bool> updatePost(Posts updatedPost) async {
    var url = Uri.parse('$baseUrl/posts/${updatedPost.id}');
    var headers = {'Content-Type': 'application/json'};

    var response = await client.put(
      url,
      headers: headers,
      body: json.encode(updatedPost.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Request failed with status code: ${response.statusCode}');
      return false;
    }
  }

  Future<bool> deletePost(int postId) async {
    var url = Uri.parse('$baseUrl/posts/$postId');
    var response = await client.delete(url);

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Request failed with status code: ${response.statusCode}');
      return false;
    }
  }
}
