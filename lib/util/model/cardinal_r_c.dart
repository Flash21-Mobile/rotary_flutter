enum CardinalRC {
  rc(name: "RC", id: null),
  chungDo(name: "청도", id: 9),
  yungNam(name: "대구 영남", id: 10),
  chungUn(name: "대구 청운", id: 11),
  taeYang(name: "대구 태양", id: 12),
  wanHwa(name: "청도원화 RC", id: 13),
  useong(name: "대구유성 RC", id: 14),
  daesung(name: "대구대성 RC", id: 15),
  songWon(name: "대구송원 RC", id: 16);


  const CardinalRC({required this.name, required this.id});

  final String name;
  final int? id;

  static List<CardinalRC> all =[
    CardinalRC.rc,
    CardinalRC.chungDo,
    CardinalRC.yungNam,
    CardinalRC.chungUn,
    CardinalRC.taeYang,
    CardinalRC.wanHwa,
    CardinalRC.useong,
    CardinalRC.daesung,
    CardinalRC.songWon
  ];

  static CardinalRC getByIndex(int index){
    return all[index];
  }
}