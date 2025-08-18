import 'package:ecommerce_app/features/main_layout/home/domain/entities/products_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class LocalWatchlistDataSource {
  Future<void> addToWatchlist({required ProductsEntity product});
  Future<void> removeFromWatchlist({required ProductsEntity product});
  Future<bool> isMovieInWatchlist({required String productId});
  Future<List<ProductsEntity>> getWatchlist();
}
class LocalWatchlistDataSourceImpl extends LocalWatchlistDataSource {
  @override
  Future<void> addToWatchlist({required ProductsEntity product}) async {
    final watchlistBox = Hive.box<ProductsEntity>('watchlist');
    await watchlistBox.put(product.id, product);
  }

  @override
  Future<void> removeFromWatchlist({required ProductsEntity product}) async {
    final watchlistBox = Hive.box<ProductsEntity>('watchlist');
    await watchlistBox.delete(product.id);
  }

  @override
  Future<bool> isMovieInWatchlist({required String productId}) async {
    final watchlistBox = Hive.box<ProductsEntity>('watchlist');
    return watchlistBox.containsKey(productId);
  }

  @override
  Future<List<ProductsEntity>> getWatchlist() async {
    final watchlistBox = Hive.box<ProductsEntity>('watchlist');
    return watchlistBox.values.toList();
  }
}
