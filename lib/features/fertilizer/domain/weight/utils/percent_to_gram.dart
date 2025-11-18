double percentToGram(double percent, double weightInGram){
  double totalGram = percent / weightInGram * 100;

  return double.parse(totalGram.toStringAsFixed(3));
}