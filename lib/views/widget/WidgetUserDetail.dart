import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sof/models/User.dart';

class WidgetUserDetail extends StatelessWidget {
  const WidgetUserDetail({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: CachedNetworkImage(
            imageUrl: user.profileImage!,
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
              user.displayName ?? "",
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
                  user.location ?? "",
                  style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 16, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
