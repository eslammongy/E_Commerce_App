import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:e_commerce_app/bloc/bottombar/bottom_bar_cubit.dart';
import 'package:e_commerce_app/bloc/bottombar/bottom_bar_status.dart';
import 'package:e_commerce_app/model/home_model.dart';
import 'package:e_commerce_app/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomBarCubit, BottomBarStatus>(
        listener: (context, state) {},
        builder: (context, State) {
          return ConditionalBuilder(
              condition: BottomBarCubit.get(context).homeModel != null,
              builder: (context) =>
                  buildHomeWidget(BottomBarCubit.get(context).homeModel),
              fallback: (context) => Center(
                    child: CircularProgressIndicator(),
                  ));
        });
  }

  Widget buildHomeWidget(HomeModel homeModel) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
              items: homeModel.data.banners
                  .map((e) => Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            image: NetworkImage("${e.image}"),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                  height: 200,
                  initialPage: 0,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal)),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 4.0,
              childAspectRatio: 1 / 1.6,
              children: List.generate(
                  homeModel.data.products.length,
                  (index) =>
                      buildGridProductItem(homeModel.data.products[index])),
            ),
          )
        ],
      ),
    );
  }

  Widget buildGridProductItem(ProductsModel productsModel) => Container(
        color: Colors.white,
        child: Column(
          children: [
            Stack(alignment: AlignmentDirectional.bottomStart, children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: NetworkImage(productsModel.image),
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: 200,
                ),
              ),
              if (productsModel.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "Discount",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                )
            ]),
            SizedBox(
              height: 5,
            ),
            Text(
              productsModel.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.amber[900],
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Text(
                    "${productsModel.price.round()}",
                    style: TextStyle(
                        color: defaultColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  if (productsModel.discount != 0)
                    Text(
                      "${productsModel.oldPrice.round()}",
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.lineThrough),
                      textAlign: TextAlign.start,
                    ),
                  Spacer(),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.favorite_border))
                ],
              ),
            ),
          ],
        ),
      );
}
