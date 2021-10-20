class Story {
  final String id;
  final String title;
  final String content;
  final String author;
  final String source;
  final int likesCount;
  final int commentsCount;
  final DateTime createdTime;
  final dynamic bookmarks;
  final String imageUrl;
  final List<String> tags;
  final String language;

  Story.fromMap(Map<String, dynamic> map)
      : title = map['title'] ?? '-',
        id = map['id'] ?? '-',
        imageUrl = map['imageUrl'] ?? '-',
        content = map['content'] ?? '-',
        author = map['author'] ?? '-',
        createdTime = (map['createdTime'])?.toDate() ?? DateTime.now(),
        source = map['source'] ?? '-',
        language = map['language'] ?? 'Kinyarwanda',
        likesCount = map['likesCount'] ?? 0,
        commentsCount = map['commentsCount'] ?? 0,
        tags = map['tags'] == null
            ? []
            : map['tags'].map<String>((t) => t.toString()).toList(),
        bookmarks = map['bookmarks'] ?? {};

  Map<String, dynamic> toMap() => {
        'title': title,
        'imageUrl': imageUrl,
        'content': content,
        'createdTime': createdTime,
        'author': author,
        'tags': tags,
        'language': language,
        'source': source,
      };
}
