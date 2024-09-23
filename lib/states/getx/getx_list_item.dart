import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetxListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget target;

  const GetxListItem(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.target});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(target);
      },
      child: Container(
        decoration: const BoxDecoration(color: Colors.black12),
        margin: const EdgeInsets.all(8),
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: InkWell(
              onTap: () {
                Get.to(target);
              },
              child: const Icon(Icons.arrow_forward_ios)),
        ),
      ),
    );
  }
}
