import 'dart:async';
import 'package:flutter/material.dart';

enum _Element { background, text, textHighlighted }

final _lightTheme = {
  _Element.background: Colors.white,
  _Element.text: Colors.grey.withOpacity(0.2),
  _Element.textHighlighted: Colors.black
};

final _darkTheme = {
  _Element.background: Colors.black,
  _Element.text: Colors.grey.withOpacity(0.2),
  _Element.textHighlighted: Colors.white
};

class DigitalClock extends StatefulWidget {
  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  String wordClockMinute;
  String wordClockHour;

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      wordClockMinute = 'IT\'S ';
      var hourNames = [
        'ONE',
        'TWO',
        'THREE',
        'FOUR',
        'FIVE',
        'SIX',
        'SEVEN',
        'EIGHT',
        'NINE',
        'TEN',
        'ELEVEN',
        'TWELVE'
      ];
      int _indexM = ((_dateTime.minute / 5).floor() * 5) % 60;
      int _indexH = 0;
      _indexH = _dateTime.hour % 12;
      switch (_indexM) {
        case 0:
          wordClockMinute += 'O\'CLOCK';
          wordClockHour = hourNames[(_indexH - 1) < 0 ? 11 : (_indexH - 1)];
          break;
        case 5:
          wordClockMinute += 'FIVE PAST';
          wordClockHour = hourNames[(_indexH - 1) < 0 ? 11 : (_indexH - 1)];
          break;
        case 10:
          wordClockMinute += 'TEN PAST';
          wordClockHour = hourNames[(_indexH - 1) < 0 ? 11 : (_indexH - 1)];
          break;
        case 15:
          wordClockMinute += 'A QUARTER PAST';
          wordClockHour = hourNames[(_indexH - 1) < 0 ? 11 : (_indexH - 1)];
          break;
        case 20:
          wordClockMinute += 'TWENTY PAST';
          wordClockHour = hourNames[(_indexH - 1) < 0 ? 11 : (_indexH - 1)];
          break;
        case 25:
          wordClockMinute += 'TWENTY FIVE PAST';
          wordClockHour = hourNames[(_indexH - 1) < 0 ? 11 : (_indexH - 1)];
          break;
        case 30:
          wordClockMinute += 'HALF PAST';
          wordClockHour = hourNames[(_indexH - 1) < 0 ? 11 : (_indexH - 1)];
          break;
        case 35:
          wordClockMinute += 'TWENTY FIVE TO';
          wordClockHour = hourNames[_indexH % 12];
          break;
        case 40:
          wordClockMinute += 'TWENTY TO';
          wordClockHour = hourNames[_indexH % 12];
          break;
        case 45:
          wordClockMinute += 'A QUARTER TO';
          wordClockHour = hourNames[_indexH % 12];
          break;
        case 50:
          wordClockMinute += 'TEN TO';
          wordClockHour = hourNames[_indexH % 12];
          break;
        case 55:
          wordClockMinute += 'FIVE TO';
          wordClockHour = hourNames[_indexH % 12];
          break;
      }
      _timer = Timer(
        Duration(minutes: 1) -
            Duration(seconds: _dateTime.second) -
            Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = MediaQuery.of(context).platformBrightness == Brightness.light
        ? _lightTheme
        : _darkTheme;
    return Material(
      color: colors[_Element.background],
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Theme.of(context).unselectedWidgetColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Center(
            child: Wrap(
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              spacing: MediaQuery.of(context).size.width / 35,
              runSpacing: MediaQuery.of(context).size.width / 35,
              children: <Widget>[
                ClockText("IT'S", wordClockMinute.split(" ")),
                ClockText("HALF", wordClockMinute.split(" ")),
                ClockText("TEN", wordClockMinute.split(" ")),
                ClockText("QUARTER", wordClockMinute.split(" ")),
                ClockText("TWENTY", wordClockMinute.split(" ")),
                ClockText("FIVE", wordClockMinute.split(" ")),
                ClockText("TO", wordClockMinute.split(" ")),
                ClockText("PAST", wordClockMinute.split(" ")),
                ClockText("ONE", wordClockHour.split(" ")),
                ClockText("TWO", wordClockHour.split(" ")),
                ClockText("THREE", wordClockHour.split(" ")),
                ClockText("FOUR", wordClockHour.split(" ")),
                ClockText("FIVE", wordClockHour.split(" ")),
                ClockText("SIX", wordClockHour.split(" ")),
                ClockText("SEVEN", wordClockHour.split(" ")),
                ClockText("EIGHT", wordClockHour.split(" ")),
                ClockText("NINE", wordClockHour.split(" ")),
                ClockText("TEN", wordClockHour.split(" ")),
                ClockText("ELEVEN", wordClockHour.split(" ")),
                ClockText("TWELVE", wordClockHour.split(" ")),
                ClockText("O'CLOCK", wordClockMinute.split(" ")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ClockText extends StatelessWidget {
  ClockText(
    this.label,
    this.wordClockList,
  );
  final String label;
  final List<String> wordClockList;

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width / 20;
    final colors = MediaQuery.of(context).platformBrightness == Brightness.light
        ? _lightTheme
        : _darkTheme;
    return AnimatedDefaultTextStyle(
      style: (wordClockList.contains(label))
          ? TextStyle(
              color: colors[_Element.textHighlighted],
              fontFamily: 'MontserratAlternates',
            )
          : TextStyle(
              color: colors[_Element.text],
              fontFamily: 'MontserratAlternates',
            ),
      duration: const Duration(seconds: 1),
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
        ),
      ),
    );
  }
}
