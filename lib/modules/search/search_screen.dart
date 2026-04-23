import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_movie_app/controllers/search_controller.dart'
    as SearchControllerProvider;
import 'package:flutter_movie_app/data/movie_db_response_model.dart';
import 'package:flutter_movie_app/modules/search/components/search_item_view.dart';
import 'package:flutter_movie_app/router_name.dart';
import 'package:flutter_movie_app/utils/k_colors.dart';
import 'package:flutter_movie_app/utils/rest_api.dart';
import 'package:flutter_movie_app/widgets/custom_search_field.dart';
import 'package:flutter_movie_app/widgets/error_view.dart';
import 'package:flutter_movie_app/widgets/loading.dart';
import 'package:flutter_movie_app/widgets/shimmer_dashboard_loading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchEditController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  late SearchControllerProvider.SearchController _controller;

  Timer? _debouncer;

  void search({bool isNewSearch = true}) {
    final query = searchEditController.text.trim();

    if (query.isEmpty) return;

    _controller.searchingData(
      query,
      isNewSearch: isNewSearch,
    );
  }

  @override
  void initState() {
    super.initState();

    _controller = Provider.of<SearchControllerProvider.SearchController>(
      context,
      listen: false,
    );

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (searchEditController.text.trim().isEmpty) return;

        if (!_controller.isLoading &&
            _controller.currentPage < _controller.totalAvailablePage) {
          _controller.currentPage += 1;

          search(isNewSearch: false);
        }
      }
    });
  }

  @override
  void dispose() {
    _debouncer?.cancel();
    searchEditController.dispose();
    scrollController.dispose();
    _controller.clearSearch();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchControllerProvider.SearchController>(
      builder: (context, data, child) {
        return Scaffold(
          appBar: _appBar(),
          body: _body(data),
        );
      },
    );
  }

  AppBar _appBar() {
    return AppBar(
      leadingWidth: 0,
      toolbarHeight: kToolbarHeight + 20,
      title: CustomSearchField(
        controller: searchEditController,
        onFieldSubmitted: (value) {
          _controller.clearSearch();

          Navigator.pushNamed(
            context,
            Routes.searchResult,
            arguments: {
              'query': value,
            },
          );
        },
        onChanged: (String value) {
          _debouncer?.cancel();

          _debouncer = Timer(
            const Duration(milliseconds: 700),
            () {
              _controller.clearSearch();
              search();
            },
          );
        },
        onCloseTap: () {
          _debouncer?.cancel();
          searchEditController.clear();
          _controller.clearSearch();
        },
      ),
    );
  }

  Padding _body(data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Text(
            'Top Results',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          const SizedBox(height: 10),
          const Divider(
            thickness: 1,
            color: Colors.black12,
          ),
          const SizedBox(height: 20),

          /// Loading pertama kali
          if (data.isLoading && data.searchMovieLists.isEmpty)
            const Expanded(
              child: ShimmerDashboardLoading(
                width: double.infinity,
                height: 180,
              ),
            )

          /// Error
          else if (data.errorMessage != null)
            Expanded(
              child: ErrorView(
                message: data.errorMessage!,
                onPressed: () => search(),
              ),
            )

          /// Kosong
          else if (data.searchMovieLists.isEmpty)
            const Expanded(
              child: Center(
                child: Text("Cari film favoritmu..."),
              ),
            )

          /// Data
          else
            _view(data),
        ],
      ),
    );
  }

  Expanded _view(data) {
    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        itemCount: data.searchMovieLists.length +
            (data.isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == data.searchMovieLists.length) {
            return const Loading();
          }

          Result result = data.searchMovieLists[index];

          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.watchDetails,
                arguments: {
                  'id': result.id,
                  'data': result.toJson(),
                },
              );
            },
            child: SearchItemView(
              image: RestApi.getImage(result.posterPath ?? ''),
              title: result.title ?? '-',
              caption: result.releaseDate,
            ),
          );
        },
      ),
    );
  }
}