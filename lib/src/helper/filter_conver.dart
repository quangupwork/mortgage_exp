import 'package:mortgage_exp/src/constants.dart';

import '../../static_variable.dart';

class FilterConverter {
  static String filterConvert(int id) {
    final getFilter = StaticVariable.listTopic ?? [];
    final index = Constants.categoryIDS.indexOf(id);
    if (index != -1) {
      return getFilter[index];
    }
    return '';
  }

  static String filterDocument(String title) {
    final document = StaticVariable.listDocument ?? [];
    final index = document.indexWhere((element) => element.title == title);
    if (index != -1) {
      return document[index].link ?? '';
    }
    return '';
  }
}
