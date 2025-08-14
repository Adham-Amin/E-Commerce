class ProductDetailsEntity {
  final String id;
  final List<dynamic> images;
  final String title;
  final String description;
  final double rating;
  final int quantity;
  final int price;
  final int sold;

  ProductDetailsEntity( 
      {required this.id,
      required this.sold,
      required this.images,
      required this.title,
      required this.description,
      required this.rating,
      required this.quantity,
      required this.price});
}
