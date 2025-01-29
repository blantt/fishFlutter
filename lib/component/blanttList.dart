import 'package:blantt_love_test/component/blanttButton.dart';
import 'package:blantt_love_test/page/JobLeave.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:blantt_love_test/myConn.dart';
import 'package:blantt_love_test/Model/model_wp.dart';
import 'package:blantt_love_test/routesPage.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:blantt_love_test/utils/dt_router.dart';
import 'package:blantt_love_test/WP/wp_page_edit.dart';

//gpt https://chatgpt.com/share/67999eea-2c5c-8004-9a02-28e0bc03609b
class FishListView extends StatefulWidget {
  final Future<List<dynamic>> Function() funcCallData;
  final Widget Function(BuildContext, dynamic) itemBuilder;

  const FishListView({
    Key? key,
    required this.funcCallData,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  _FishListViewState createState() => _FishListViewState();
}

class _FishListViewState extends State<FishListView> {
  late Future<List<dynamic>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = widget.funcCallData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _dataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("發生錯誤"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("沒有數據"));
        }

        return ScrollablePositionedList.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return widget.itemBuilder(context, snapshot.data![index]);
          },
        );
      },
    );
  }
}

