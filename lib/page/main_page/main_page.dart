import 'package:app_tracker_search/page/main_page/main_model.dart';
import 'package:app_tracker_search/widget/search_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => MainModel()),
    ], child: _MainPage(context));
  }
}

class _MainPage extends StatelessWidget {
  const _MainPage(BuildContext context, {Key? key}) : super(key: key);

  Widget _buildContent() {
    return Consumer<MainModel>(
      builder: (context, model, child) {
        if (model.first) {
          return const Expanded(
            child: Center(
              child: Text(
                '欢迎使用，请在上方输入框输入关键字',
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        } else {
          if (model.searching) {
            return const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            if (model.empty) {
              return const Expanded(
                child: Center(
                  child: Text('没有搜索到相关应用'),
                ),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20.0),
                    itemCount:
                        context.watch<MainModel>().searchListData?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return SearchItem(
                        context.watch<MainModel>().searchListData![index],
                      );
                    }),
              );
            }
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Tracker Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  context.read<MainModel>().search(value);
                }),
          ),
          const Text(
            '单击复制启动项，双击查看图标，长按查看更多选项',
            style: TextStyle(color: Colors.grey),
          ),
          _buildContent()
        ],
      ),
    );
  }
}
