import 'package:flutter/material.dart';

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    required this.percentage,
  }) : super(key: key);

  final int? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 15,
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.2),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 15,
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
