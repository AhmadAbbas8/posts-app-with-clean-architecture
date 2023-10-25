import 'package:clean_arch_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_arch_posts_app/features/posts/presentation/screens/post_add_update.dart';
import 'package:flutter/material.dart';


class UpdatePostBtnWidget extends StatelessWidget {
  final Post post;
  const UpdatePostBtnWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PostAddUpdateScreen(
                isUpdatePost: true,
                post: post,
              ),
            ));
      },
      icon: Icon(Icons.edit),
      label: Text("Edit"),
    );
  }
}