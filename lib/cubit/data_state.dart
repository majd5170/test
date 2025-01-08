part of 'data_cubit.dart';

@immutable
abstract class DataState {}

class DataInitial extends DataState {}

class DataLoading extends DataState {}

class DataSuccess extends DataState {
  final List<ProductModel> products;
  DataSuccess(this.products);
}

class DataFailure extends DataState {
  final String error;
  DataFailure(this.error);
}