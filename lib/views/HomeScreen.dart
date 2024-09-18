import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sof/models/ApiResponse.dart';
import 'package:sof/view_model/HomeScreenViewModel.dart';
import 'package:sof/views/widget/ItemUser.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        print("[Max]");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: ChangeNotifierProvider<HomeScreenViewModel>(
        create: (BuildContext context) => HomeScreenViewModel()..fetchItemUserListApi(),
        child: Consumer<HomeScreenViewModel>(
          builder: (context, value, _) {
            switch (value.itemUserList.status!) {
              case Status.Loading:
                return const Center(child: CircularProgressIndicator());
              case Status.Error:
                return const Text("Error");
              case Status.Complete:
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: value.itemUserList.data!.users.length,
                  itemBuilder: (context, index) {
                    return ItemUser(user: value.itemUserList.data!.users[index]);
                  },
                );
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
