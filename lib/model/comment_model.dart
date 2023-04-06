class CommentModel {
  dynamic id;
  int resourceId;
  int creatorId;
  String creatorName;
  String contents;
  int up;

  CommentModel({this.id, required this.resourceId, required this.creatorId, required this.creatorName,
      required this.contents, required this.up});


}