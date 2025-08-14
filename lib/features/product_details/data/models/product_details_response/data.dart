import 'brand.dart';
import 'category.dart';
import 'subcategory.dart';

class Data {
	int? sold;
	List<dynamic>? images;
	List<Subcategory>? subcategory;
	int? ratingsQuantity;
	String? id;
	String? title;
	String? slug;
	String? description;
	int? quantity;
	int? price;
	String? imageCover;
	Category? category;
	Brand? brand;
	double? ratingsAverage;
	DateTime? createdAt;
	DateTime? updatedAt;
	int? v;
	List<dynamic>? reviews;

	Data({
		this.sold, 
		this.images, 
		this.subcategory, 
		this.ratingsQuantity, 
		this.id, 
		this.title, 
		this.slug, 
		this.description, 
		this.quantity, 
		this.price, 
		this.imageCover, 
		this.category, 
		this.brand, 
		this.ratingsAverage, 
		this.createdAt, 
		this.updatedAt, 
		this.v, 
		this.reviews,
	});

	factory Data.fromJson(Map<String, dynamic> json) => Data(
				sold: json['sold'] as int?,
				images: json['images'] as List<dynamic>?,
				subcategory: (json['subcategory'] as List<dynamic>?)
						?.map((e) => Subcategory.fromJson(e as Map<String, dynamic>))
						.toList(),
				ratingsQuantity: json['ratingsQuantity'] as int?,
				id: json['_id'] as String?,
				title: json['title'] as String?,
				slug: json['slug'] as String?,
				description: json['description'] as String?,
				quantity: json['quantity'] as int?,
				price: json['price'] as int?,
				imageCover: json['imageCover'] as String?,
				category: json['category'] == null
						? null
						: Category.fromJson(json['category'] as Map<String, dynamic>),
				brand: json['brand'] == null
						? null
						: Brand.fromJson(json['brand'] as Map<String, dynamic>),
				ratingsAverage: (json['ratingsAverage'] as num?)?.toDouble(),
				createdAt: json['createdAt'] == null
						? null
						: DateTime.parse(json['createdAt'] as String),
				updatedAt: json['updatedAt'] == null
						? null
						: DateTime.parse(json['updatedAt'] as String),
				v: json['__v'] as int?,
				reviews: json['reviews'] as List<dynamic>?,
			);

	Map<String, dynamic> toJson() => {
				'sold': sold,
				'images': images,
				'subcategory': subcategory?.map((e) => e.toJson()).toList(),
				'ratingsQuantity': ratingsQuantity,
				'_id': id,
				'title': title,
				'slug': slug,
				'description': description,
				'quantity': quantity,
				'price': price,
				'imageCover': imageCover,
				'category': category?.toJson(),
				'brand': brand?.toJson(),
				'ratingsAverage': ratingsAverage,
				'createdAt': createdAt?.toIso8601String(),
				'updatedAt': updatedAt?.toIso8601String(),
				'__v': v,
				'reviews': reviews,
			};
}
