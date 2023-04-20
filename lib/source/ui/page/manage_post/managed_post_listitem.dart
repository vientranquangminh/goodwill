// ignore_for_file: prefer_const_constructors, empty_constructor_bodies

import 'package:flutter/material.dart';
import 'package:goodwill/source/ui/components/post_info.dart';

class ManagedPostListItem extends StatelessWidget {
  const ManagedPostListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            const PostInfo(),

            // Interaction buttons
            Row(
              children: [
                Icon(Icons.image),
                const SizedBox(width: 4.0),
                const Text('6'),
                Spacer(),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.remove_red_eye),
                  label: Text('Hide post'),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.query_stats),
                  label: Text('Statcs'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
