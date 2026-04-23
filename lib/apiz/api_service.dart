import 'package:flutter_movie_app/data/api_response_model.dart';
import 'package:flutter_movie_app/data/image_response_model.dart';
import 'package:flutter_movie_app/data/movie_db_response_model.dart';
import 'package:flutter_movie_app/data/movie_details_response_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  ApiService._internal();

  static final ApiService _instance = ApiService._internal();

  static ApiService get instance => _instance;

  Future<ApiResponseModel> getMovie(String url, {String? cacheKey}) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final result = movieDBResponseModelFromJson(response.body);

        return ApiResponseModel(
          error: false,
          list: result,
        );
      }

      return ApiResponseModel(
        error: true,
        message: "Gagal mengambil data film.",
      );
    } catch (e) {
      print("GET MOVIE ERROR: $e");

      return ApiResponseModel(
        error: true,
        message: "Terjadi kesalahan sistem.",
      );
    }
  }

  Future<ApiResponseModel> getMovieDetails(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final result = movieDetailsModelFromJson(response.body);

        return ApiResponseModel(
          error: false,
          list: result,
        );
      }

      return ApiResponseModel(
        error: true,
        message: "Detail film gagal dimuat.",
      );
    } catch (e) {
      print("DETAIL ERROR: $e");

      return ApiResponseModel(
        error: true,
        message: "Terjadi kesalahan sistem.",
      );
    }
  }

  Future<ApiResponseModel> getImageList(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final result = imageModelFromJson(response.body);

        return ApiResponseModel(
          error: false,
          list: result,
        );
      }

      return ApiResponseModel(
        error: true,
        message: "Gagal memuat gambar.",
      );
    } catch (e) {
      print("IMAGE ERROR: $e");

      return ApiResponseModel(
        error: true,
        message: "Terjadi kesalahan sistem.",
      );
    }
  }
}