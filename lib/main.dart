import 'package:flutter/material.dart';

import 'core/app_theme.dart';

void main(){
  runApp(const PostsApp());
}
class PostsApp extends StatelessWidget {
  const PostsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      title: 'Posts App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Posts App'
          ),
        ),
      ),
    );
  }
}
