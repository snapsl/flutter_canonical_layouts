import 'dart:ui';

import 'package:example/widgets/edit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_canonical_layouts/flutter_canonical_layouts.dart';

import 'widgets/item_card.dart';
import 'widgets/searchbar.dart';

class SupportingPaneScreen extends StatefulWidget {
  const SupportingPaneScreen({super.key});

  @override
  State<SupportingPaneScreen> createState() => _SupportingPaneScreenState();
}

class _SupportingPaneScreenState extends State<SupportingPaneScreen> {
  late final DraggableScrollableController controller;

  @override
  Widget build(BuildContext context) {
    final bottomSheetSupportingPane = DraggableScrollableSheet(
      controller: controller,
      snap: true,
      minChildSize: 0,
      expand: false,
      snapSizes: const [0.1],
      initialChildSize: 0.1,
      builder: (context, scrollController) => ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              PinnedHeaderSliver(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    height: 4,
                    width: 40,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              SliverList.builder(
                itemBuilder: (context, index) => AspectRatio(
                  aspectRatio: 2,
                  child: ItemCard(
                    color: ItemCard.colorFromIndex(index),
                    title: 'Item $index',
                    subtitle: 'Information',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // TODO programmatically open bottom sheet
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const SearchBarApp(),
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        clipBehavior: Clip.none,
      ),
      body: SupportingPaneLayout(
        focusPane: ItemCard(
          color: Theme.of(context).colorScheme.primary,
          title: 'Focus Pane',
          subtitle: 'Primary focus that uses most of the space.',
        ),
        horizontalSupportingPane: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => AspectRatio(
              aspectRatio: 1,
              child: ItemCard(
                color: ItemCard.colorFromIndex(index),
                title: 'Item $index',
                subtitle: 'Information',
              ),
            ),
          ),
        ),
        verticalSupportingPane: ListView.builder(
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => AspectRatio(
            aspectRatio: 3,
            child: ItemCard(
              orientation: Orientation.landscape,
              color: ItemCard.colorFromIndex(index),
              title: 'Item $index',
              subtitle: 'Information',
            ),
          ),
        ),
        bottomSheetSupportingPane: bottomSheetSupportingPane,
      ),
      floatingActionButton:
          Breakpoints.small.isActive(context) ? const EditButton() : null,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = DraggableScrollableController();
  }
}
