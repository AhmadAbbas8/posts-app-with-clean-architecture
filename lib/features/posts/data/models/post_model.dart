import 'package:clean_arch_posts_app/features/posts/domain/entities/post.dart';

class PostModel extends Post {
  const PostModel(
      {required super.id, required super.title, required super.body});

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      PostModel(id: json['id'], title: json['title'], body: json['body']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
      };
}
