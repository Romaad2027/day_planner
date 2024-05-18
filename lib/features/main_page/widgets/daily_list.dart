import 'package:flutter/material.dart';

class DailyList extends StatelessWidget {
  const DailyList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 25,
      itemBuilder: (context, index) {
        return const ListTile(
          title: Text('Running'),
          subtitle: Text('Sport'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.monitor_heart),
              Text('99'),
              Icon(Icons.local_fire_department),
              Text('1500'),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        );
      },
    );
  }
}
