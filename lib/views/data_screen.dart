import 'package:apitest/cubit/data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data')),
      body: BlocProvider(
        create: (context) => DataCubit()..fetchData(),
        child: BlocListener<DataCubit, DataState>(
          listener: (context, state) {
            if (state is DataFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Data Fetch Failed: ${state.error}'),
              ));
            }
          },
          child: BlocBuilder<DataCubit, DataState>(
            builder: (context, state) {
              if (state is DataLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is DataSuccess) {
                return ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Item ${state.products[index].createdByName}'),
                    );
                  },
                );
              } else {
                return Center(child: Text('No data available.'));
              }
            },
          ),
        ),
      ),
    );
  }
}
