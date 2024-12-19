part of 'get_posts_cubit.dart';

sealed class GetPostsState extends Equatable {
  const GetPostsState();

  @override
  List<Object> get props => [];
}

final class GetPostsInitial extends GetPostsState {}

final class GetPostsLoading extends GetPostsState {}

final class GetPostsSuccess extends GetPostsState {
  final List<Post> post;
  final String? nextCursor;
  const GetPostsSuccess({required this.post, required this.nextCursor});

  @override
  List<Object> get props => [post];
}

final class GetPostsFail extends GetPostsState {
  String error;
  GetPostsFail({required this.error});
  @override
  List<Object> get props => [error];
}
