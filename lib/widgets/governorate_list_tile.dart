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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        tileColor: Colors.teal[50],
        leading: IconButton.filledTonal(
          style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.teal[100])),
            color: Colors.teal[900],
            onPressed: (){}, icon: Icon(Icons.pin_drop)),
        title: Text(goverorateName!, style: TextStyle(color: Colors.teal[900])),
        trailing: Icon(Icons.chevron_right),
        onTap: onTap
    );
  }
}