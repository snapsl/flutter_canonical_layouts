import 'package:example/widgets/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

import 'router.dart';
import 'widgets/edit_button.dart';
import 'widgets/item_card.dart';

class DetailScreen extends StatelessWidget {
  final String id;

  const DetailScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // hides the backbutton if the DetailsScreen are secondBody
        automaticallyImplyLeading:
            !Breakpoints.mediumLargeAndUp.isActive(context),
      ),
      body: ItemCard(
        color: colorFromIndex(int.tryParse(id) ?? 0),
        title: 'Title for $id',
        subtitle: 'subtitle',
      ),
    );
  }
}

class ListScreen extends StatelessWidget {
  final int? selectedIndex;

  const ListScreen({
    super.key,
    this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: SearchBarApp()),
        primary: false,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final selected = selectedIndex == index;

          return Card.filled(
            clipBehavior: Clip.hardEdge,
            color: selected
                ? Theme.of(context).colorScheme.secondaryContainer
                : null,
            child: ListTile(
              selected: selected,
              title: Text(index.toString()),
              subtitle: const Text('Some Text'),
              onTap: () => ListDetailRoute(id: index.toString()).go(context),
            ),
          );
        },
      ),
      floatingActionButton:
          Breakpoints.small.isActive(context) ? const EditButton() : null,
    );
  }
}
