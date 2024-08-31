import 'package:flutter/material.dart';

Color colorFromIndex(int index) =>
    Colors.primaries[index % Colors.primaries.length];

class ItemCard extends StatelessWidget {
  final Color color;

  final String title;

  final String subtitle;

  const ItemCard({
    super.key,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {},
        child: Column(children: [
          Expanded(
            child: Card(
              color: color,
              child: const SizedBox.expand(),
            ),
          ),
          ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            isThreeLine: true,
          )
        ]),
      ),
    );
  }
}
