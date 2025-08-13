// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String identitynumber;
  final String termStart;
  final String termEnd;
  final List location;
  final void Function()? onTap;

  const UserCard({
    super.key,
    required this.name,
    required this.identitynumber,
    required this.termStart,
    required this.termEnd,
    required this.location,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      elevation: 2,
      child: InkWell(
        onTap: onTap ,
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
                    Text(name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                     style: Theme.of(context).textTheme.bodyMedium),
                    Text(
                      identitynumber,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              //term
              Column(
                spacing: 4,
                children: [
                  Text(termStart, style: Theme.of(context).textTheme.bodyMedium),
                  Text(
                    termEnd,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              //location
              Flexible(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        location[0],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    if (location.length >= 2) Text(' +${location.length-1}'),
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
