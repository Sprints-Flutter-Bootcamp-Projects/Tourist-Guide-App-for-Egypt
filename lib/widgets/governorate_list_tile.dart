import 'package:flutter/material.dart';

class GovernorateListTile extends StatelessWidget {
  final String? goverorateName;
  final void Function()? onTap;

  const GovernorateListTile({
    super.key,
    this.goverorateName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: IconButton.filledTonal(
            onPressed: () {}, icon: const Icon(Icons.pin_drop)),
        title: Text(goverorateName!),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap);
  }
}
