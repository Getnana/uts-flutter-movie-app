import 'package:flutter/material.dart';
import 'package:flutter_movie_app/apiz/api_service.dart';
import 'package:flutter_movie_app/data/api_response_model.dart';
import 'package:flutter_movie_app/data/movie_db_response_model.dart';
import 'package:flutter_movie_app/utils/rest_api.dart';

class SearchController extends ChangeNotifier {
  int currentPage = 1;
  int totalAvailablePage = 1;

  bool isLoading = false;
  String? errorMessage;

  List<Result> searchMovieLists = [];

  Future<void> searchingData(
    String query, {
    bool isNewSearch = true,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;

      if (isNewSearch) {
        currentPage = 1;
        searchMovieLists.clear();
      }

      notifyListeners();

      ApiResponseModel result = await ApiService.instance.getMovie(
        RestApi.searchMovie(query, currentPage),
      );

      if (result.error) {
        errorMessage = "Film tidak ditemukan atau koneksi bermasalah.";
      } else if (result.message == null) {
        MovieDBResponseModel model = result.list;

        totalAvailablePage = model.totalPages ?? 1;

        if (model.results != null) {
          searchMovieLists.addAll(model.results!);
        }
      }
    } catch (e) {
      errorMessage = "Terjadi kesalahan saat mencari film.";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    currentPage = 1;
    totalAvailablePage = 1;
    isLoading = false;
    errorMessage = null;
    searchMovieLists.clear();

    notifyListeners();
  }
}