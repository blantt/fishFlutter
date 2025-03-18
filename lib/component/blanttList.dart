import 'blanttButton.dart';
import 'package:lovetest2/page/JobLeave.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lovetest2/myConn.dart';
import 'package:lovetest2/Model/model_wp.dart';
import 'package:lovetest2/Model/model_wp.dart';
import 'package:lovetest2/routesPage.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:lovetest2/utils/dt_router.dart';
import 'package:lovetest2/WP/wp_page_edit.dart';

//gpt https://chatgpt.com/share/67999eea-2c5c-8004-9a02-28e0bc03609b
class FishListView extends StatefulWidget {
  final Future<List<dynamic>> Function() funcCallData;
  final Widget Function(BuildContext, dynamic) myitemBuilder;
  final bool? useFutureBuilder; // 🔹 是否使用 FutureBuilder
  const FishListView({
    Key? key,
    required this.funcCallData,   
    required this.myitemBuilder,
    this.useFutureBuilder= false
  }) : super(key: key);

  @override
    FishListViewState_self createState() =>  FishListViewState_self();
  //_FishListViewState createState() => _FishListViewState();

}

//使用FutureBuilder適合單純載入 API 資料
class  FishListViewState extends State<FishListView> {
  late Future<List<dynamic>> futureData;
  
  @override
  void initState() {
    super.initState();
    futureData = widget.funcCallData(); // 這裡執行 API 請求
 
  }
  
void reloadData() {
    setState(() {
      futureData = widget.funcCallData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: futureData, // 這裡就是 funcCallData() 回傳的 Future<List<dynamic>>
      builder: (context, snapshot) {
        print('blanttlist 資料載入');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // 資料載入中
        }

        if (snapshot.hasError) {
          return Center(child: Text("載入失敗: ${snapshot.error}")); // API 載入錯誤
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("沒有資料")); // API 回傳空資料
        }

        final data = snapshot.data!;

        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return widget.myitemBuilder(context, data[index]); // 自定義 itemBuilder
          },
        );
      },
    );
  }
}

//_FishListViewState_self 是不用FutureBuilder元件去控制loading,而是自己去控制state,
//先留著,如果以後需要自己控制再參考
class  FishListViewState_self extends State<FishListView> {
  List<dynamic>? _data; // 存放資料
  bool _isLoading = true; // 是否正在載入

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      List<dynamic> fetchedData = await widget.funcCallData();
      setState(() {
        //在api完全呼叫完成後,才會結束loading狀態,
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
    //gpt的做法是用FutureBuilde 去判斷loading完了沒有,
    //自己的做法是自行判斷,也許這樣更彈性
    if (_isLoading) {
      return Center(child: CircularProgressIndicator()); // 讀取中
    }
    if (_data == null || _data!.isEmpty) {
      return Center(child: Text("沒有數據")); // 無數據
    }

    return ScrollablePositionedList.builder(
      itemCount: _data!.length,
      itemBuilder: (context, index) {
        return widget.myitemBuilder(context, _data![index]);
      },
    );
  }
}


//後續研究..
//如果資料量超大,再研究 scrollController(分頁載入)
