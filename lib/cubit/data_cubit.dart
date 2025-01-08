import 'package:apitest/model/product_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  final Dio _dio = Dio();

  DataCubit() : super(DataInitial());

  Future<void> fetchData() async {
    emit(DataLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('authToken');

      if (token == null) {
        throw Exception('No token found');
      }

      final response = await _dio.post(
        'http://10.207.252.138:9091/api/fms-module/VehicleTypes/search',
        options: Options(
          headers: {
            'Authorization': '$token',
          },
        ),
      );

      final List<ProductModel> products =(response.data as List).map((item) => ProductModel.fromJson(item)).toList();
      emit(DataSuccess(products));
    } catch (error) {
      emit(DataFailure(error.toString()));
    }
  }
  
  Future<void> createPost(ProductModel post) async {
    try {
      await _dio.post(
        '',
        data: post.toJson(),
      );
      fetchData(); 
    } catch (e) {
      print("Error creating post: $e");
    }
  }

  Future<void> updatePost(ProductModel post) async {
    try {
      await _dio.put(
        '',
        data: post.toJson(),
      );
      fetchData(); 
    } catch (e) {
      print("Error updating post: $e");
    }
  }

  // Delete a post
  Future<void> deletePost(String postId) async {
    try {
      await _dio.delete('');
      fetchData();
    } catch (e) {
      print("Error deleting post: $e");
    }
  }
}