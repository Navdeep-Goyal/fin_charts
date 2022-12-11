import 'package:fin_charts/candle_chart/core/models/candle_stick.dart';
import 'package:flutter/material.dart';

class CandleChart extends StatelessWidget {
  const CandleChart({super.key, required this.list});
  final List<CandleStick> list;

  @override
  Widget build(BuildContext context) {
    return CandleChartWidget(
      list: list,
      high: 17238.06,
      low: 16977.36,
    );
  }
}

class CandleChartWidget extends LeafRenderObjectWidget {
  final List<CandleStick> list;
  final double high;
  final double low;

  const CandleChartWidget(
      {Key? key, required this.list, required this.high, required this.low})
      : super(key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return CandleChartRenderObject(list: list, rangeHigh: high, rangeLow: low);
  }

  // @override
  // void updateRenderObject(
  //     BuildContext context, covariant RenderObject renderObject) {
  //   CandleChartRenderObject candleChartRenderObject =
  //       renderObject as CandleChartRenderObject;

  //   super.updateRenderObject(context, renderObject);
  // }
}

class CandleChartRenderObject extends RenderBox {
  final List<CandleStick> list;
  final double rangeHigh;
  final double rangeLow;

  CandleChartRenderObject(
      {required this.list, required this.rangeHigh, required this.rangeLow});

  @override
  void performLayout() {
    size = Size(constraints.maxWidth, constraints.maxHeight);
  }

  paintCandle(
    PaintingContext context,
    Offset offset,
    int index,
    CandleStick candleStick,
    double range,
  ) {
    Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    double x = size.width + offset.dx - (index + 0.5) * 2;
    print(offset.dy);
    print(offset.dy + (rangeHigh - candleStick.high) / range);

    context.canvas.drawLine(
      Offset(x, offset.dy + (rangeHigh - candleStick.high) / range),
      Offset(x, offset.dy + (rangeHigh - candleStick.low) / range),
      paint,
    );

    final double openCandleY =
        offset.dy + (rangeHigh - candleStick.open) / range;
    final double closeCandleY =
        offset.dy + (rangeHigh - candleStick.close) / range;

    if ((openCandleY - closeCandleY).abs() > 1) {
      context.canvas.drawLine(
        Offset(x, openCandleY),
        Offset(x, closeCandleY),
        paint..strokeWidth = 2 * 0.8,
      );
    } else {
      // if the candle body is too small
      final double mid = (closeCandleY + openCandleY) / 2;
      context.canvas.drawLine(
        Offset(x, mid - 0.5),
        Offset(x, mid + 0.5),
        paint..strokeWidth = 2 * 0.8,
      );
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    double range = rangeHigh - rangeLow;
    for (int i = 0; (i + 1) * 2 < size.width; i++) {
      paintCandle(context, offset, i, list[i], range);
    }
  }
}
