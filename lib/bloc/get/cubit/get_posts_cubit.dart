import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_social_task/data/api/api_service.dart';

import '../../../data/model/paginated_posts-model.dart';
import '../../../data/model/posts_model.dart';

part 'get_posts_state.dart';

class GetPostsCubit extends Cubit<GetPostsState> {
  ApiService apiService;
  List<Post> allPosts = [];
  String? nextCursor;
  GetPostsCubit({required this.apiService}) : super(GetPostsInitial());

  Future<void> loadPosts({bool isInitialLoad = false}) async {
    if (state is GetPostsLoading) return;

    if (isInitialLoad) {
      allPosts.clear();
      nextCursor = null;
      debugPrint("isInitialLoad is$isInitialLoad");
    }

    emit(GetPostsLoading());

    try {
      final response = await apiService.fetchPosts(nextCursor: nextCursor);

      final postResponse = PaginatedPostsModel.fromJson(response);
      debugPrint('Post response is$postResponse');
      allPosts.addAll(postResponse.posts);
      nextCursor = postResponse.meta.nextCursor;

      emit(GetPostsSuccess(post: allPosts, nextCursor: nextCursor));
    } catch (e) {
      emit(GetPostsFail(
        error: "Failed to load posts: $e",
      ));
    }
  }
}
