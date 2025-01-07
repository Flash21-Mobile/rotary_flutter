enum CardinalRC {
  rc(name: "RC"),
  chungDo(name: "대구청도 RC",),
  yungNam(name: "대구영남 RC", ),
  chungUn(name: "대구청운 RC", ),
  taeYang(name: "대구태양 RC", ),
  wanHwa(name: "청도원화 RC", ),
  useong(name: "대구유성 RC", ),
  daesung(name: "대구대성 RC", ),
  songWon(name: "대구송원 RC", );


  const CardinalRC({required this.name});

  final String name;

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