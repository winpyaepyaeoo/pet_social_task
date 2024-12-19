import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_social_task/bloc/get/cubit/get_posts_cubit.dart';

import '../data/api/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GetPostsCubit getPostsCubit;
  final ScrollController _scrollController = ScrollController();
  int pageLimit = 0;

  @override
  void initState() {
    super.initState();
    getPostsCubit = GetPostsCubit(apiService: ApiService());
    getPostsCubit.loadPosts(isInitialLoad: true);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          getPostsCubit.nextCursor != null) {
        getPostsCubit.loadPosts();
      }
    });
  }

  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF1FCFF),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Posts List'),
        ),
        body: BlocBuilder<GetPostsCubit, GetPostsState>(
          bloc: getPostsCubit,
          builder: (context, state) {
            if (state is GetPostsLoading && getPostsCubit.allPosts.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetPostsFail) {
              return Center(child: Text(state.error));
            } else if (state is GetPostsSuccess) {
              int postLength = state.post.length;
              return ListView.builder(
                controller: _scrollController,
                itemCount: postLength + 1,
                itemBuilder: (context, index) {
                  debugPrint("list length is ${state.post.length}");
                  if (index < state.post.length) {
                    final post = state.post[index];
                    return postWidget(
                        post.user.avatar.toString(),
                        post.user.name,
                        post.createdAtReadable,
                        post.media,
                        post.body,
                        post.reactionsCount,
                        post.commentsCount,
                        post.sharesCount);
                  } else {
                    return const Center(child: Text("No more posts"));
                  }
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  Widget postWidget(
      String userImage,
      String name,
      String postedDate,
      List<String> mediaList,
      String body,
      int reactCount,
      int commentCount,
      int sharedCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Row(
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: userImage,
                    width: 60,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(postedDate)
                  ],
                )
              ],
            ),
            const SizedBox(height: 5),
            mediaList.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: mediaList.length,
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(
                        height: 150,
                        width: double.infinity,
                        imageUrl: mediaList[index],
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      );
                    })
                : const SizedBox(
                    height: 150,
                    child: Center(child: Text('No Image')),
                  ),
            Text(body),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                reactWidget(reactCount, 'assets/images/like.png'),
                reactWidget(commentCount, 'assets/images/comment.png'),
                reactWidget(sharedCount, 'assets/images/share.png'),
              ],
            )
          ]),
        ),
      ),
    );
  }

  Widget reactWidget(int count, String react) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.28,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '$count',
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(
            width: 5,
          ),
          Image.asset(
            react,
            height: 25,
          ),
        ],
      ),
    );
  }
}
