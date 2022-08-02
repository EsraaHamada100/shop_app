import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
            itemBuilder: (context, index) => buildCategoryItem(
                ShopCubit.get(context).categoriesModel!.data.data[index]),
            separatorBuilder: (context, index) => Divider(),
            itemCount: ShopCubit.get(context).categoriesModel!.data.data.length,
          );
        });
  }

  Widget buildCategoryItem(DataModel category) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(category.image),
            height: 80.0,
            width: 80.0,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 20),
          Text(
            category.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }
}
