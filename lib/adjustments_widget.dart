import 'package:flutter/material.dart';

class AdjustmentsWidget extends StatefulWidget {
  final Function(double brightness) onBrightnessChanged;
  final Function(double contrast) onContrastChanged;
  final Function(String borderShape) onBorderShapeChanged;

  AdjustmentsWidget({
    required this.onBrightnessChanged,
    required this.onContrastChanged,
    required this.onBorderShapeChanged,
  });

  @override
  _AdjustmentsWidgetState createState() => _AdjustmentsWidgetState();
}

class _AdjustmentsWidgetState extends State<AdjustmentsWidget> {
  double brightness = 0.0;
  double contrast = 1.0;
  String borderShape = "square"; // Default border shape

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.black,
      child: Column(
        children: [
          // Brightness Slider
          ListTile(
            title: Text(
              'Brightness',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Slider(
              value: brightness,
              min: -1.0,
              max: 1.0,
              divisions: 20,
              onChanged: (value) {
                setState(() {
                  brightness = value;
                });
                widget.onBrightnessChanged(value);
              },
            ),
          ),
          // Contrast Slider
          ListTile(
            title: Text(
              'Contrast',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Slider(
              value: contrast,
              min: 0.5,
              max: 2.0,
              divisions: 20,
              onChanged: (value) {
                setState(() {
                  contrast = value;
                });
                widget.onContrastChanged(value);
              },
            ),
          ),
          // Border Shape Selector
          DropdownButton<String>(
            value: borderShape,
            items: [
              DropdownMenuItem(value: "square", child: Text("Square")),
              DropdownMenuItem(value: "rounded", child: Text("Rounded")),
              DropdownMenuItem(value: "oval", child: Text("Oval")),
            ],
            onChanged: (value) {
              setState(() {
                borderShape = value!;
              });
              widget.onBorderShapeChanged(value!);
            },
            hint: Text(
              "Select Border Shape",
              style: TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              print("Border applied!"); // This will apply the selected border shape
            },
            child: Text('Apply Border'),
          ),
        ],
      ),
    );
  }
}
