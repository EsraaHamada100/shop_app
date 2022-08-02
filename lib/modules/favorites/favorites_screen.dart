import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/shared/components/app_components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

import '../../shared/cubit/states.dart';
import '../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        body: SafeArea(
          child: ConditionalBuilder(
            condition: state is! ShopLoadingGetFavoritesState,
            builder: (_) => ListView.separated(
              itemBuilder: (context, index) => buildProductItem(
                  ShopCubit.get(context)
                      .favoritesModel!
                      .data!
                      .favoritesDataList[index]!.product,
                  context),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: ShopCubit.get(context)
                  .favoritesModel!
                  .data
                  .favoritesDataList
                  .length,
            ),
            fallback: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFavoriteItem(FavoritesData model, BuildContext context) =>
      Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(alignment: Alignment.bottomLeft, children: [
                Image(
                  image: NetworkImage(model.product.image),
                  width: 100,
                  height: 120,
                ),
                if (model.product.discount != 0)
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
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      model.product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(height: 1.3, color: Colors.black),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          model.product!.price.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            height: 1.3,
                            color: defaultColor,
                          ),
                        ),
                        if (model.product.discount != 0)
                          Text(
                            model.product.oldPrice.toString(),
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
                            ShopCubit.get(context)
                                .changeFavorites(model.product.id);
                            // print(model.product!.inFavorites);
                          },
                          icon: CircleAvatar(
                            radius: 15,
                            backgroundColor: ShopCubit.get(context)
                                    .favorites[model.product.id]!
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
              ),
            ],
          ),
        ),
      );
}
