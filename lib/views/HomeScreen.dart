import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sof/view_model/UserProvider.dart';
import 'package:sof/views/widget/ItemUser.dart';
import 'package:sof/views/widget/WidgetCircularIndicator.dart';
import 'package:sof/views/widget/WidgetSkeleton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  int _page = 1;
  bool _isFetching = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && !_isFetching) {
      _isFetching = true;
      _page += 1;
      Provider.of<UserProvider>(context, listen: false).fetchItemUserListApi(page: _page).then((_) => _isFetching = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: SizedBox(
            height: 50,
            child: Image.asset("assets/images/LogoStackOverflow.png", fit: BoxFit.fitHeight),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Bookmarks'),
            ],
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
          ),
        ),
        body: TabBarView(
          children: [
            Consumer<UserProvider>(
              builder: (context, userProvider, _) {
                if (userProvider.isLoading && userProvider.users.isEmpty) {
                  return const WidgetSkeleton();
                }

                if (userProvider.errorMessage.isNotEmpty) {
                  return Center(
                    child: Text(userProvider.errorMessage),
                  );
                }

                return ListView.builder(
                  controller: _scrollController,
                  itemCount: userProvider.users.length + (userProvider.isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == userProvider.users.length) {
                      return userProvider.isLoading ? const WidgetCircularIndicator() : const SizedBox();
                    }
                    return ItemUser(
                      user: userProvider.users[index],
                      toggleBookMark: () {
                        userProvider.toggleBookmark(userProvider.users[index].userId!);
                      },
                      isBookMarked: userProvider.userBookMarkedIds.contains(userProvider.users[index].userId!),
                    );
                  },
                );
              },
            ),
            Consumer<UserProvider>(
              builder: (context, userProvider, _) {
                return ListView.builder(
                  itemCount: userProvider.usersBookMarked.length,
                  itemBuilder: (context, index) {
                    return ItemUser(
                      user: userProvider.usersBookMarked[index],
                      toggleBookMark: () {
                        userProvider.toggleBookmark(userProvider.usersBookMarked[index].userId!);
                      },
                      isBookMarked: userProvider.userBookMarkedIds.contains(userProvider.usersBookMarked[index].userId!),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
