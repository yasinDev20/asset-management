// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

export 'package:google_sign_in_web/web_only.dart';

import 'dart:js_interop';
import 'dart:typed_data';
import 'package:mime/mime.dart';
import 'package:web/web.dart' as web;

void openFile(Uint8List bytes,) {
  // convert to JS Uint8Array
  final jsUint8Array = bytes.toJS;

  // create JSArray<BlobPart>
  final parts = <web.BlobPart>[jsUint8Array].toJS;

  // create Blob
  final blob = web.Blob(
    parts,
    web.BlobPropertyBag(
      type:
          lookupMimeType('', headerBytes: bytes) ?? 'application/octet-stream',
    ),
  );
  //create url
  final url = web.URL.createObjectURL(blob);
  //open new tab
  web.window.open(url, '_blank');

  //clear memory
  Future.delayed(const Duration(seconds: 30), () {
    web.URL.revokeObjectURL(url);
  });
}
