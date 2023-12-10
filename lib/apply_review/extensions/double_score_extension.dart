extension DoubleScore on double {
  double get asScore => (this * 100).round() / 100;
}
