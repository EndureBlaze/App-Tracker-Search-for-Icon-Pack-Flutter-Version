import 'dart:io';

import 'package:app_tracker_search/types/search_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class SearchItem extends StatefulWidget {
  final SearchListData data;
  const SearchItem(this.data, {Key? key}) : super(key: key);

  @override
  State<SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  Future<void> saveIcon(String imageUrl) {
    return Future(() async {
      var bytes = (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl))
          .buffer
          .asUint8List();
      var cachePath = await getTemporaryDirectory();
      var file = File('${cachePath.path}/${widget.data.packageName}.png');
      await file.writeAsBytes(bytes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: widget.data.activityName));
        const snackBar = SnackBar(
          content: Text('已复制启动项'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      onDoubleTap: () {
        showIcon();
      },
      onLongPress: () {
        copyMore(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('应用名：${widget.data.appName}'),
            Text('包名：${widget.data.packageName}'),
            Text('启动项：${widget.data.activityName}'),
          ],
        ),
      ),
    );
  }

  void showIcon() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(widget.data.appName),
            content: Image.network(
              'https://bot.k2t3k.tk/api/appIcon?packageName=${widget.data.packageName}',
              height: 150,
              width: 150,
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await saveIcon(
                      'https://bot.k2t3k.tk/api/appIcon?packageName=${widget.data.packageName}');
                  const snackBar = SnackBar(
                    content: Text('保存成功'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  // Navigator.of(context).pop();
                },
                child: const Text("保存到相册"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("关闭"),
              ),
            ],
          );
        });
  }

  Future<void> copyMore(BuildContext context) async {
    int? i = await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('请选择'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 1);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text('复制包名'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 2);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text('复制启动项'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 3);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text('复制 appfilter.xml'),
                ),
              ),
            ],
          );
        });

    if (i != null) {
      switch (i) {
        case 1:
          Clipboard.setData(ClipboardData(text: widget.data.packageName));
          const snackBar = SnackBar(
            content: Text('已复制包名'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
        case 2:
          Clipboard.setData(ClipboardData(text: widget.data.activityName));
          const snackBar = SnackBar(
            content: Text('已复制启动项'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
        case 3:
          Clipboard.setData(ClipboardData(
              text:
                  '<item component="ComponentInfo{${widget.data.packageName}/${widget.data.activityName}}" drawable="${widget.data.appName}"/>'));
          const snackBar = SnackBar(
            content: Text('复制 appfilter.xml'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
      }
    }
  }
}

// class SearchItem extends StatelessWidget {
//   final SearchListData data;
//   const SearchItem(this.data, {Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(providers: [
//       ChangeNotifierProvider(create: (context) => IconModel()),
//     ], child: _SearchItem(data, context));
//   }
// }

// class _SearchItem extends StatelessWidget {
//   final SearchListData data;
//   final BuildContext context;
//   const _SearchItem(this.data, this.context, {Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Clipboard.setData(ClipboardData(text: data.activityName));
//         const snackBar = SnackBar(
//           content: Text('已复制启动项'),
//         );
//         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//       },
//       onDoubleTap: () {
//         showIcon();
//       },
//       onLongPress: () {
//         copyMore(context);
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('应用名：${data.appName}'),
//             Text('包名：${data.packageName}'),
//             Text('启动项：${data.activityName}'),
//           ],
//         ),
//       ),
//     );
//   }

 
// }
