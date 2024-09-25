/// A Very Good Project created by Very Good CLI.
library;

export 'src/file_service.dart';
export 'src/file_service_unsupported.dart'
    if (dart.library.html) 'src/file_service_web.dart'
    if (dart.library.io) 'src/file_service_io.dart';
