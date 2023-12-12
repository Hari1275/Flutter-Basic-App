import 'package:basic_app/models/post.dart';
import 'package:basic_app/screen/detail_screen.dart';
import 'package:basic_app/services/service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Services services = Services();
  List<Posts>? posts;

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  ////start
  Future<void> fetchPosts() async {
    try {
      final fetchedPosts = await services.getPosts();
      setState(() {
        posts = fetchedPosts;
      });
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  Future<void> createPost() async {
    try {
      final newPost = Posts(title: '1', userId: 2, body: 'hello');
      final createdPost = await services.createPost(newPost);
      if (createdPost != null) {
        setState(() {
          posts?.add(createdPost);
        });
      } else {
        print('Error creating post.');
      }
    } catch (e) {
      print('Error creating post: $e');
    }
  }

  Future<void> updatePost(Posts post) async {
    try {
      post.title = 'Updated Title';
      post.body = 'Updated body content';
      final success = await services.updatePost(post);
      if (success) {
        setState(() {
          posts = posts?.map((p) => p.id == post.id ? post : p).toList();
        });
      } else {
        print('Error updating post.');
      }
    } catch (e) {
      print('Error updating post: $e');
    }
  }

  Future<void> deletePost(int postId) async {
    try {
      final success = await services.deletePost(postId);
      if (success) {
        setState(() {
          posts?.removeWhere((post) => post.id == postId);
        });
      } else {
        print('Error deleting post.');
      }
    } catch (e) {
      print('Error deleting post: $e');
    }
  }

  //end

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Example'),
      ),
      body: posts == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: posts?.length ?? 0,
              itemBuilder: (context, index) {
                final post = posts![index];
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body ?? ''),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => DetailScreen(
                                  post: post,
                                ))));
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          updatePost(post);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deletePost(post.id!);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          createPost();
        },
      ),
    );
  }
}
