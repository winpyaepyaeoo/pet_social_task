// import 'package:dio/dio.dart';
// import 'package:pet_social_task/data/api/auth_service.dart';
// import 'package:retrofit/retrofit.dart';
// import '../model/paginated_posts-model.dart';
// import '../model/posts_model.dart';

// part 'api_service.g.dart';

// @RestApi(baseUrl: 'https://backend.wecarethepets.com/api/')
// abstract class ApiService {
//   factory ApiService(Dio dio) => _ApiService(dio);

//   // AuthService authService = AuthService();
//   //  String? token = authService.getToken();

//   @GET('posts')
//   Future<PaginatedPostsModel> getPostsList(
//       @Query('cursor') String? cursor, @Header('Authorization') String auth);
// }

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:pet_social_task/data/api/auth_service.dart';

// class ApiService {
//   final String baseUrl =
//       "https://backend.wecarethepets.com/api"; // Base API URL

//   AuthService authService = AuthService();

//   Future<Map<String, dynamic>> fetchPosts({String? nextCursor}) async {
//     String? token = authService.getToken();
//     final url = Uri.parse("$baseUrl/posts?cursor=$nextCursor");
//     print('Base Url is $url');
//     final response = await http.get(
//       url,
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//     );
//     print(response.statusCode);

//     print(response);
//     if (response.statusCode == 200) {
//       print(response.body);
//       return json.decode(response.body);
//       // Return parsed JSON
//     } else {
//       throw Exception("Failed to load data");
//     }
//   }
// }
import 'package:dio/dio.dart';
import 'package:pet_social_task/data/api/auth_service.dart';

class ApiService {
  final String baseUrl =
      "https://backend.wecarethepets.com/api"; // Base API URL

  AuthService authService = AuthService();
  late Dio dio;

  ApiService() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  Future<Map<String, dynamic>> fetchPosts({String? nextCursor}) async {
    try {
      String? token = authService.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get(
        '/posts',
        queryParameters: {
          'cursor': nextCursor,
        },
      );

      if (response.statusCode == 200) {
        print("Posts is${response.data}");
        return response.data;
      } else {
        print(" Error code is${response.statusCode}");
        throw Exception(
            "Failed to load data with status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          throw Exception("Connection timed out. Please try again later.");
        case DioExceptionType.sendTimeout:
          throw Exception("Request timed out while sending data.");
        case DioExceptionType.receiveTimeout:
          throw Exception(
              "Request timed out while waiting for server response.");
        case DioExceptionType.badCertificate:
          throw Exception("SSL certificate validation failed.");
        case DioExceptionType.badResponse:
          final statusCode = e.response?.statusCode;

          throw Exception("Server responded with status code $statusCode");
        case DioExceptionType.cancel:
          throw Exception("Request was cancelled.");
        case DioExceptionType.connectionError:
          throw Exception("No internet connection. Please check your network.");
        case DioExceptionType.unknown:
        default:
          throw Exception("An unknown error occurred: ${e.message}");
      }
    } catch (e) {
      // Catch any other unexpected errors
      throw Exception("Unexpected error: $e");
    }
  }
}
