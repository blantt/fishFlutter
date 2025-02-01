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
  List<dynamic>? _data; // 存放資料
  bool _isLoading = true; // 是否正在載入

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    print('beginfetchData');
    try {
      List<dynamic> fetchedData = await widget.funcCallData();
    print('bb1');
      setState(() {
        _data = fetchedData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("資料加載失敗: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    print('bb2');
    if (_isLoading) {
      return Center(child: CircularProgressIndicator()); // 讀取中
    }
    if (_data == null || _data!.isEmpty) {
      return Center(child: Text("沒有數據")); // 無數據
    }

    return ScrollablePositionedList.builder(
      itemCount: _data!.length,
      itemBuilder: (context, index) {
        return widget.itemBuilder(context, _data![index]);
      },
    );
  }
}
