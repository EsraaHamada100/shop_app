import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/modules/search/cubit/search_cubit.dart';
import 'package:shop_app/modules/search/cubit/search_states.dart';
import 'package:shop_app/shared/components/app_components.dart';

import '../../shared/cubit/cubit.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              // foregroundColor: Colors.black,
              ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    validate: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Enter text to search';
                      }
                      return null;
                    },
                    prefix: Icons.search,
                    onChange: (val) {},
                    onSubmit: (value) {
                      print('You submitted your data');
                      SearchCubit.get(context).search(value);
                    },
                    label: 'search',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (state is SearchLoadingState) LinearProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  // to take the remaining space
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => buildProductItem(
                        SearchCubit.get(context)
                            .model!
                            .data
                            .productsDataList[index],
                        context,
                        isSearch : true,
                      ),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: SearchCubit.get(context)
                          .model!
                          .data
                          .productsDataList
                          .length,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
