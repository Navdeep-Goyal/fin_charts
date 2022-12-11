// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CandleStick {
  final double low;
  final double high;
  final double open;
  final double close;
  final double volume;
  final DateTime timestamp;

  CandleStick({
    required this.low,
    required this.high,
    required this.open,
    required this.close,
    required this.volume,
    required this.timestamp,
  });

  CandleStick.fromJson(List<dynamic> json)
      : timestamp = DateTime.fromMillisecondsSinceEpoch(json[0]),
        high = double.parse(json[2]),
        low = double.parse(json[3]),
        open = double.parse(json[1]),
        close = double.parse(json[4]),
        volume = double.parse(json[5]);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'low': low,
      'high': high,
      'open': open,
      'close': close,
      'volume': volume,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }
}
