enum UserLevel {
  worst('Pemula (Beginner)'),
  bad('Menengah Bawah (Lower Intermediate)'),
  ok('Menengah (Intermediate)'),
  good('Menengah Atas (Upper Intermediate)'),
  excellent('Mahir (Advanced)');

  final String label;

  const UserLevel(this.label);
  String get value => name.toUpperCase();
}
