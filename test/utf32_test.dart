// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library utf.utf32_test;

import 'package:test/test.dart';
import 'package:utf_convert/utf_convert.dart';

import 'expect.dart' as expect;

const String testKoreanCharSubset = '''
가각갂갃간갅갆갇갈갉갊갋갌갍갎갏감갑값갓갔강갖갗갘같갚갛
개객갞갟갠갡갢갣갤갥갦갧갨갩갪갫갬갭갮갯갰갱갲갳갴갵갶갷
갸갹갺갻갼갽갾갿걀걁걂걃걄걅걆걇걈걉걊걋걌걍걎걏걐걑걒걓''';

const String testHanTwice = '二';

const testKoreanCharSubsetUtf32beBom = <int>[
  0x00, 0x00, 0xfe, 0xff, 0x00, 0x00, 0xac, 0x00, // 8
  0x00, 0x00, 0xac, 0x01, 0x00, 0x00, 0xac, 0x02,
  0x00, 0x00, 0xac, 0x03, 0x00, 0x00, 0xac, 0x04,
  0x00, 0x00, 0xac, 0x05, 0x00, 0x00, 0xac, 0x06,
  0x00, 0x00, 0xac, 0x07, 0x00, 0x00, 0xac, 0x08,
  0x00, 0x00, 0xac, 0x09, 0x00, 0x00, 0xac, 0x0a,
  0x00, 0x00, 0xac, 0x0b, 0x00, 0x00, 0xac, 0x0c,
  0x00, 0x00, 0xac, 0x0d, 0x00, 0x00, 0xac, 0x0e,
  0x00, 0x00, 0xac, 0x0f, 0x00, 0x00, 0xac, 0x10,
  0x00, 0x00, 0xac, 0x11, 0x00, 0x00, 0xac, 0x12,
  0x00, 0x00, 0xac, 0x13, 0x00, 0x00, 0xac, 0x14,
  0x00, 0x00, 0xac, 0x15, 0x00, 0x00, 0xac, 0x16,
  0x00, 0x00, 0xac, 0x17, 0x00, 0x00, 0xac, 0x18,
  0x00, 0x00, 0xac, 0x19, 0x00, 0x00, 0xac, 0x1a,
  0x00, 0x00, 0xac, 0x1b, 0x00, 0x00, 0x00, 0x0a,
  0x00, 0x00, 0xac, 0x1c, 0x00, 0x00, 0xac, 0x1d,
  0x00, 0x00, 0xac, 0x1e, 0x00, 0x00, 0xac, 0x1f,
  0x00, 0x00, 0xac, 0x20, 0x00, 0x00, 0xac, 0x21,
  0x00, 0x00, 0xac, 0x22, 0x00, 0x00, 0xac, 0x23,
  0x00, 0x00, 0xac, 0x24, 0x00, 0x00, 0xac, 0x25,
  0x00, 0x00, 0xac, 0x26, 0x00, 0x00, 0xac, 0x27,
  0x00, 0x00, 0xac, 0x28, 0x00, 0x00, 0xac, 0x29,
  0x00, 0x00, 0xac, 0x2a, 0x00, 0x00, 0xac, 0x2b,
  0x00, 0x00, 0xac, 0x2c, 0x00, 0x00, 0xac, 0x2d,
  0x00, 0x00, 0xac, 0x2e, 0x00, 0x00, 0xac, 0x2f,
  0x00, 0x00, 0xac, 0x30, 0x00, 0x00, 0xac, 0x31,
  0x00, 0x00, 0xac, 0x32, 0x00, 0x00, 0xac, 0x33,
  0x00, 0x00, 0xac, 0x34, 0x00, 0x00, 0xac, 0x35,
  0x00, 0x00, 0xac, 0x36, 0x00, 0x00, 0xac, 0x37,
  0x00, 0x00, 0x00, 0x0a, 0x00, 0x00, 0xac, 0x38,
  0x00, 0x00, 0xac, 0x39, 0x00, 0x00, 0xac, 0x3a,
  0x00, 0x00, 0xac, 0x3b, 0x00, 0x00, 0xac, 0x3c,
  0x00, 0x00, 0xac, 0x3d, 0x00, 0x00, 0xac, 0x3e,
  0x00, 0x00, 0xac, 0x3f, 0x00, 0x00, 0xac, 0x40,
  0x00, 0x00, 0xac, 0x41, 0x00, 0x00, 0xac, 0x42,
  0x00, 0x00, 0xac, 0x43, 0x00, 0x00, 0xac, 0x44,
  0x00, 0x00, 0xac, 0x45, 0x00, 0x00, 0xac, 0x46,
  0x00, 0x00, 0xac, 0x47, 0x00, 0x00, 0xac, 0x48,
  0x00, 0x00, 0xac, 0x49, 0x00, 0x00, 0xac, 0x4a,
  0x00, 0x00, 0xac, 0x4b, 0x00, 0x00, 0xac, 0x4c,
  0x00, 0x00, 0xac, 0x4d, 0x00, 0x00, 0xac, 0x4e,
  0x00, 0x00, 0xac, 0x4f, 0x00, 0x00, 0xac, 0x50,
  0x00, 0x00, 0xac, 0x51, 0x00, 0x00, 0xac, 0x52,
  0x00, 0x00, 0xac, 0x53
];

