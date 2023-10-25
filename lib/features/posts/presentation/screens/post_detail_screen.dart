import 'package:flutter/material.dart';

import '../../domain/entities/post.dart';
import '../widgets/post_detail_widget.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;

  const PostDetailPage({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }

  AppBar get appBar => AppBar(
        title: Text("Post Detail"),
      );

  Widget get body => Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: PostDetailWidget(post: post),
        ),
      );
}
