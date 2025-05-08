// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: (json['id'] as num).toInt(),
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String,
      authorAvatar: json['authorAvatar'] as String?,
      content: json['content'] as String,
      imageUrl: json['imageUrl'] as String?,
      likedByIds: (json['likedByIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      likesCount: (json['likesCount'] as num).toInt(),
      commentsCount: (json['commentsCount'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'authorAvatar': instance.authorAvatar,
      'content': instance.content,
      'imageUrl': instance.imageUrl,
      'likedByIds': instance.likedByIds,
      'likesCount': instance.likesCount,
      'commentsCount': instance.commentsCount,
      'createdAt': instance.createdAt.toIso8601String(),
    };