const testKoreanCharSubsetUtf32le = <int>[
  0x00, 0xac, 0x00, 0x00, 0x01, 0xac, 0x00, 0x00, // 8
  0x02, 0xac, 0x00, 0x00, 0x03, 0xac, 0x00, 0x00,
  0x04, 0xac, 0x00, 0x00, 0x05, 0xac, 0x00, 0x00,
  0x06, 0xac, 0x00, 0x00, 0x07, 0xac, 0x00, 0x00,
  0x08, 0xac, 0x00, 0x00, 0x09, 0xac, 0x00, 0x00,
  0x0a, 0xac, 0x00, 0x00, 0x0b, 0xac, 0x00, 0x00,
  0x0c, 0xac, 0x00, 0x00, 0x0d, 0xac, 0x00, 0x00,
  0x0e, 0xac, 0x00, 0x00, 0x0f, 0xac, 0x00, 0x00,
  0x10, 0xac, 0x00, 0x00, 0x11, 0xac, 0x00, 0x00,
  0x12, 0xac, 0x00, 0x00, 0x13, 0xac, 0x00, 0x00,
  0x14, 0xac, 0x00, 0x00, 0x15, 0xac, 0x00, 0x00,
  0x16, 0xac, 0x00, 0x00, 0x17, 0xac, 0x00, 0x00,
  0x18, 0xac, 0x00, 0x00, 0x19, 0xac, 0x00, 0x00,
  0x1a, 0xac, 0x00, 0x00, 0x1b, 0xac, 0x00, 0x00,
  0x0a, 0x00, 0x00, 0x00, 0x1c, 0xac, 0x00, 0x00,
  0x1d, 0xac, 0x00, 0x00, 0x1e, 0xac, 0x00, 0x00,
  0x1f, 0xac, 0x00, 0x00, 0x20, 0xac, 0x00, 0x00,
  0x21, 0xac, 0x00, 0x00, 0x22, 0xac, 0x00, 0x00,
  0x23, 0xac, 0x00, 0x00, 0x24, 0xac, 0x00, 0x00,
  0x25, 0xac, 0x00, 0x00, 0x26, 0xac, 0x00, 0x00,
  0x27, 0xac, 0x00, 0x00, 0x28, 0xac, 0x00, 0x00,
  0x29, 0xac, 0x00, 0x00, 0x2a, 0xac, 0x00, 0x00,
  0x2b, 0xac, 0x00, 0x00, 0x2c, 0xac, 0x00, 0x00,
  0x2d, 0xac, 0x00, 0x00, 0x2e, 0xac, 0x00, 0x00,
  0x2f, 0xac, 0x00, 0x00, 0x30, 0xac, 0x00, 0x00,
  0x31, 0xac, 0x00, 0x00, 0x32, 0xac, 0x00, 0x00,
  0x33, 0xac, 0x00, 0x00, 0x34, 0xac, 0x00, 0x00,
  0x35, 0xac, 0x00, 0x00, 0x36, 0xac, 0x00, 0x00,
  0x37, 0xac, 0x00, 0x00, 0x0a, 0x00, 0x00, 0x00,
  0x38, 0xac, 0x00, 0x00, 0x39, 0xac, 0x00, 0x00,
  0x3a, 0xac, 0x00, 0x00, 0x3b, 0xac, 0x00, 0x00,
  0x3c, 0xac, 0x00, 0x00, 0x3d, 0xac, 0x00, 0x00,
  0x3e, 0xac, 0x00, 0x00, 0x3f, 0xac, 0x00, 0x00,
  0x40, 0xac, 0x00, 0x00, 0x41, 0xac, 0x00, 0x00,
  0x42, 0xac, 0x00, 0x00, 0x43, 0xac, 0x00, 0x00,
  0x44, 0xac, 0x00, 0x00, 0x45, 0xac, 0x00, 0x00,
  0x46, 0xac, 0x00, 0x00, 0x47, 0xac, 0x00, 0x00,
  0x48, 0xac, 0x00, 0x00, 0x49, 0xac, 0x00, 0x00,
  0x4a, 0xac, 0x00, 0x00, 0x4b, 0xac, 0x00, 0x00,
  0x4c, 0xac, 0x00, 0x00, 0x4d, 0xac, 0x00, 0x00,
  0x4e, 0xac, 0x00, 0x00, 0x4f, 0xac, 0x00, 0x00,
  0x50, 0xac, 0x00, 0x00, 0x51, 0xac, 0x00, 0x00,
  0x52, 0xac, 0x00, 0x00, 0x53, 0xac, 0x00, 0x00
];

