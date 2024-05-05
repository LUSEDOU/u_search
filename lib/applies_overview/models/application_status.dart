import 'package:u_search_api/api.dart';

enum ApplicationStatus {
  applied._('Pendiente'),
  assigned._('Evaluando'),
  reviewed._('Revisado');

  const ApplicationStatus._(this.label);
  final String label;
}

extension ApplicationStatusX on Apply {
  ApplicationStatus get status {
    if (isEmpty) {
      return ApplicationStatus.applied;
    }
    if (review != null && review!.isCreated) {
      return ApplicationStatus.reviewed;
    } else if (reviewer != null && !reviewer!.isAnonymous) {
      return ApplicationStatus.assigned;
    }

    return ApplicationStatus.applied;
  }
}
