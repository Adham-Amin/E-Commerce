import 'package:ecommerce_app/features/main_layout/home/domain/entities/products_entity.dart';

abstract class WatchlistRepo {
  Future<void> addToWatchlist({required ProductsEntity product});
  Future<void> removeFromWatchlist({required ProductsEntity product});
  Future<bool> isMovieInWatchlist({required String productId});
  Future<List<ProductsEntity>> getWatchlist();
}