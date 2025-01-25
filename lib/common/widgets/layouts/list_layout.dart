import 'package:flutter/material.dart';

class KListLayout extends StatelessWidget {
  const KListLayout(
      {super.key, required this.itemCount, required this.itemBuilder});

  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: itemBuilder,
    );
  }
}
