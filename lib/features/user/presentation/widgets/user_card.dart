// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String name;

  final void Function()? onTap;

  const UserCard({super.key, required this.name, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              //nama+identitynumber
              SizedBox(
                width: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                      ],
                ),
              ),
              ],
          ),
        ),
      ),
    );
  }
}
