
class Post{
  final String userId;
Post({
  required this.userId
});


factory Post.fromJson(Map<int, dynamic> jason) =>Post(
  userId: jason['userId'],
);
}