import 'package:flutter/material.dart';
import 'package:flutter_canonical_layouts/flutter_canonical_layouts.dart';
import 'package:go_router/go_router.dart';

import 'feed.dart';
import 'home.dart';
import 'list_detail.dart';
import 'main.dart';
import 'supporting_pane.dart';

part 'router.g.dart';

// Note: It's recommended to use a service locator
final GoRouter router = GoRouter(
  routes: $appRoutes,
  initialLocation: HomeRoute().location,
);

@TypedStatefulShellRoute<AppShellRouteData>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<BranchHomeData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<HomeRoute>(path: '/home'),
      ],
    ),
    TypedStatefulShellBranch<BranchListDetailData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<ListDetailRoute>(
          path: '/list-detail',
        ),
      ],
    ),
    TypedStatefulShellBranch<BranchSupportingPaneData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<SupportingPaneRoute>(path: '/supporting-pane'),
      ],
    ),
    TypedStatefulShellBranch<BranchFeedData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<FeedRoute>(path: '/feed'),
      ],
    ),
  ],
)
class AppShellRouteData extends StatefulShellRouteData {
  const AppShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return ScaffoldShell(
      navigationShell: navigationShell,
    );
  }
}

class BranchFeedData extends StatefulShellBranchData {
  const BranchFeedData();
}

class BranchHomeData extends StatefulShellBranchData {
  const BranchHomeData();
}

class BranchListDetailData extends StatefulShellBranchData {
  const BranchListDetailData();
}

class BranchSupportingPaneData extends StatefulShellBranchData {
  const BranchSupportingPaneData();
}

class FeedRoute extends GoRouteData {
  const FeedRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FeedScreen();
  }
}

class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

class ListDetailRoute extends GoRouteData {
  final String? id;

  const ListDetailRoute({
    this.id,
  });

  /// Note: Use [NoTransitionPage] between [ListDetailInitialRoute] and [ListDetailRoute]
  /// when [ListDetailLayout.breakpoint] to remove animations.
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    final index = int.tryParse(id.toString());

    final child = ListDetailLayout(
      listPane: ListScreen(selectedIndex: index),
      detailPane: index != null ? DetailScreen(id: id.toString()) : null,
    );

    return ListDetailLayout.breakpoint.isActive(context)
        ? NoTransitionPage(key: state.pageKey, child: child)
        : MaterialPage(key: state.pageKey, child: child);
  }
}

class SupportingPaneRoute extends GoRouteData {
  const SupportingPaneRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SupportingPaneScreen();
  }
}
