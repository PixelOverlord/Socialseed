// ignore: unused_import
import 'dart:io';

import 'package:socialseed/domain/entities/chat_entity.dart';
import 'package:socialseed/domain/entities/message_entity.dart';
import 'package:socialseed/domain/entities/post_entity.dart';
import 'package:socialseed/domain/entities/story_entity.dart';
import 'package:socialseed/domain/entities/user_entity.dart';

import '../entities/comment_entity.dart';

abstract class FirebaseRepository {
  // credential
  Future<void> signInUser(UserEntity user);
  Future<void> signUpUser(UserEntity user);
  Future<bool> isSignIn();
  Future<void> signOut();
  Future<void> forgotPassword(String email);

  // User Features
  Stream<List<UserEntity>> getUsers(UserEntity user);
  Stream<List<UserEntity>> getSingleUsers(String uid);
  Stream<List<UserEntity>> getSingleOtherUser(String otherUid);
  Future<String> getCurrentUid();
  Future<void> createUser(UserEntity user);
  Future<void> updateUser(UserEntity user);

  // cloud
  Future<String?> uploadImageToStorage(File? file, bool isPost, String child);

  // Posts
  Future<void> createPost(PostEntity post);
  Stream<List<PostEntity>> fetchPost(PostEntity post);
  Stream<List<PostEntity>> fetchPostByUid(String uid);
  Stream<List<PostEntity>> fetchSinglePost(String postId);
  Future<void> updatePost(PostEntity post);
  Future<void> deletePost(PostEntity post);
  Future<void> likePost(PostEntity post);
  Future<void> savePost(PostEntity post);
  Stream<List<PostEntity>> fetchSavedPosts(String uid);
  Future<void> archievePost(PostEntity post);
  Stream<List<PostEntity>> fetchArchievePosts(String uid);

  // Comments
  Future<void> createComment(CommentEntity comment);
  Stream<List<CommentEntity>> fetchComments(String postId);
  Future<void> updateComment(CommentEntity comment);
  Future<void> deleteComment(CommentEntity comment);
  Future<void> likeComment(CommentEntity comment);

  // user controller
  Future<void> followUser(UserEntity user);
  Future<void> unfollowUser(UserEntity user);
  Future<void> sendRequest(UserEntity user);
  Future<void> acceptRequest(UserEntity user);
  Future<void> rejectRequest(UserEntity user);

  // message
  Future<void> createMessageWithId(ChatEntity chat);
  Future<bool> isMessageIdExists(String messageId);
  Stream<List<ChatEntity>> fetchConversations();
  Future<void> sendMessage(String messageId, String message);
  Stream<List<MessageEntity>> fetchMessages(String messageId);

  // story
  Future<void> addStory(StoryEntity story);
  Stream<List<StoryEntity>> fetchStories(String uid);
  Future<void> viewStory(StoryEntity story);
  Future<void> updateUserStatus(String uid, bool isOnline);
}
