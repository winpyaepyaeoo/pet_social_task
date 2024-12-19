// PostResponse.dart

import 'package:pet_social_task/data/model/posts_model.dart';

class PaginatedPostsModel {
  final List<Post> posts;
  final Meta meta;

  PaginatedPostsModel({required this.posts, required this.meta});

  factory PaginatedPostsModel.fromJson(Map<String, dynamic> json) {
    return PaginatedPostsModel(
      posts:
          (json['data'] as List<dynamic>).map((e) => Post.fromJson(e)).toList(),
      meta: Meta.fromJson(json['meta']),
    );
  }
}

class Meta {
  final String path;
  final int perPage;
  final String? nextCursor;
  final String? prevCursor;

  Meta({
    required this.path,
    required this.perPage,
    this.nextCursor,
    this.prevCursor,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      path: json['path'],
      perPage: json['per_page'],
      nextCursor: json['next_cursor'],
      prevCursor: json['prev_cursor'],
    );
  }
}
