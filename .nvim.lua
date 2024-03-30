local flutter = require 'flutter-tools'

flutter.setup_project {
    {
        name = "Production",
        target = "lib/main/main.dart",
        device = "chrome",
    },
    {
        name = "Development",
        target = "lib/main/main.dart",
        device = "linux",
    },
}
