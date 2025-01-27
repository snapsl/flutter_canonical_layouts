import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

import 'widgets/edit_button.dart';
import 'widgets/item_card.dart';
import 'widgets/searchbar.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final constrainedNotifier = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SearchBarApp(),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: null,
                  child: ValueListenableBuilder(
                    valueListenable: constrainedNotifier,
                    builder: (context, value, child) => SwitchListTile(
                      title: const Text('Use constrained box'),
                      value: value,
                      onChanged: (_) => constrainedNotifier.value = !value,
                    ),
                  ),
                ),
              ];
            },
            icon: const CircleAvatar(child: Text('C')),
          ),
        ],
        centerTitle: true,
        forceMaterialTransparency: true,
      ),
      body: Center(
        child: Breakpoints.small.isActive(context)
            ? ListView.builder(
                itemBuilder: (context, index) => AspectRatio(
                  aspectRatio: 2,
                  child: ItemCard(
                    color: ItemCard.colorFromIndex(index),
                    title: 'Item $index',
                    subtitle: 'Additional information',
                  ),
                ),
              )
            : ValueListenableBuilder(
                valueListenable: constrainedNotifier,
                builder: (context, value, child) => ConstrainedBox(
                  key: ValueKey(value),
                  constraints: value
                      ? const BoxConstraints(maxWidth: 840)
                      : const BoxConstraints(),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 250),
                    itemBuilder: (context, index) => AspectRatio(
                      aspectRatio: 1,
                      child: ItemCard(
                        color: ItemCard.colorFromIndex(index),
                        title: 'Item $index',
                        subtitle: 'Additional information',
                      ),
                    ),
                  ),
                ),
              ),
      ),
      // Note: show FAB on small screens.
      floatingActionButton:
          Breakpoints.small.isActive(context) ? const EditButton() : null,
    );
  }
}
