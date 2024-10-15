local flutter = require 'flutter-tools'

flutter.setup_project {
    {
        name = "Production",
        target = "lib/main/main_development.dart ",
        device = "macos",
    },
    {
        name = "Development",
        target = "./lib/main/main_development.dart ",
        device = "macos",
    },
}
