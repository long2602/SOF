import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sof/view_model/ReputationHistoryProvider.dart';
import 'package:sof/views/widget/ItemReputationHistory.dart';

import '../models/ReputationUser.dart';
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
    Provider.of<ReputationHistoryProvider>(context, listen: false).fetchItemReputationListApi(userId: _user.userId!);
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
            Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: CachedNetworkImage(
                    imageUrl: _user.profileImage!,
                    height: 120,
                    placeholder: (context, url) => CircularProgressIndicator(
                      strokeWidth: .5,
                      backgroundColor: Colors.teal.withOpacity(.5),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _user.displayName ?? "",
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20, overflow: TextOverflow.ellipsis),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.grey,
                          size: 16,
                        ),
                        Text(
                          _user.location ?? "",
                          style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 16, overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Expanded(
              child: Consumer<ReputationHistoryProvider>(
                builder: (context, reputationProvider, _) {
                  return ListView.separated(
                    separatorBuilder: (context, index) => const Divider(height: .1, thickness: 0.5),
                    controller: _scrollController,
                    itemCount: reputationProvider.reputationHistories.length,
                    itemBuilder: (context, index) {
                      ReputationUser reputationUser = reputationProvider.reputationHistories[index];
                      return ItemReputationHistory(reputationUser: reputationUser);
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
