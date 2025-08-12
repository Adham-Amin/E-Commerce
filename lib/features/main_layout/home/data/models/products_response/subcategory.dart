class Subcategory {
  String? id;
  String? title;
  String? slug;
  String? category;

  Subcategory({
    this.id,
    this.title,
    this.slug,
    this.category,
  });

  Subcategory.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    slug = json['slug'];
    category = json['category'];
  }

  toJson() => {
        '_id': id,
        'title': title,
        'slug': slug,
        'category': category,
      };
}
