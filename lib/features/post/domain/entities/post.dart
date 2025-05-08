import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post extends Equatable {
  final int id;
  final String authorId;
  final String authorName;
  final String? authorAvatar;
  final String content;
  final String? imageUrl;
  final List<String> likedByIds;
  final int likesCount;
  final int commentsCount;
  final DateTime createdAt;

  const Post({
    required this.id,
    required this.authorId,
    required this.authorName,
    this.authorAvatar,
    required this.content,
    this.imageUrl,
    required this.likedByIds,
    required this.likesCount,
    required this.commentsCount,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  @override
  List<Object?> get props => [
        id,
        authorId,
        authorName,
        authorAvatar,
        content,
        imageUrl,
        likedByIds,
        likesCount,
        commentsCount,
        createdAt,
      ];
}
