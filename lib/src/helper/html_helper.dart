import 'package:html/parser.dart';

class HTMLHelper {
  static String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body?.text).documentElement?.text ?? '';
    return parsedString;
  }

  static String parseEmailFromHTML(String htmlString) {
    const mailPattern = r"\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b";
    final regEx = RegExp(mailPattern, multiLine: true);
    final obtainedMail = regEx
        .allMatches(htmlString.toString())
        .map((m) => m.group(0))
        .join(' ');
    return obtainedMail.split('nz').toList()[0] + 'nz';
  }

  static String parsePhoneFromHTML(String htmlString) {
    String result = '';
    final document = parse(htmlString);

    final String parsedString =
        parse(document.body?.text).documentElement?.text ?? '';
    if (parsedString.contains('Mobile:')) {
      result = parsedString.split('Mobile:').toList()[1];
    } else if (parsedString.contains('Mobile')) {
      result = parsedString.split('Mobile').toList()[1];
    } else if (parsedString.contains('Mob')) {
      result = parsedString.split('Mob').toList()[1];
    } else if (parsedString.contains('Mob:')) {
      result = parsedString.split('Mob:').toList()[1];
    }
    if (result.contains('Freephone')) {
      result = result.split('Freephone').toList()[0].trim();
    }
    if (result.contains('Phone:')) {
      result = result.split('Phone:').toList()[0].trim();
    }
    return result.replaceAll(':', '').trim();
  }
}
