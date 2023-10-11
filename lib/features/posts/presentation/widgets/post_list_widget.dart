import 'package:clean_arch_posts_app/features/posts/domain/entities/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostListWidget extends StatelessWidget {
  const PostListWidget({super.key, required this.posts});

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        onTap: () {},
        leading: Text(posts[index].id.toString()),
        title: Text(
          posts[index].title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          posts[index].body,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      separatorBuilder: (context, index) => const Divider(
        thickness: 1,
      ),
      itemCount: posts.length,
    );
  }
}
