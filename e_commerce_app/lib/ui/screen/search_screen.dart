import 'package:e_commerce_app/bloc/search_bloc/search_cubit.dart';
import 'package:e_commerce_app/bloc/search_bloc/search_status.dart';
import 'package:e_commerce_app/ui/widgets/componant.dart';
import 'package:e_commerce_app/ui/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    textInputField(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return "enter text to start search";
                          }
                          return "Success";
                        },
                        onSubmit: (String text) {
                          SearchCubit.get(context).getSearchResult(text);
                        },
                        label: "Search Product",
                        prefix: Icons.search),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is SearchLoadingResultStatus)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is SearchSuccessStatus)
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buildListOfProduct(
                                SearchCubit.get(context)
                                    .searchModel
                                    .data
                                    .data[index],
                                context,
                                isOldPrice: false),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10,
                                ),
                            itemCount: SearchCubit.get(context)
                                .searchModel
                                .data
                                .data
                                .length),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
