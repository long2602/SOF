import 'package:flutter/material.dart';
import 'package:sof/models/ReputationUser.dart';

class ItemReputationHistory extends StatelessWidget {
  const ItemReputationHistory({super.key, required this.reputationUser});
  final ReputationUser reputationUser;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        reputationUser.formatReputationHistoryType(),
        style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
      ),
      title: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                "${(reputationUser.reputationChange ?? 0) > 0 ? "+" : ""}${reputationUser.reputationChange}",
                style: TextStyle(
                  color: reputationUser.reputationChange == 0 ? Colors.grey : (reputationUser.reputationChange! > 0 ? Colors.green : Colors.red),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                "${reputationUser.postId!}",
                style: const TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
      trailing: Text(reputationUser.formatCreationDate()),
    );
  }
}
