import 'package:go_router/go_router.dart';
import 'package:rotary_flutter/feature/home/menu/allocation_table_screen.dart';
import 'package:rotary_flutter/feature/home/menu/criterion_screen.dart';
import 'package:rotary_flutter/feature/home/menu/my_rotary_screen.dart';
import 'package:rotary_flutter/feature/home/menu/organization_screen.dart';
import 'package:rotary_flutter/feature/home/menu/policy_screen.dart';
import 'package:rotary_flutter/feature/home/menu/president_record_screen.dart';
import 'package:rotary_flutter/feature/home/menu/president_screen.dart';
import 'package:rotary_flutter/feature/home/menu/programing_table_screen.dart';
import 'package:rotary_flutter/feature/home/menu/rotary_korea_screen.dart';
import 'package:rotary_flutter/feature/myInfo/login_screen.dart';
import 'package:rotary_flutter/feature/myInfo/myInfoModify/my_info_modify_screen.dart';
import '../feature/announcement/announcement_screen.dart';
import '../feature/home/menu/advertise/advertise_screen.dart';
import '../feature/home/menu/event_screen.dart';
import '../feature/home/menu/gallery_screen.dart';
import '../feature/home/menu/homepage_screen.dart';
import '../feature/home/menu/index_screen.dart';
import '../feature/home/menu/introduce_foundation_screen.dart';
import '../feature/home/menu/k_rotary_screen.dart';
import '../feature/home/menu/magazine_screen.dart';
import '../feature/home/menu/president_birth_screen.dart';
import '../feature/home_screen.dart';
import '../feature/userSearch/userInfo/user_info_screen.dart';
import '../feature/userSearch/user_search_screen.dart';

final List<GoRoute> mainRouter = [
  GoRoute(
      path: '/',
      builder: (context, state) {
        return HomeScreen();
      },
      routes: [
        GoRoute(path: 'menu', builder: (_, $) => HomeScreen(), routes: [
          GoRoute(path: 'president', builder: (_, $) => PresidentScreen()),
          GoRoute(path: 'policy', builder: (_, $) => PolicyScreen()),
          GoRoute(path: 'record', builder: (_, $) => PresidentRecordScreen()),
          GoRoute(path: 'organization', builder: (_, $) => OrganizationScreen()),
          GoRoute(path: 'allocation', builder: (_, $) => AllocationTableScreen()),
          GoRoute(path: 'programing', builder: (_, $) => ProgramingTableScreen()),
          GoRoute(path: 'criterion', builder: (_, $) => CriterionScreen()),
          GoRoute(path: 'rotaryKorea', builder: (_, $) => RotaryKoreaScreen()),
          GoRoute(path: 'kRotaryKorea', builder: (_, $) => KRotaryKoreaScreen()),
          GoRoute(path: 'announcement', builder: (_, $) => AnnouncementScreen()),
          GoRoute(path: 'presidentBirth', builder: (_, $) => PresidentBirthScreen()),
          GoRoute(path: 'advertise', builder: (_, $) => AdvertiseScreen()),
          GoRoute(path: 'event', builder: (_, $) => EventScreen()),
          GoRoute(
              path: 'userInfo/:id',
              builder: (_, state) {
                final int id = int.parse(state.pathParameters['id'] ?? '0');
                return UserInfoScreen(id: id);
              }),
          GoRoute(path: 'userSearch', builder: (_, $) => UserSearchScreen()),
          GoRoute(
              path: 'index',
              builder: (context, state) {
                return IndexScreen();
              }),
          GoRoute(path: 'introduce_foundation', builder: (_, $) => IntroduceFoundationScreen()),
          GoRoute(path: 'gallery', builder: (_, $) => GalleryScreen()),
          GoRoute(path: 'magazine', builder: (_, $) => MagazineScreen()),
          GoRoute(path: 'homePage', builder: (_, $) => HomepageScreen()),
          GoRoute(path: 'myInfoModify', builder: (_, $) => MyInfoModifyScreen()),
          GoRoute(path: 'myRotary', builder: (_, $) => MyRotaryScreen())
        ],
        ),
        GoRoute(path: 'login',builder: (_,$)=>const LoginScreen())
      ])
];
