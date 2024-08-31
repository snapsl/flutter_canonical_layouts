import 'dart:ui';

import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const SearchBarApp(),
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
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
                color: colorFromIndex(index),
                title: 'Item $index',
                subtitle: 'Information',
              ),
            ),
          ),
        ),
        verticalSupportingPane: ListView.builder(
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => AspectRatio(
            aspectRatio: 2,
            child: ItemCard(
              color: colorFromIndex(index),
              title: 'Item $index',
              subtitle: 'Information',
            ),
          ),
        ),
        bottomSheetSupportingPane: DraggableScrollableSheet(
          controller: controller,
          snap: true,
          expand: false,
          maxChildSize: 0.95,
          minChildSize: 0,
          snapSizes: const [0.1],
          initialChildSize: 0.1,
          builder: (context, scrollController) => ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                PinnedHeaderSliver(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).hintColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        height: 4,
                        width: 40,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CloseButton(
                          onPressed: () => controller.animateTo(0,
                              curve: Curves.linear,
                              duration: Durations.medium1),
                        ),
                      )
                    ],
                  ),
                ),
                SliverList.builder(
                  itemBuilder: (context, index) => AspectRatio(
                    aspectRatio: 2,
                    child: ItemCard(
                      color: colorFromIndex(index),
                      title: 'Item $index',
                      subtitle: 'Information',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
