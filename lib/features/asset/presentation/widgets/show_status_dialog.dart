import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future showStatusDialog({
  required BuildContext context,
  required void Function(String value) onSelected,
  required TextEditingController statusController,
}) async {
  return await showDialog(
    context: context,
    barrierColor: Colors.transparent,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setStateDialog) {
          return Dialog(
            backgroundColor: Colors.white,
            child: SizedBox(
              width: 300,
              height: 300,
              child: Center(
                child: Padding(
                  padding: EdgeInsetsGeometry.all(16),
                  child: Column(
                    children: [
                      //Available
                      //Tersedia
                      ListTile(
                        tileColor: Colors.green,
                        title: Text(
                          'Tersedia',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          statusController.text = 'Tersedia';
                          onSelected('Available');
                          context.pop();
                        },
                      ),

                      //In use
                      //Digunakan
                      ListTile(
                        tileColor: Colors.green[400],
                        title: Text(
                          'Digunakan',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          statusController.text = 'Digunakan';
                          onSelected('In use');
                          context.pop();
                        },
                      ),

                      //Maintenance
                      //Diperbaiki
                      ListTile(
                        tileColor: Colors.blue[400],
                        title: Text(
                          'Diperbaiki',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          statusController.text = 'Diperbaiki';
                          onSelected('Maintenance');
                          context.pop();
                        },
                      ),

                      //Damaged
                      //Rusak
                      ListTile(
                        tileColor: Colors.red[400],
                        title: Text(
                          'Rusak',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          statusController.text = 'Rusak';
                          onSelected('Damaged');
                          context.pop();
                        },
                      ),
                      //Deleted
                      //Dihapus
                      ListTile(
                        tileColor: Colors.red,
                        title: Text(
                          'Dihapus',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          statusController.text = 'Dihapus';
                          onSelected('Deleted');
                          context.pop();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
