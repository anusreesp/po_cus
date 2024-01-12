class DemoDrinksModel {
  final int id;
  final String drinkName;
  DemoDrinksModel({required this.id, required this.drinkName});
}

final sampleDrinksType = [
  DemoDrinksModel(id: 1, drinkName: "Brandy"),
  DemoDrinksModel(id: 2, drinkName: "Whiskey"),
  DemoDrinksModel(id: 3, drinkName: "Vodka"),
  DemoDrinksModel(id: 4, drinkName: "Cognac"),
];


class DemoDrinksBrandModel {
  final int id;
  final String drinkBrand;
  DemoDrinksBrandModel({required this.id, required this.drinkBrand});
}

final sampleDrinksBrand = [
  DemoDrinksModel(id: 1, drinkName: "Royal Stag"),
  DemoDrinksModel(id: 2, drinkName: "Redbreast"),
  DemoDrinksModel(id: 3, drinkName: "Officer's Choice"),
  DemoDrinksModel(id: 4, drinkName: "Imperial Blue"),
];

final sampleSmokeType = [
  DemoDrinksModel(id: 1, drinkName: "Cigars"),
  DemoDrinksModel(id: 2, drinkName: "Sheesha"),
  DemoDrinksModel(id: 3, drinkName: "Cigerattes"),
  DemoDrinksModel(id: 4, drinkName: "Vape"),
];

final sampleSmokeFlavour = [
  DemoDrinksModel(id: 1, drinkName: "Strawberry"),
  DemoDrinksModel(id: 2, drinkName: "Mint"),
  DemoDrinksModel(id: 3, drinkName: "Azure Lemon"),
  DemoDrinksModel(id: 4, drinkName: "Chocolate Strawberry"),
];
