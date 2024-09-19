import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sof/view_model/ReputationHistoryProvider.dart';
import 'package:sof/views/widget/ItemReputationHistory.dart';
import 'package:sof/views/widget/WidgetCircularIndicator.dart';
import 'package:sof/views/widget/WidgetSkeleton.dart';
import 'package:sof/views/widget/WidgetUserDetail.dart';

import '../models/User.dart';

class DetailReputationScreen extends StatefulWidget {
  const DetailReputationScreen({super.key, required this.user});
  final User user;

  @override
  State<DetailReputationScreen> createState() => _DetailReputationScreenState();
}

class _DetailReputationScreenState extends State<DetailReputationScreen> {
  late User _user;
  final _scrollController = ScrollController();
  int _page = 1;
  bool _isFetching = false;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReputationHistoryProvider>(context, listen: false).fetchItemReputationListApi(userId: _user.userId!);
    });
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
      Provider.of<ReputationHistoryProvider>(context, listen: false)
          .fetchItemReputationListApi(userId: _user.userId!, page: _page)
          .then((_) => _isFetching = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            WidgetUserDetail(user: _user),
            Expanded(
              child: Consumer<ReputationHistoryProvider>(
                builder: (context, reputationProvider, _) {
                  if (reputationProvider.isLoading && reputationProvider.reputationHistories.isEmpty) {
                    return const WidgetSkeleton(isLoadReputation: true);
                  }

                  if (reputationProvider.errorMessage.isNotEmpty) {
                    return Center(
                      child: Text(reputationProvider.errorMessage),
                    );
                  }

                  return ListView.separated(
                    separatorBuilder: (context, index) => const Divider(height: .1, thickness: 0.5),
                    controller: _scrollController,
                    itemCount: reputationProvider.reputationHistories.length + (reputationProvider.isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == reputationProvider.reputationHistories.length) {
                        return reputationProvider.isLoading ? const WidgetCircularIndicator() : const SizedBox();
                      }
                      return ItemReputationHistory(reputationUser: reputationProvider.reputationHistories[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
