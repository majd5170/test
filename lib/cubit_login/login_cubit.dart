import 'package:apitest/model/classAuthResponse.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Dio _dio = Dio();

  LoginCubit() : super(LoginInitial());

  Future<void> login(String username, String password) async {
    emit(LoginLoading());
    try {
      final response = await _dio.post(
        'http://10.207.252.112:9090/api/users-module/Authentication/login',
        data: {'username': username, 'password': password},
        options: Options(
          headers: {
            "DeviceModel": 'Windows 10',
            "DeviceType": 'Web',
            "DeviceOs": 'Windows',
            "BaseDeviceId": '3c212d88-cd4a-4593-a4b0-65859fb175a5',
            "Platform": 'ERP CMS',
            "Version": 'V 1.0',
          },
        ),
      );
      
      final authResponse = AuthResponse.fromJson(response.data);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', authResponse.token!);
      
      emit(LoginSuccess(authResponse.token!));
    } catch (error) {
      if (error is DioError) {
        emit(LoginFailure(error.response?.data['message'] ?? error.message));
      } else {
        emit(LoginFailure(error.toString()));
      }
    }
  }
}
