import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:paint1/shapes.dart';

import 'custom_paint.dart';

class Home extends StatefulWidget {

  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  double pencilWidth = 1;
  List<PathPainter> pathPainters = [];
  double valueRed = 0.0, valueGreen = 0.0, valueBlue = 0.0;
  Color color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onPanUpdate: (details) {
              setState(() {

                pathPainters.add(PathPainter(
                  details.localPosition.dx,
                  details.localPosition.dy,
                  pencilWidth,
                  color,
                ));
              });
            },
            child: CustomPaint(
              painter: Pencil(pathPainters),
              child: Container(),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 250,
              height: 75,
              child: Slider(
                value: pencilWidth,
                onChanged: (newWidth) {
                  setState(() {
                    pencilWidth = newWidth;
                    print("Pencil width: $pencilWidth");
                  });
                },
                min: 0,
                max: 20,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  pathPainters.clear();
                });
              },
              icon: const Icon(Icons.clear),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: color,

                          onColorChanged: (newColor) {
                            setState(() {
                              color = newColor;
                              Navigator.of(context).pop();

                            });
                          },
                          pickerAreaHeightPercent: 0.8,
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Got it'),
                          onPressed: () {
                            Navigator.of(context).pop();

                          },
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.color_lens_sharp),
            ),
          ],
        ),
      ),
    );
  }
}