import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingTile extends StatelessWidget {
  const ShimmerLoadingTile({
    super.key,
    this.totalItem = 3,
  });

  /// Total Number of item in list for shimmer.
  final int totalItem;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) =>  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 12,
            children: [
              Container(
                width: 96.0,
                height: 72.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 10.0,
                      color: Colors.white,
                      margin: const EdgeInsets.only(bottom: 8.0),
                    ),
                      Container(
                        width: double.infinity,
                        height: 10.0,
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 8.0),
                      ),
                    Container(
                      width: 100.0,
                      height: 10.0,
                      color: Colors.white,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemCount: totalItem,
      ),
    );
  }
}
