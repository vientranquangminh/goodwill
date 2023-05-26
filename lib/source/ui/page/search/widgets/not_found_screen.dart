import 'package:flutter/material.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Column(
          children: [
            Image.asset('assets/images/not_found.png'),
            const SizedBox(height: 16),
            Text(
              context.localizations.notFound,
              style: const TextStyle(color: Colors.black)
                  .copyWith(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              context.localizations.sorryYou,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(color: Colors.black).copyWith(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
