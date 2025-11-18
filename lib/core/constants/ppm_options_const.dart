class PpmOptionsConst {
  static List<PpmType> ppmOptions = [
    PpmType(itemId: 1, itemName: 'PPM'),
    PpmType(itemId: 2, itemName: 'Massa Zat Terlarut'),
    PpmType(itemId: 3, itemName: 'Volume Larutan'),
  ];
}

class PpmType {
  final int itemId;
  final String itemName;

  PpmType({required this.itemId, required this.itemName});
}
