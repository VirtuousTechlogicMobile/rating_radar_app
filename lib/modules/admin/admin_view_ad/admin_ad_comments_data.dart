class AdminAdCommentsData {
  final String comment;
  final String userId;

  const AdminAdCommentsData({
    required this.comment,
    required this.userId,
  });
}

class AdminCommentsListUserData extends AdminAdCommentsData {
  final String username;
  final String userProfileImage;

  const AdminCommentsListUserData({
    required this.username,
    required this.userProfileImage,
    required super.comment,
    required super.userId,
  });
}
