import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialseed/app/cubits/post/post_cubit.dart';
import 'package:socialseed/app/screens/post/post_screen.dart';
import 'package:socialseed/app/widgets/view_post_widget.dart';
import 'package:socialseed/dependency_injection.dart' as di;
import 'package:socialseed/domain/entities/post_entity.dart';
import 'package:socialseed/domain/entities/user_entity.dart';
import 'package:socialseed/utils/constants/page_const.dart';

import '../../../utils/constants/color_const.dart';

class FeedScreen extends StatefulWidget {
  final UserEntity user;

  const FeedScreen({super.key, required this.user});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<PostCubit>(
        create: (context) =>
            di.sl<PostCubit>()..getPosts(post: const PostEntity()),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: GestureDetector(
                  onTap: () {
                    // Navigate to the CreatePost screen when tapped

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => PostScreen(currentUser: widget.user),
                      ),
                    );
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.greyShadowColor),
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(widget.user.imageUrl.toString()),
                            radius: 20.0,
                          ),
                          const SizedBox(width: 10.0),
                          const Text(
                            "What's on your mind?",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    context
                        .read<PostCubit>()
                        .getPosts(post: const PostEntity());
                  },
                  child: BlocBuilder<PostCubit, PostState>(
                    builder: (context, state) {
                      if (state is PostLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is PostFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Data Fetching error'),
                          ),
                        );
                      }

                      if (state is PostLoaded) {
                        return (state.posts.isNotEmpty)
                            ? postCardWidget(
                                context, state.posts, widget.user, false)
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.no_photography_sharp),
                                  sizeVar(10),
                                  Text('No Post Avaliable')
                                ],
                              );
                      }

                      return const SizedBox();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
