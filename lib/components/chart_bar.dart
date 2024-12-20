import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double percentage;
  final double value;

  const ChartBar({
    required this.label,
    required this.percentage,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
          child: FittedBox(
            child: Text(value.toStringAsFixed(2)),
          ),
        ),
        const SizedBox(height: 5),
        Expanded(
          child: SizedBox(
            width: 15,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(7.5),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.5),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}
