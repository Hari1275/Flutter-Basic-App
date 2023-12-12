import 'dart:js_util';

import 'package:basic_app/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DetailScreen extends StatelessWidget {
  final Posts post;
  const DetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.9, color: Colors.black),
        ),
        height: 250,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [Text(post.title), Divider(), Text(post.body.toString())],
          ),
        ),
      ),
    ));
  }
}
