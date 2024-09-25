import 'package:file_service/file_service.dart';

/// A file service that is not supported on the current platform.
extension FileServiceOpen on FileService {
  /// Opens a file with the given [path] and [title].
  Future<void> openFile(String path, String title) async {
    throw UnsupportedError('openFile is not supported on this platform');
  }
}
