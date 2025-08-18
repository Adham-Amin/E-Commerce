import 'package:ecommerce_app/features/main_layout/favourite/data/data_sources/local_watchlist_data_source.dart';
import 'package:ecommerce_app/features/main_layout/favourite/domain/repos/watchlist_repo.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/entities/products_entity.dart';

class WatchlistRepoImpl extends WatchlistRepo {
  final LocalWatchlistDataSource localWatchlistDataSource;

  WatchlistRepoImpl({required this.localWatchlistDataSource});
  @override
  @override
  Future<void> addToWatchlist({required ProductsEntity product}) async {
    final isInWatchlist = await localWatchlistDataSource.isMovieInWatchlist(
      productId: product.id
    );
    if (isInWatchlist) return;
    await localWatchlistDataSource.addToWatchlist(product: product);
  }

  @override
  Future<List<ProductsEntity>> getWatchlist() async {
    var movies = await localWatchlistDataSource.getWatchlist();
    return movies;
  }

  @override
  Future<bool> isMovieInWatchlist({required String productId}) async {
    return await localWatchlistDataSource.isMovieInWatchlist(productId: productId);
  }

  @override
  Future<void> removeFromWatchlist({required ProductsEntity product}) async {
    await localWatchlistDataSource.removeFromWatchlist(product: product);
  }
}
