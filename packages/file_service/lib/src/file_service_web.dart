import 'dart:html' as html;

import 'package:file_service/file_service.dart';

extension FileServiceOpen on FileService {
  Future<void> openFile(String path, String title) async {
    final anchor = html.AnchorElement(
      href: 'data:application/octet-stream;base64,$path',
    )
      ..target = 'blank'
      ..download = title;

    html.document.body?.append(anchor);
    anchor
      ..click()
      ..remove();
  }
}
