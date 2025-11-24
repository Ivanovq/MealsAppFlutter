import 'package:flutter/cupertino.dart';
import 'package:lab2/models/category_model.dart';
import 'package:lab2/widgets/category_card.dart';

class CategoryGrid extends StatefulWidget {
  final List<Category> category;

  const CategoryGrid({super.key,required this.category});
  @override
  State<StatefulWidget> createState() => _CategoryGridState();

}

class _CategoryGridState extends State<CategoryGrid> {


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4
        ),
        itemBuilder: (context, index) {return CategoryCard(category:widget.category[index]);},
        itemCount: widget.category.length,
    );
  }

}