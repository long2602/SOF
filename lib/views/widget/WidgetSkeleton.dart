import 'package:flutter/material.dart';

class WidgetSkeleton extends StatelessWidget {
  const WidgetSkeleton({super.key, this.isLoadReputation = false});
  final bool isLoadReputation;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return ListView.separated(
      itemCount: (screenHeight / (isLoadReputation ? 10 : 72)).toInt(),
      itemBuilder: (context, index) => isLoadReputation ? reputationCardSkeleton() : userCardSkeleton(),
      separatorBuilder: (context, index) => const SizedBox(height: 2),
    );
  }
}

class SkeletonIndicator extends StatelessWidget {
  const SkeletonIndicator({super.key, this.height, this.width});

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.04), borderRadius: const BorderRadius.all(Radius.circular(16))),
    );
  }
}

Widget userCardSkeleton() {
  return const ListTile(
    leading: SkeletonIndicator(height: 56, width: 56),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SkeletonIndicator(),
        SkeletonIndicator(),
        SkeletonIndicator(),
      ],
    ),
  );
}

Widget reputationCardSkeleton() {
  return const ListTile(
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SkeletonIndicator(),
      ],
    ),
  );
}
