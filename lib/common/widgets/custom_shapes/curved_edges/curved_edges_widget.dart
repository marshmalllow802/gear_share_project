import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/custom_shapes/curved_edges/curved_edges.dart';

class KCurvedEdgeWidget extends StatelessWidget {
  const KCurvedEdgeWidget({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: KCustomCurvedEdges(),
      child: child,
    );
  }
}
