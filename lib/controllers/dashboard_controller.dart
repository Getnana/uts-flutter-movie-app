import 'package:flutter/material.dart';
import 'package:flutter_movie_app/apiz/api_service.dart';
import 'package:flutter_movie_app/data/api_response_model.dart';
import 'package:flutter_movie_app/data/movie_db_response_model.dart';
import 'package:flutter_movie_app/utils/k_strings.dart';
import 'package:flutter_movie_app/utils/rest_api.dart';

class DashboardController extends ChangeNotifier {
  int currentPage = 1;
  int totalAvailablePage = 1;

  bool isLoading = true;
  String? errorMessage;

  List<Result> upcomingMovieLists = [];

  Future<void> loadingData({bool isRefresh = false}) async {
    try {
      isLoading = true;
      errorMessage = null;

      if (isRefresh) {
        currentPage = 1;
        upcomingMovieLists.clear();
      }

      notifyListeners();

      ApiResponseModel result = await ApiService.instance.getMovie(
        RestApi.upcomingMovie(currentPage),
        cacheKey: KString.upcomingMovie,
      );

      if (result.error) {
        errorMessage = "Tidak dapat mengambil data. Periksa koneksi internet.";
      } else if (result.message == null) {
        MovieDBResponseModel model = result.list;

        totalAvailablePage = model.totalPages ?? 1;

        if (model.results != null) {
          upcomingMovieLists.addAll(model.results!);
        }
      }
    } catch (e) {
      errorMessage =
          "Terjadi gangguan sistem. Silakan coba beberapa saat lagi.";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
