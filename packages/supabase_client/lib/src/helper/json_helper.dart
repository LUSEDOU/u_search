/// {@template json_helper}
/// A helper class to format json models.
/// {@endtemplate}
class JsonHelper {
  /// Formats a json model to be sent to the API.
  static Map<String, dynamic> format(Map<String, dynamic> json) {
    final formattedJson = <String, dynamic>{};

    json.forEach((key, value) {
      if (value is! Map<String, dynamic>) {
        formattedJson[key] = value;
        return;
      }

      if (value.containsKey('id')) {
        formattedJson['${key}_id'] = value['id'];
        return;
      }
    });
    return formattedJson;
  }
}
