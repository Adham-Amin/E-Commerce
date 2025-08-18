import 'package:ecommerce_app/features/main_layout/favourite/domain/repos/watchlist_repo.dart';
import 'package:ecommerce_app/features/main_layout/favourite/presentation/cubit/wishlist_state.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/entities/products_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  final WatchlistRepo watchlistRepo;

  WatchlistCubit({required this.watchlistRepo}) : super(WatchlistInitial());

  Future<void> loadWatchlist() async {
    emit(WatchlistLoading());
    try {
      final watchlist = await watchlistRepo.getWatchlist();
      emit(WatchlistLoaded(watchlist));
    } catch (e) {
      emit(WatchlistError(e.toString()));
    }
  }

  Future<void> toggleWatchlist(ProductsEntity product) async {
    try {
      final isInWatchlist = await watchlistRepo.isMovieInWatchlist(productId: product.id);
      if (isInWatchlist) {
        await watchlistRepo.removeFromWatchlist(product: product);
      } else {
        await watchlistRepo.addToWatchlist(product: product);
      }
      await loadWatchlist();
    } catch (e) {
      emit(WatchlistError(e.toString()));
    }
  }

  Future<bool> isInWatchlist(String id) {
    return watchlistRepo.isMovieInWatchlist(productId: id);
  }
}
