import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/widget/custom_loading.dart';
import 'package:ecommerce_app/features/main_layout/favourite/presentation/cubit/wishlist_cubit.dart';
import 'package:ecommerce_app/features/main_layout/favourite/presentation/cubit/wishlist_state.dart';
import 'package:ecommerce_app/features/main_layout/favourite/presentation/widgets/favourite_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSize.s14.w, vertical: AppSize.s10.h),
        child: BlocBuilder<WatchlistCubit, WatchlistState>(
          builder: (context, state) {
            if (state is WatchlistLoaded) {
              return ListView.builder(
                itemCount: state.watchlist.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.symmetric(vertical: AppSize.s12.h),
                      child: FavoriteItem(
                        product: state.watchlist[index],
                      ));
                },
              );
            } else if (state is WatchlistError) {
              return Center(child: Text(state.message));
            } else if (state is WatchlistLoading) {
              return const CustomLoading();
            } else {
              return Center(
                  child: Text('No Movies Found',
                      style: Theme.of(context).textTheme.headlineLarge));
            }
          },
        ));
  }
}
