import 'package:flutter/material.dart';
import 'dart:math';

class Building {
  static final Map<String, List<Offset>> rooms = {
    'Room A': [
      Offset(0, 0),
      Offset(50, 0),
      Offset(50, 50),
      Offset(0, 50),
    ],
    'Room B': [
      Offset(50, 0),
      Offset(100, 0),
      Offset(100, 50),
      Offset(50, 50),
    ],
    'Room C': [
      Offset(0, 50),
      Offset(50, 50),
      Offset(50, 100),
      Offset(0, 100),
    ],
    'Room D': [
      Offset(50, 50),
      Offset(100, 50),
      Offset(100, 100),
      Offset(50, 100),
    ]
  };

  static bool _onSegment(Offset p, Offset q, Offset r) {
    if (q.dx <= max(p.dx, r.dx) && q.dx >= min(p.dx, r.dx) && q.dy <= max(p.dy, r.dy) && q.dy >= min(p.dy, r.dy)) {
      return true;
    }
    return false;
  }

  static int _orientation(Offset p, Offset q, Offset r) {
    double val = (q.dy - p.dy) * (r.dx - q.dx) - (q.dx - p.dx) * (r.dy- q.dy);
    if (val == 0) return 0;
    return (val > 0)?1:2;
  }

  static bool _doInsection(Offset p1, Offset q1, Offset p2, Offset q2) {
    int o1 = _orientation(p1, q1, p2);
    int o2 = _orientation(p1, q1, q2);
    int o3 = _orientation(p2, q2, p1);
    int o4 = _orientation(p2, q2, q1);

    if (o1!=o2 && o3!=o4) {
      return true;
    }

    if (o1 == 0 && _onSegment(p1, p2, q1)) return true;
    if (o2 == 0 && _onSegment(p1, q2, q1)) return true;
    if (o3 == 0 && _onSegment(p2, p1, q2)) return true;
    if (o4 == 0 && _onSegment(p2, q1, q2)) return true; 
  
    return false;
  }

  static String getRoomName(Offset offset) {
    if (offset == null) return null;
    String result;
    rooms.forEach((String key, List<Offset> value) {
      if (result == null) {
        Offset extreme = Offset(101, offset.dy);
        int count = 0, i = 0;
        do {
          int next = (i+1) % value.length;
          if (_doInsection(value[i], value[next], offset, extreme)) {
            if (_orientation(value[i], offset, value[next]) == 0) {
              if (_onSegment(value[i], offset, value[next])) {
                result = key;
              }
              count = 0;
              break;
            }
            ++count;
          }
          i = next;
        } while (i != 0);
        if (count % 2 == 1) result = key;
      }
    });
    return result;
  }
}
