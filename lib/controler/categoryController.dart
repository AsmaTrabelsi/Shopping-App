
import 'package:shopping/services/databaseHelper.dart';
import 'package:shopping/services/queries/categoryQueries.dart';

class CategoryController{
  var client = DatabaseHelper.client.value;
  final CategoryQueries _categoryQueries = CategoryQueries();

  // methode to generate map convert query of product categories to map
  Future<Map<String,String>> getCategory() async {
    var query = await client.query(_categoryQueries.getCategories());
    print(query);
    var data = query.data!['SP_productCategory'];
    var long = query.data!['SP_productCategory'].length;
    Map<String,String> categories={};
    for (int i = 0; i < long; i++) {
      categories.addAll({data[i]['categoryName'] : data[i]['categoryId']});
    }
    return categories;
  }

}