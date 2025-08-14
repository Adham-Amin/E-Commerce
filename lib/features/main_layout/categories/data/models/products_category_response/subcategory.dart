class Subcategory {
  final String? id;
  final String? title;
  final String? slug;
  final String? category;

  Subcategory(
      {required this.id,
      required this.title,
      required this.slug,
      required this.category});

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id: json['_id'],
      title: json['name'],
      slug: json['slug'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': title,
        'slug': slug,
        'category': category,
      };
}
