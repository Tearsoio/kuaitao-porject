/// 雷帖数据模型
class ThunderPost {
  final String id;
  final String title;
  final String coverKey; // seafood / scenic / hotel / bbq / digital / beauty
  final String coverEmoji;
  final int bombs; // 1..5
  final double loss; // 损失金额（元）
  final String location;
  final String avoidCount; // 已避雷人数（带 k/万）
  final String? badge; // 例: "热议" / "新雷" / null（用爆炸数代替）
  final String category; // 全部 / 景点 / 美食 / ...
  final double coverHeight; // 卡片封面高度
  final String? authorName;
  final String? authorAvatarChar;
  final String? content;
  final List<String> topics;

  const ThunderPost({
    required this.id,
    required this.title,
    required this.coverKey,
    required this.coverEmoji,
    required this.bombs,
    required this.loss,
    required this.location,
    required this.avoidCount,
    required this.coverHeight,
    required this.category,
    this.badge,
    this.authorName,
    this.authorAvatarChar,
    this.content,
    this.topics = const <String>[],
  });
}

/// 评论数据模型
class CommentItem {
  final String avatarChar;
  final int avatarStyle; // 1..4
  final String name;
  final String time;
  final String content;
  final int likes;

  const CommentItem({
    required this.avatarChar,
    required this.avatarStyle,
    required this.name,
    required this.time,
    required this.content,
    required this.likes,
  });
}

/// 当前用户简单模型
class UserProfile {
  final String nickname;
  final String avatarChar;
  final int level;
  final int savedCount; // 因你避雷的人数
  final int postCount;
  final int favoriteCount;
  final String likes;
  final String? phone;
  final String? bio;
  final List<String> interests;

  const UserProfile({
    required this.nickname,
    required this.avatarChar,
    required this.level,
    required this.savedCount,
    required this.postCount,
    required this.favoriteCount,
    required this.likes,
    this.phone,
    this.bio,
    this.interests = const <String>[],
  });

  UserProfile copyWith({
    String? nickname,
    String? avatarChar,
    int? level,
    int? savedCount,
    int? postCount,
    int? favoriteCount,
    String? likes,
    String? phone,
    String? bio,
    List<String>? interests,
  }) {
    return UserProfile(
      nickname: nickname ?? this.nickname,
      avatarChar: avatarChar ?? this.avatarChar,
      level: level ?? this.level,
      savedCount: savedCount ?? this.savedCount,
      postCount: postCount ?? this.postCount,
      favoriteCount: favoriteCount ?? this.favoriteCount,
      likes: likes ?? this.likes,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      interests: interests ?? this.interests,
    );
  }
}
