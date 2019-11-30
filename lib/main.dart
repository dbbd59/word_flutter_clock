// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'word_clock.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb && Platform.isMacOS) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }

  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(
    MaterialApp(
      home: SafeArea(
        child: Center(
          child: Container(
            child: WordClock(),
          ),
        ),
      ),
    ),
  );
}
