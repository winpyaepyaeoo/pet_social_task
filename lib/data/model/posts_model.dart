// Post Model with Null Safety
class Post {
  final int id;
  final String uuid;
  final String body;
  final List<String> media;
  final User user;
  final String createdAt;
  final String createdAtReadable;
  final bool isCurrentUserPost;
  final bool hasReactions;
  final int reactionsCount;
  final List<Reaction> reactions;
  final bool hasComments;
  final int commentsCount;
  final List<Comment> comments;
  final int sharesCount;

  Post({
    required this.id,
    required this.uuid,
    required this.body,
    required this.media,
    required this.user,
    required this.createdAt,
    required this.createdAtReadable,
    required this.isCurrentUserPost,
    required this.hasReactions,
    required this.reactionsCount,
    required this.reactions,
    required this.hasComments,
    required this.commentsCount,
    required this.comments,
    required this.sharesCount,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] ?? 0,
      uuid: json['uuid'] ?? '',
      body: json['body'] ?? '',
      media: List<String>.from(json['media'] ?? []),
      user: User.fromJson(json['user'] ?? {}),
      createdAt: json['created_at'] ?? '',
      createdAtReadable: json['created_at_readable'] ?? '',
      isCurrentUserPost: json['is_current_user_post'] ?? false,
      hasReactions: json['has_reactions'] ?? false,
      reactionsCount: json['reactions_count'] ?? 0,
      reactions: (json['reactions'] as List<dynamic>?)
              ?.map((e) => Reaction.fromJson(e))
              .toList() ??
          [],
      hasComments: json['has_comments'] ?? false,
      commentsCount: json['comments_count'] ?? 0,
      comments: (json['comments'] as List<dynamic>?)
              ?.map((e) => Comment.fromJson(e))
              .toList() ??
          [],
      sharesCount: json['shares_count'] ?? 0,
    );
  }
}

class User {
  final int id;
  final String username;
  final String name;
  final String avatar;

  User({
    required this.id,
    required this.username,
    required this.name,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }
}

class Reaction {
  final int id;
  final String type;
  final User user;

  Reaction({
    required this.id,
    required this.type,
    required this.user,
  });

  factory Reaction.fromJson(Map<String, dynamic> json) {
    return Reaction(
      id: json['id'] ?? 0,
      type: json['type'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
    );
  }
}

class Comment {
  final int id;
  final String body;
  final User user;
  final String createdAt;
  final String createdAtReadable;
  final List<String> media;
  final bool hasReactions;
  final int? reactionsCount;

  Comment({
    required this.id,
    required this.body,
    required this.user,
    required this.createdAt,
    required this.createdAtReadable,
    required this.media,
    required this.hasReactions,
    this.reactionsCount,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] ?? 0,
      body: json['body'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
      createdAt: json['created_at'] ?? '',
      createdAtReadable: json['created_at_readable'] ?? '',
      media: List<String>.from(json['media'] ?? []),
      hasReactions: json['has_reactions'] ?? false,
      reactionsCount: json['reactions_count'] as int?,
    );
  }
}
