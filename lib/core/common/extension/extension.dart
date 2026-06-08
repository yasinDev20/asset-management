extension ServiceTypeLanguageX on String {
  String serviceTypeToBahasa() {
    switch (this) {
      case 'yearly':
        return 'Tahunan';
      case 'monthly':
        return 'Bulanan';
      default:
        return 'Tipe tidak dikenal';
    }
  }
}

extension StatusLanguageX on String {
  String statusTypeToBahasa() {
    switch (this) {
      case 'Service':
        return 'Service';
      case 'In Use':
        return 'Digunakan';
      case 'Available':
        return 'Tersedia';
      case 'Maintenance':
        return 'Diperbaiki';
      case 'Damaged':
        return 'Rusak';
      case 'Deleted':
        return 'Dihapus';
      default:
        return 'Status tidak dikenal';
    }
  }
}

extension BrandLanguageX on String {
  String brandToBahasa() {
    switch (this) {
      case 'No Brand':
        return 'Tidak ada merek';

      default:
        return this;
    }
  }
}

extension ToLikePatternList on List<String> {
  List<String> get toLikePatterns => map((v) => '%$v%').toList();
}

extension ToLikePatternString on String {
  String get toLikePatterns => '%$this%';
}
