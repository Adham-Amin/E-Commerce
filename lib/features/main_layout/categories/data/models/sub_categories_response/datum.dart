class Datum {
	String? id;
	String? name;
	String? slug;
	String? category;
	DateTime? createdAt;
	DateTime? updatedAt;

	Datum({
		this.id, 
		this.name, 
		this.slug, 
		this.category, 
		this.createdAt, 
		this.updatedAt, 
	});

	factory Datum.fromJson(Map<String, dynamic> json) => Datum(
				id: json['_id'] as String?,
				name: json['name'] as String?,
				slug: json['slug'] as String?,
				category: json['category'] as String?,
				createdAt: json['createdAt'] == null
						? null
						: DateTime.parse(json['createdAt'] as String),
				updatedAt: json['updatedAt'] == null
						? null
						: DateTime.parse(json['updatedAt'] as String),
			);

	Map<String, dynamic> toJson() => {
				'_id': id,
				'name': name,
				'slug': slug,
				'category': category,
				'createdAt': createdAt?.toIso8601String(),
				'updatedAt': updatedAt?.toIso8601String(),
			};
}
