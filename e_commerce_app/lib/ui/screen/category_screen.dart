import 'package:e_commerce_app/bloc/bottombar/bottom_bar_cubit.dart';
import 'package:e_commerce_app/bloc/bottombar/bottom_bar_status.dart';
import 'package:e_commerce_app/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomBarCubit, BottomBarStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildCategoryPageItem(
                  BottomBarCubit.get(context).categoriesModel.data.data[index]),
              separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
              itemCount:
                  BottomBarCubit.get(context).categoriesModel.data.data.length);
        });
  }

  Widget buildCategoryPageItem(DataModel dataModel) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(dataModel.image),
              width: 120,
              height: 120,
              fit: BoxFit.contain,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              dataModel.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.orange[900],
                  fontWeight: FontWeight.w700),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
