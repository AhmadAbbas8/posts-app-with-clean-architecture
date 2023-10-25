import 'package:clean_arch_posts_app/features/posts/domain/entities/post.dart';
import 'package:flutter/material.dart';

class PostAddUpdateScreen extends StatelessWidget {
  final bool isUpdatePost;

  final Post? post;

  const PostAddUpdateScreen({super.key, required this.isUpdatePost, this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
    );
  }

  AppBar get appBar => AppBar(
        title: Text(isUpdatePost ? 'Edit Post' : 'Add Post'),
      );
}
