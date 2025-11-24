class Category{
  final String id;
  final String name;
  final String thumbnail;
  final String description;

  Category({required this.id,required this.name, required this.thumbnail,required this.description});

  Category.fromJson(Map<String,dynamic> json):

      id= json['idCategory'],
      name=json['strCategory'],
      thumbnail=json['strCategoryThumb'],
  description=json['strCategoryDescription'];



}