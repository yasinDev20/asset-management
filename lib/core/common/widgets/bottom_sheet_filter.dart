import 'package:computer_lab_inventory_application/core/common/widgets/button.dart';
import 'package:flutter/material.dart';

class BottomSheetFilter extends StatefulWidget {
  final List<String> listOfChoice;
  final List<String> initialSelected; // Tambahan parameter

  const BottomSheetFilter({
    super.key,
    required this.listOfChoice,
    required this.initialSelected,
  });

  @override
  State<BottomSheetFilter> createState() => _BottomSheetFilterState();
}

class _BottomSheetFilterState extends State<BottomSheetFilter> {
  TextEditingController searchText = TextEditingController();
  bool isSelected = false;
  List<String> selectedLocation = [];
  List<String> filteredChoices = [];

 @override
void initState() {
  super.initState();
  filteredChoices = widget.listOfChoice;
  selectedLocation = List.from(widget.initialSelected); // ← penting
}


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Stack(
        children: [
          //List of choice
          Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Search
              TextField(
                controller: searchText,
                onChanged: (value) {
                  setState(() {
                    filteredChoices = widget.listOfChoice
                        .where(
                          (item) =>
                              item.toLowerCase().contains(value.toLowerCase()),
                        )
                        .toList();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Cari',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.cancel_outlined),
                    onPressed: () {
                      searchText.clear();
                      setState(() {
                        //mengembalikan pilihan ke awal 
                        filteredChoices = widget.listOfChoice;
                      });
                    },
                  ),
                ),
              ),

              ...filteredChoices.map((choice) {
                final isSelected = selectedLocation.contains(choice);
                return FilterChip(
                  label: Text(choice),

                  selected: isSelected,
                  onSelected: (value) {
                    setState(() {
                      if (value) {
                        selectedLocation.add(choice);
                      } else {
                        selectedLocation.remove(choice);
                      }
                    });
                  },
                );
              }),
            ],
          ),
          //Save
          Align(
            alignment: Alignment.bottomCenter,
            child: CommonButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  selectedLocation,
                ); // kirim data ke parent
              },
              text: 'Simpan',
            ),
          ),
        ],
      ),
    );
  }
}
