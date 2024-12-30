enum CardinalLocation {
  global(name: "전체", id: null),
  first(name: "1지역", id: 390),
  second(name: "2지역", id: 391),
  third(name: "3지역", id: 392),
  forth(name: "4지역", id: 393),
  fifth(name: "5지역", id: 394),
  sixth(name: "6지역", id: 395),
  seventh(name: "7지역", id: 396),
  eighth(name: "8지역", id: 397),
  ninth(name: "9지역", id: 398),
  tenth(name: "10지역", id: 399),
  eleventh(name: "11지역", id: 400),
  twelfth(name: "12지역", id: 401),
  head(name: "지구지도부", id: 402);

  const CardinalLocation({required this.name, required this.id});

  final String name;
  final int? id;

  static List<CardinalLocation> all =[
    CardinalLocation.global,
      CardinalLocation.head,
      CardinalLocation.first,
      CardinalLocation.second,
      CardinalLocation.third,
      CardinalLocation.forth,
      CardinalLocation.fifth,
      CardinalLocation.sixth,
      CardinalLocation.seventh,
      CardinalLocation.eighth,
      CardinalLocation.ninth,
      CardinalLocation.tenth,
      CardinalLocation.eleventh,
      CardinalLocation.twelfth,
    ];

  static CardinalLocation getByIndex(int index){
    return all[index];
  }
}
