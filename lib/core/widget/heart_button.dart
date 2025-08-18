import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/features/main_layout/favourite/presentation/cubit/wishlist_cubit.dart';
import 'package:ecommerce_app/features/main_layout/favourite/presentation/cubit/wishlist_state.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/entities/products_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeartButton extends StatelessWidget {
  final String id;
  final ProductsEntity product;

  const HeartButton({
    super.key,
    required this.id,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistCubit, WatchlistState>(
      builder: (context, state) {
        bool isInWishlist = false;

        if (state is WatchlistLoaded) {
          isInWishlist = state.watchlist.any((p) => p.id == id);
        }

        return InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          onTap: () {
            context.read<WatchlistCubit>().toggleWatchlist(product);
          },
          child: Material(
            color: ColorManager.white,
            elevation: 5,
            shape: const StadiumBorder(),
            shadowColor: ColorManager.black,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: ImageIcon(
                AssetImage(isInWishlist
                        ? IconsAssets.icClickedHeart 
                        : IconsAssets.icHeart
                    ),
                color: ColorManager.primary,
              ),
            ),
          ),
        );
      },
    );
  }
}