void main() {
  test('utf32 bytes to string', testUtf32BytesToString);
  test('encode to utf32', testEncodeToUtf32);
  test('iterable methods', testIterableMethods);
}

void testEncodeToUtf32() {
  expect.listEquals(
      [], encodeUtf32le(''), 'no input'); // TODO(dcarlson) skip bom on empty?
  expect.listEquals(testKoreanCharSubsetUtf32beBom,
      encodeUtf32(testKoreanCharSubset), 'encode UTF-32(BE by default) Korean');
  expect.listEquals(
      testKoreanCharSubsetUtf32le,
      encodeUtf32le(testKoreanCharSubset),
      'encode UTF-32(LE by default) Korean');
}

void testUtf32BytesToString() {
  expect.stringEquals('', decodeUtf32([]), 'no input');
  expect.stringEquals('\ufffd', decodeUtf32([0]), 'single byte');
  expect.stringEquals('\ufffd', decodeUtf32([0, 0, 0x4e]), 'short a byte');
  expect.stringEquals(
      '\u4e8c\ufffd', decodeUtf32([0, 0, 0x4e, 0x8c, 0]), 'extra byte');

  expect.stringEquals(
      testHanTwice, decodeUtf32([0, 0, 0x4e, 0x8c]), 'twice variation 1');
  expect.stringEquals(testHanTwice,
      decodeUtf32([0, 0, 0xfe, 0xff, 0, 0, 0x4e, 0x8c]), 'twice variation 2');
  expect.stringEquals(testHanTwice,
      decodeUtf32([0xff, 0xfe, 0, 0, 0x8c, 0x4e, 0, 0]), 'twice variation 3');

  expect.stringEquals(
      testHanTwice, decodeUtf32be([0, 0, 0x4e, 0x8c]), 'twice variation 4');
  expect.stringEquals(testHanTwice,
      decodeUtf32be([0, 0, 0xfe, 0xff, 0, 0, 0x4e, 0x8c]), 'twice variation 5');

  expect.stringEquals(
      testHanTwice, decodeUtf32le([0x8c, 0x4e, 0, 0]), 'twice variation 6');
  expect.stringEquals(testHanTwice,
      decodeUtf32le([0xff, 0xfe, 0, 0, 0x8c, 0x4e, 0, 0]), 'twice variation 7');

  expect.stringEquals(testKoreanCharSubset,
      decodeUtf32(testKoreanCharSubsetUtf32beBom), 'UTF-32BE Korean');
}

void testIterableMethods() {
  // empty input
  expect.isFalse(decodeUtf32AsIterable([]).iterator.moveNext());

  var koreanDecoder = decodeUtf32AsIterable(testKoreanCharSubsetUtf32beBom);
  // get the first character
  expect.equals(testKoreanCharSubset.codeUnits[0], koreanDecoder.first);
  // get the whole translation using the Iterable interface
  expect.stringEquals(testKoreanCharSubset,
      String.fromCharCodes(List<int>.from(koreanDecoder)));

  // specify types
  expect.equals(
      44032,
      (List<int>.from(
          decodeUtf32beAsIterable(testKoreanCharSubsetUtf32beBom)))[0]);
  expect.equals(
      44032,
      (List<int>.from(
          decodeUtf32leAsIterable(testKoreanCharSubsetUtf32le)))[0]);
  var stripBom = false;
  expect.equals(
      UNICODE_BOM,
      (List<int>.from(decodeUtf32beAsIterable(
          testKoreanCharSubsetUtf32beBom, 0, null, stripBom)))[0]);
}
