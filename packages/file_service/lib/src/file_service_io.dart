import 'dart:convert';
import 'dart:io';

import 'package:file_service/file_service.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// {@template file_service_open}
/// An implementation of [FileService] for opening files on desktop and mobile.
/// {@endtemplate}
extension FileServiceOpen on FileService {
  /// Opens a file with the given [path] and [title].
  Future<void> openFile(String path, String title) async {
    // Create a temporary file
    final tempDir = await getTemporaryDirectory();
    final file = File(p.setExtension(p.join(tempDir.path, title), '.pdf'));

    await file.writeAsBytes(base64Decode(path));
    // Open the file
    await OpenFilex.open(file.path);
  }
}
