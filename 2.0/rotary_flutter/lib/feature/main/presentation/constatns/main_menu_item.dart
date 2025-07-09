import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:function_system/utilities/navigation/navigation.dart';
import 'package:rotary_flutter/feature/announcement/announcement_screen.dart';
import 'package:rotary_flutter/feature/monthly_letter/presentation/screens/monthly_letter_screen.dart';
import 'package:rotary_flutter/feature/you/presentation/you_screen.dart';

enum MainMenuItem {
  myInfo('내 정보', 'assets/core/user_search_icon.svg'),
  myInfoModify('내 정보 수정', 'assets/core/my_info_modify_icon.svg'),
  announcement('공지사항', 'assets/core/announcement_icon.svg'),
  event('행사일정', 'assets/core/event_icon.svg'),
  gallery('지구갤러리', 'assets/core/gallery_icon.svg'),
  monthlyLetter('총재월신', 'assets/core/magazine_icon.svg'),
  introduceFoundation('총재단소개', 'assets/core/introduce_foundation_icon.svg'),
  organization('지구임원', 'assets/core/organization_icon.svg'),
  advertise('광고협찬', 'assets/core/advertise_icon.svg'),
  myRotary('내 로타리', 'assets/core/my_rotary_icon.svg'),
  homepage('지구홈페이지', 'assets/core/homepage_icon.svg'),
  band3700('3700밴드', 'assets/core/band_icon.svg'),
  kRotary('K-로타리', 'assets/core/k_rotary_icon.svg'),
  rotaryKorea('로타리코리아', 'assets/core/rotary_korea_icon.svg'),
  president('RI 회장', 'assets/core/president_icon.svg'),
  policy('운영방침', 'assets/core/policy_icon.svg'),
  allocation('배점표', 'assets/core/allocation_icon.svg'),
  criterion('표창기준', 'assets/core/criterion_icon.svg'),
  programmingTable('편성표', 'assets/core/programing_table_icon.svg');

  final String label;
  final String image;

  Future onTap(BuildContext context) async {
    return switch (this) {
      monthlyLetter => context.push(MonthlyLetterScreen()),
      myInfo => context.push(YouScreen()),
      announcement => context.push(AnnouncementScreen()),

    _ => null,
    };
  }

  const MainMenuItem(this.label, this.image);

  static List<MainMenuItem?> get origin {
    final padding = (3 - values.length % 3) % 3;
    return [
      ...values,
      ...List.filled(padding, null),
    ];
  }

  static List<MainMenuItem> get my =>
      [
        MainMenuItem.myInfo,
        MainMenuItem.myInfoModify,
      ];

  static List<MainMenuItem> get monthly =>
      [
        MainMenuItem.announcement,
        MainMenuItem.event,
        MainMenuItem.gallery,
      ];

  static MainMenuItem get monthlyHighlight => MainMenuItem.monthlyLetter;

  static List<MainMenuItem> get account =>
      [
        MainMenuItem.introduceFoundation,
        MainMenuItem.organization,
        MainMenuItem.advertise,
      ];

  static List<MainMenuItem> get etc =>
      [
        MainMenuItem.myRotary,
        MainMenuItem.homepage,
        MainMenuItem.band3700,
        MainMenuItem.kRotary,
        MainMenuItem.rotaryKorea,
        MainMenuItem.president,
        MainMenuItem.policy,
        MainMenuItem.allocation,
        MainMenuItem.criterion,
        MainMenuItem.programmingTable,
      ];
}
