import 'package:flutter/cupertino.dart';
import 'package:rotary_flutter/feature/announcement/Announcement_screen.dart';
import 'package:rotary_flutter/feature/home/menu/advertise/advertise_screen.dart';
import 'package:rotary_flutter/feature/home/menu/allocation_table_screen.dart';
import 'package:rotary_flutter/feature/home/menu/event_screen.dart';
import 'package:rotary_flutter/feature/home/menu/gallery_screen.dart';
import 'package:rotary_flutter/feature/home/menu/homepage_screen.dart';
import 'package:rotary_flutter/feature/home/menu/introduce_foundation_screen.dart';
import 'package:rotary_flutter/feature/home/menu/k_rotary_screen.dart';
import 'package:rotary_flutter/feature/home/menu/magazine_screen.dart';
import 'package:rotary_flutter/feature/home/menu/my_rotary_screen.dart';
import 'package:rotary_flutter/feature/home/menu/organization_screen.dart';
import 'package:rotary_flutter/feature/home/menu/policy_screen.dart';
import 'package:rotary_flutter/feature/home/menu/president_record_screen.dart';
import 'package:rotary_flutter/feature/home/menu/president_screen.dart';
import 'package:rotary_flutter/feature/home/menu/rotary_korea_screen.dart';
import 'package:rotary_flutter/feature/myInfo/myInfoModify/my_info_modify_screen.dart';
import 'package:rotary_flutter/feature/userSearch/user_search_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../feature/home/menu/criterion_screen.dart';
import '../../feature/home/menu/programing_table_screen.dart';

class MenuItem {
  final String? iconPath;
  final String label;
  final Widget? widget;
  final VoidCallback? onTap;

  MenuItem({this.iconPath, required this.label, this.widget, this.onTap});
}

final List<MenuItem> menuItems = [
  MenuItem(
      iconPath: 'asset/icons/notice.png',
      label: '공지사항',
      widget: const AnnouncementScreen()),
  MenuItem(
      iconPath: 'asset/icons/calender.png',
      label: '행사일정',
      widget: const EventScreen()),
  MenuItem(
      iconPath: 'asset/icons/gallery.png',
      label: '지구갤러리',
      widget: const GalleryScreen()),
  MenuItem(
      iconPath: 'asset/icons/my_rotary.png',
      label: '내 로타리',
      widget: const MyRotaryScreen()),
  MenuItem(
      iconPath: 'asset/icons/homepage.png',
      label: '지구홈페이지',
      widget: const HomepageScreen()),
  MenuItem(
      iconPath: 'asset/icons/band.png',
      label: '3700밴드',
      onTap: () {
        launchUrl(Uri.parse('https://band.us/band/50079452'));
      }),
  MenuItem(
      iconPath: 'asset/icons/write.png',
      label: '총재월신',
      widget: const MagazineScreen()),
  MenuItem(
      iconPath: 'asset/icons/document.png',
      label: '총재단소개',
      widget: const IntroduceFoundationScreen()),
  MenuItem(
      iconPath: 'asset/icons/member.png',
      label: '지구임원',
      widget: const OrganizationScreen()),
  MenuItem(
      iconPath: 'asset/icons/search.png',
      label: '회원검색',
      widget: const UserSearchScreen()),
  MenuItem(
      iconPath: 'asset/icons/ads.png',
      label: '광고협찬',
      widget: const AdvertiseScreen()),
  MenuItem(
      iconPath: 'asset/icons/myInfo.png',
      label: '자기정보수정',
      widget: const MyInfoModifyScreen()),
  MenuItem(
      iconPath: 'asset/icons/k_rotary.png',
      label: 'K-로타리',
      widget: KRotaryKoreaScreen()),
  MenuItem(
      iconPath: 'asset/icons/rotary_kor.png',
      label: '로타리코리아',
      widget: RotaryKoreaScreen()),
  MenuItem(
      iconPath: 'asset/icons/president.png',
      label: 'RI 회장',
      widget: const PresidentScreen()),
  MenuItem(
      iconPath: 'asset/icons/oper.png',
      label: '운영방침',
      widget: const PolicyScreen()),
  MenuItem(
      iconPath: 'asset/icons/history.png',
      label: '총재약력',
      widget: const PresidentRecordScreen()),
  MenuItem(
      iconPath: 'asset/icons/scoring.png',
      label: '배점표',
      widget: const AllocationTableScreen()),
  MenuItem(
      iconPath: 'asset/icons/average.png',
      label: '표장기준',
      widget: const CriterionScreen()),
  MenuItem(
      iconPath: 'asset/icons/form.png',
      label: '편성표',
      widget: const ProgramingTableScreen()),
  MenuItem(
    iconPath: null,
    label: '',
  ),
];
