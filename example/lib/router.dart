import 'package:flutter/material.dart';
import 'package:flutter_canonical_layouts/flutter_canonical_layouts.dart';
import 'package:go_router/go_router.dart';

import 'feed.dart';
import 'home.dart';
import 'list_detail.dart';
import 'main.dart';
import 'supporting_pane.dart';

part 'router.g.dart';

final GoRouter router = GoRouter(
  routes: $appRoutes,
  redirect: (context, state) =>
      state.uri.path == '/' ? const HomeRoute().location : null,
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
        TypedGoRoute<ListDetailInitialRoute>(
          path: '/list-detail',
          routes: [
            TypedGoRoute<ListDetailRoute>(path: ':id'),
          ],
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

class ListDetailInitialRoute extends GoRouteData {
  const ListDetailInitialRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ListDetailLayout(listPane: ListScreen());
  }
}

class ListDetailRoute extends GoRouteData {
  final String id;

  const ListDetailRoute({
    required this.id,
  });

  /// Note: Use [NoTransitionPage] between [ListDetailInitialRoute] and [ListDetailRoute]
  /// when [ListDetailLayout.breakpoint] to remove animations.
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    final child = ListDetailLayout(
      listPane: ListScreen(selectedIndex: int.tryParse(id)),
      detailPane: DetailScreen(id: state.pathParameters['id']!),
    );

    return ListDetailLayout.breakpoint.isActive(context)
        ? NoTransitionPage(child: child)
        : MaterialPage(child: child);
  }
}

class SupportingPaneRoute extends GoRouteData {
  const SupportingPaneRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SupportingPaneScreen();
  }
}
