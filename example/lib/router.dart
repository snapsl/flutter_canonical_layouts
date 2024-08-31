import 'package:example/supporting_pane.dart';
import 'package:flutter/material.dart';
import 'package:flutter_canonical_layouts/flutter_canonical_layouts.dart';
import 'package:go_router/go_router.dart';

import 'detail.dart';
import 'feed.dart';
import 'home.dart';
import 'main.dart';

part 'router.g.dart';

final GoRouter router = GoRouter(
  routes: $appRoutes,
  redirect: (context, state) => (state.uri == Uri.parse('/')) ? '/home' : null,
);

@TypedStatefulShellRoute<AppShellRouteData>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<BranchHomeData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<HomeRoute>(path: '/home'),
      ],
    ),

    // TODO: how to remove page transition between subroutes?
    TypedStatefulShellBranch<BranchListDetailData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<ListDetailInitRoute>(
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

class ListDetailInitRoute extends GoRouteData {
  const ListDetailInitRoute();

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

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ListDetailLayout(
      listPane: ListScreen(selectedIndex: int.tryParse(id)),
      detailPane: DetailScreen(id: state.pathParameters['id']!),
    );
  }
}

class SupportingPaneRoute extends GoRouteData {
  const SupportingPaneRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SupportingPaneScreen();
  }
}
