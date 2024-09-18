import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sof/models/User.dart';

import '../DetailReputationScreen.dart';

class ItemUser extends StatelessWidget {
  const ItemUser({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailReputationScreen(user: user),
            ));
      },
      leading: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: CachedNetworkImage(
          imageUrl: user.profileImage!,
          placeholder: (context, url) => CircularProgressIndicator(
            strokeWidth: .5,
            backgroundColor: Colors.teal.withOpacity(.5),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user.displayName ?? "",
            style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w500, fontSize: 16, overflow: TextOverflow.ellipsis),
          ),
          Text(
            user.location ?? "",
            style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 14, overflow: TextOverflow.ellipsis),
          ),
          Text(
            "${user.reputation ?? 0}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(Icons.bookmark_border_rounded),
      ),
    );
  }
}
