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
    case 'service':
      return 'Service';
    case 'inUse':
      return 'Digunakan';
    case 'available':
      return 'Tersedia';
    case 'maintenance':
      return 'Diperbaiki';
    case 'damaged':
      return 'Rusak';
    case 'deleted':
      return 'Dihapus';
    default:
      return 'Status tidak dikenal';
  }
  }
}