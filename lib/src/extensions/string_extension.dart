extension StringExtension on String? {
  bool get isNullOrEmpty => this == null || this?.isEmpty == true;

  bool get isNotNullOrEmpty => !isNullOrEmpty;

  bool get isNullOrWhiteSpace => this == null || this?.trim().isEmpty == true;

  bool get isNotNullOrWhiteSpace => !isNullOrWhiteSpace;

  String get unSign {
    var result = this ?? '';
    // ignore: unnecessary_type_check
    if (result is String) {
      for (var i = 0; i < _vietnamese.length; i++) {
        result = result.replaceAll(_vietnameseRegex[i], _vietnamese[i]);
      }
    }
    return result;
  }

  String get unSignLower => unSign.toLowerCase();
}

const String _vietnamese = 'aAeEoOuUiIdDyY';
final List<RegExp> _vietnameseRegex = <RegExp>[
  RegExp(r'à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ'),
  RegExp(r'À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ'),
  RegExp(r'è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ'),
  RegExp(r'È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ'),
  RegExp(r'ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ'),
  RegExp(r'Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ'),
  RegExp(r'ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ'),
  RegExp(r'Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ'),
  RegExp(r'ì|í|ị|ỉ|ĩ'),
  RegExp(r'Ì|Í|Ị|Ỉ|Ĩ'),
  RegExp(r'đ'),
  RegExp(r'Đ'),
  RegExp(r'ỳ|ý|ỵ|ỷ|ỹ'),
  RegExp(r'Ỳ|Ý|Ỵ|Ỷ|Ỹ')
];
