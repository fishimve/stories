class Language {
  final String title;
  final List<String> storiesTags;
  final List<String> authors;
  Language({
    required this.title,
    required this.storiesTags,
    required this.authors,
  });

  static Language fromMap(Map<String, dynamic> map) => Language(
        title: map['title'] ?? 'English',
        storiesTags: map['storiesTags'] != null
            ? map['storiesTags'].map<String>((t) => t.toString()).toList()
            : [],
        authors: map['authors'] == null
            ? []
            : map['authors'].map<String>((t) => t.toString()).toList(),
      );
}
