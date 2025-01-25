import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../curved_edges/curved_edges_widget.dart';
import 'circular_container.dart';

class KPrimaryHeaderContainer extends StatelessWidget {
  const KPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return KCurvedEdgeWidget(
      child: Container(
        color: KColors.primary,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            /// Background custom shapes
            Positioned(
              top: -150,
              right: -250,
              child: KCircularContainer(
                backhroundColor: KColors.textWhite.withOpacity(0.07),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: KCircularContainer(
                backhroundColor: KColors.textWhite.withOpacity(0.07),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
