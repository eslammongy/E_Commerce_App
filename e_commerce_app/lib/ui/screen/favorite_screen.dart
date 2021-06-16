import 'package:conditional_builder/conditional_builder.dart';
import 'package:e_commerce_app/bloc/bottombar/bottom_bar_cubit.dart';
import 'package:e_commerce_app/bloc/bottombar/bottom_bar_status.dart';
import 'package:e_commerce_app/ui/widgets/componant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomBarCubit, BottomBarStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is! ShopLoadingGetFavoritStatus,
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildListOfProduct(
                    BottomBarCubit.get(context)
                        .favoritesModel
                        .data
                        .data[index]
                        .product,
                    context,
                    isOldPrice: true),
                separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                itemCount: BottomBarCubit.get(context)
                    .favoritesModel
                    .data
                    .data
                    .length),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
