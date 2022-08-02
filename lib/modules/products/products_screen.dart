import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '../../shared/components/app_components.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({Key? key}) : super(key: key);
  late ShopCubit cubit;
  @override
  Widget build(BuildContext context) {
    cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        /// show an error if status is wrong
        if (state is ShopSuccessChangeFavoritesState) {
          if (!state.model.status) {
            showToast(text: state.model.message, state: ToastStates.error);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: (ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null),
          builder: (context) => productBuilder(
              ShopCubit.get(context).homeModel!,
              ShopCubit.get(context).categoriesModel!,
              context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productBuilder(HomeModel model, CategoriesModel categoriesModel,
          BuildContext context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage(e.image.toString()),
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250,
                // when he reaches the end he will start again from beginning
                // it's true by default
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                // that will make the image take all the slider width
                // if this is 0.8 or something else some other photos
                // will appear from the two sides
                viewportFraction: 1,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 120,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategoryItem(categoriesModel.data.data[index]),
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 10.0),
                      itemCount: categoriesModel.data.data.length,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              color: Colors.grey[300],
              padding: EdgeInsets.all(2),
              child: GridView.count(
                // change the behavior of trying to take the most space so that the ListView only occupies the space it needs (it will still scroll when there more items).
                shrinkWrap: true, physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2.0,
                childAspectRatio: 1 / 1.7,
                children: List.generate(
                  model.data.products.length,
                  (index) =>
                      buildGridProduct(model.data.products[index], context),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildCategoryItem(DataModel category) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image(
            image: NetworkImage(category.image),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.8),
            width: 100,
            padding: EdgeInsets.all(2),
            child: Text(
              category.name,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      );
  Widget buildGridProduct(ProductModel product, BuildContext context) =>
      Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(alignment: Alignment.bottomLeft, children: [
              Image(
                image: NetworkImage(product.image),
                width: double.maxFinite,
                height: 200,
              ),
              if (product.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.white,
                    ),
                  ),
                ),
            ]),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(height: 1.3, color: Colors.black),
              ),
            ),
            Row(
              children: [
                Text(
                  product.price.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    height: 1.3,
                    color: defaultColor,
                  ),
                ),
                if (product.discount != 0)
                  Text(
                    product.oldPrice.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    cubit.changeFavorites(product.id);
                    print(product.inFavorites);
                  },
                  icon: CircleAvatar(
                    radius: 15,
                    backgroundColor:
                        ShopCubit.get(context).favorites[product.id]!
                            ? defaultColor
                            : Colors.grey,
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );
}
