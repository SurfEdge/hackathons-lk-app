import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackathons_lk_app/services/api_data.dart';
import 'package:http/http.dart' as http;

ValueNotifier<bool> isLoaded = ValueNotifier<bool>(false);

class PostsController extends GetxController {
  var isLoading = true.obs;
  var eventsList = <Data>[].obs;
  var totalRecords = 10.obs;
  var totalPages = 1.obs;

  Future<List<Data>> fetchData(int pageNumber) async {
    final response = await http.get(Uri.parse(
        'https://hackathons.lk/wp-json/wp/v2/event?_embed&page=$pageNumber&per_page=5'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      totalRecords(int.parse(response.headers['x-wp-total']));
      totalPages(int.parse(response.headers['x-wp-totalpages']));
      return jsonResponse.map((data) => new Data.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  fetchPosts({int pageNumber = 0}) async {
    try {
      isLoaded.value = false;
      if (eventsList.length == 0 || pageNumber == 0) {
        isLoading(true);
        eventsList.clear();
      }
      if (eventsList.length < totalRecords.value) {
        var posts = await fetchData(pageNumber);

        if (posts != null) {
          eventsList.addAll(posts);
        }
      }
    } finally {
      isLoading(false);
      isLoaded.value = true;
    }
  }
}
