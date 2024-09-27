import 'package:flutter/material.dart';

/// Simple Card Widget
class ItemCard extends StatelessWidget {
  final Color color;

  final String title;

  final String subtitle;

  final Orientation orientation;

  const ItemCard({
    super.key,
    required this.color,
    required this.title,
    required this.subtitle,
    this.orientation = Orientation.portrait,
  });

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {},
        child: switch (orientation) {
          Orientation.portrait => Column(
              children: [
                Expanded(
                  child: Card(
                    color: color,
                    margin: EdgeInsets.zero,
                    child: const SizedBox.expand(),
                  ),
                ),
                ListTile(
                  title: Text(title),
                  subtitle: Text(subtitle),
                  isThreeLine: true,
                ),
              ],
            ),
          Orientation.landscape => Row(
              children: [
                Expanded(
                  child: Card(
                    color: color,
                    margin: EdgeInsets.zero,
                    child: const SizedBox.expand(),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ListTile(
                    title: Text(title),
                    subtitle: Text(subtitle),
                    isThreeLine: true,
                  ),
                ),
              ],
            ),
        },
      ),
    );
  }

  static Color colorFromIndex(int index) =>
      Colors.primaries[index % Colors.primaries.length];
}
