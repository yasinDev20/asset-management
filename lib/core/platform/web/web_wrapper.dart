// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// 'web_wrapper_web.dart' hanya bisa di import di web saja jika di import di non web maka eror. oleh karena itu perlu pemisahan 3 file ini

export 'web_wrapper_stub.dart' if (dart.library.js_util) 'web_wrapper_web.dart';