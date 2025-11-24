import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lab2/models/category_model.dart';

class CategoryApiService {
  Future<List<Category>> fetchCategories() async {
    final res = await http.get(
      Uri.parse("https://www.themealdb.com/api/json/v1/1/categories.php"),
    );

    if (res.statusCode == 200) {
      final data = json.decode(res.body) as Map<String, dynamic>;
      final list = data['categories'] as List<dynamic>;
      return list.map((e) => Category.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
  
  Future<Category?> searchByCategoryName(String name) async{
    try{
      final response = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/search.php?s=${name.toLowerCase()}"),);
      if(response.statusCode==200)
        {
          final data = json.decode(response.body);
          return Category.fromJson(data);
        }
      return null;
    }
    catch(e){
      return null;
    }
  } 
}
