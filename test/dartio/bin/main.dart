// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'package:hetima_backendless/backendless.dart';
import 'package:hetima_backendless/backendless_dartio.dart';
import 'package:unittest/unittest.dart';

main(List<String> args)  async {
  print("## --1--");
  group("", () {
    test("method", () async {
      HetimaDartIoBuilder builder = new HetimaDartIoBuilder();
      HetimaRequester requester = await builder.createRequester();
      HetimaResponse response = await requester.request(HetimaRequester.TYPE_POST, "http://localhost:8080/method");
      expect("post", UTF8.decode(response.response.asUint8List()).toLowerCase());
      return "";
    });

    test("header", () async {
      HetimaDartIoBuilder builder = new HetimaDartIoBuilder();
      HetimaRequester requester = await builder.createRequester();
      HetimaResponse response = await requester.request(
        HetimaRequester.TYPE_POST,
        "http://localhost:8080/header",
        headers: {"nono":"nano"});
        expect(true, UTF8.decode(response.response.asUint8List()).toLowerCase().contains("nono:nano"));
      return "";
    });
    test("content", () async {
      HetimaDartIoBuilder builder = new HetimaDartIoBuilder();
      HetimaRequester requester = await builder.createRequester();
      HetimaResponse response = await requester.request(
        HetimaRequester.TYPE_POST,
        "http://localhost:8080/content", data: "hello!!");
        expect("hello!!", UTF8.decode(response.response.asUint8List()));
      return "";
    });
  });
}