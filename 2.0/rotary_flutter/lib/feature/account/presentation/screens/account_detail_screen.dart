import 'package:design_system/animate/ink_well.dart';
import 'package:design_system/appbar/app_bar.dart';
import 'package:design_system/appbar/app_bar_bottom.dart';
import 'package:design_system/listview/list_view.dart';
import 'package:design_system/scaffold/scaffold.dart';
import 'package:design_system/state_builder/state_builder.dart';
import 'package:design_system/text/text_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rotary_flutter/feature/account/presentation/providers/account_list/account_list_provider.dart';
import 'package:rotary_flutter/feature/account/presentation/widgets/account_detail_my_section.dart';
import 'package:rotary_flutter/feature/account/presentation/widgets/account_detail_work_section.dart';

import '../providers/account_detail/account_detail_provider.dart';

class AccountDetailScreen extends HookConsumerWidget {
  final int id;

  const AccountDetailScreen(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(accountDetailProvider(id));

    final tabs = [Tab(text: '개인정보'), Tab(text: '회사정보')];
    final tabController = useTabController(initialLength: tabs.length);

    final isFavorite = useState<bool?>(null);

    useEffect(() {
      if (!state.isLoading && state.data != null) {
        isFavorite.value = state.data!.isFavorite;
      }
      return null;
    }, [state]);

    return MMateScaffold(
      context,
      appBar: BlurAppBar(
        context,
        bottom: AppBarBottom(
          context,
          height: kToolbarHeight,
          child: TabBar(
            tabs: tabs,
            controller: tabController,
            dividerColor: Theme.of(context).dividerColor,
            indicatorSize: TabBarIndicatorSize.tab,
            splashFactory: NoSplash.splashFactory,

            overlayColor: WidgetStatePropertyAll(Colors.transparent),
          ),
        ),
        child: IndexTextMax('회원정보', fontWeight: FontWeight.w500),
      ),
      body: StateBuilder(
        isLoading: state.isLoading,
        error: state.error,
        data: state.data,
        builder: (_, data) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [],
            body: TabBarView(
              controller: tabController,
              children: [
                AccountDetailMySection(data),
                AccountDetailWorkSection(data),
              ],
            ),
          );
        },
      ),
      floatingActionButton:
          isFavorite.value != null
              ? MMateInkWell(
                onTap: () {
                  isFavorite.value = !(isFavorite.value ?? false);
                  ref.read(switchFavoriteAccountProvider(id));
                },
                child: IgnorePointer(
                  child: FloatingActionButton(
                    onPressed: () {},
                    shape: CircleBorder(),
                    backgroundColor:
                        (isFavorite.value ?? false)
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.tertiary,
                    child: Icon(
                      Icons.star_rounded,
                      color: Theme.of(context).colorScheme.primaryContainer,
                      size: 48,
                    ),
                  ),
                ),
              )
              : null,
    );
  }
}
