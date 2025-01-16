import 'package:flutter/cupertino.dart';
import 'package:rotary_flutter/feature/advertise/advertise_screen.dart';
import 'package:rotary_flutter/feature/etc/allocation_table_screen.dart';
import 'package:rotary_flutter/feature/event/event_screen.dart';
import 'package:rotary_flutter/feature/etc/gallery_screen.dart';
import 'package:rotary_flutter/feature/etc/homepage_screen.dart';
import 'package:rotary_flutter/feature/etc/introduce_foundation_screen.dart';
import 'package:rotary_flutter/feature/etc/k_rotary_screen.dart';
import 'package:rotary_flutter/feature/etc/my_rotary_screen.dart';
import 'package:rotary_flutter/feature/etc/organization_screen.dart';
import 'package:rotary_flutter/feature/etc/policy_screen.dart';
import 'package:rotary_flutter/feature/etc/president_record_screen.dart';
import 'package:rotary_flutter/feature/etc/president_screen.dart';
import 'package:rotary_flutter/feature/etc/rotary_korea_screen.dart';
import 'package:rotary_flutter/feature/montlyletter/monthly_letter_screen.dart';
import 'package:rotary_flutter/feature/userSearch/user_search_screen.dart';
import 'package:rotary_flutter/feature/criterion/criterion_screen.dart';
import 'package:rotary_flutter/feature/etc/programing_table_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../feature/etc/announcement_screen.dart';
import '../../feature/myInfo/modify/my_info_modify_screen.dart';


class MenuItem {
  final String? iconPath;
  final String label;
  final Widget? widget;
  final VoidCallback? onTap;

  MenuItem({this.iconPath, required this.label, this.widget, this.onTap});
}

final List<MenuItem> menuItems = [
  MenuItem(
      iconPath: 'asset/icons/menu/announcement_icon.svg',
      label: '공지사항',
      widget: const AnnouncementScreen()),
  MenuItem(
      iconPath: 'asset/icons/menu/event_icon.svg',
      label: '행사일정',
      widget: const EventScreen()),
  MenuItem(
      iconPath: 'asset/icons/menu/gallery_icon.svg',
      label: '지구갤러리',
      onTap: (){
        launchUrl(Uri.parse('https://band.us/band/50079452/album'));
      }),
  MenuItem(
iconPath: 'asset/icons/menu/my_rotary_icon.svg',
      label: '내 로타리',
      widget: const MyRotaryScreen()),
  MenuItem(
      iconPath: 'asset/icons/menu/homepage_icon.svg',
      label: '지구홈페이지',
      widget: const HomepageScreen()),
  MenuItem(
      iconPath: 'asset/icons/menu/band_icon.svg',
      label: '3700밴드',
      onTap: () {
        launchUrl(Uri.parse('https://band.us/band/50079452'));
      }),
  MenuItem(
      iconPath: 'asset/icons/menu/magazine_icon.svg',
      label: '총재월신',
      widget: const MonthlyLetterScreen()),
  MenuItem(
      iconPath: 'asset/icons/menu/introduce_foundation_icon.svg',
      label: '총재단소개',
      widget: const IntroduceFoundationScreen()),
  MenuItem(
      iconPath: 'asset/icons/menu/organization_icon.svg',
      label: '지구임원',
      widget: const OrganizationScreen()),
  MenuItem(
      iconPath: 'asset/icons/menu/user_search_icon.svg',
      label: '회원검색',
      widget: const UserSearchScreen()),
  MenuItem(
      iconPath: 'asset/icons/menu/advertise_icon.svg',
      label: '광고협찬',
      widget: const AdvertiseScreen()),
  MenuItem(
      iconPath: 'asset/icons/menu/my_info_modify_icon.svg',
      label: '자기정보수정',
      widget: const MyInfoModifyScreen()),
  MenuItem(
      iconPath: 'asset/icons/menu/k_rotary_icon.svg',
      label: 'K-로타리',
      widget: KRotaryKoreaScreen()),
  MenuItem(
      iconPath: 'asset/icons/menu/rotary_korea_icon.svg',
      label: '로타리코리아',
      widget: RotaryKoreaScreen()),
  MenuItem(
      iconPath: 'asset/icons/menu/president_icon.svg',
      label: 'RI 회장',
      widget: const PresidentScreen()),
  MenuItem(
      iconPath: 'asset/icons/menu/policy_icon.svg',
      label: '운영방침',
      widget: const PolicyScreen()),
  MenuItem(
      iconPath: 'asset/icons/menu/allocation_icon.svg',
      label: '배점표',
      widget: const AllocationTableScreen()),
  MenuItem(
      iconPath: 'asset/icons/menu/criterion_icon.svg',
      label: '표장기준',
      widget: const CriterionScreen()),
  MenuItem(
      iconPath: 'asset/icons/menu/programing_table_icon.svg',
      label: '편성표',
      widget: const ProgramingTableScreen()),
  MenuItem(
    iconPath: null,
    label: '',
  ),
];
