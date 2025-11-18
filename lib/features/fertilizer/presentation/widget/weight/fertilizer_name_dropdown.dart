import 'package:akurasipupuk/features/fertilizer/data/datasource_global/master_fertilizer_model.dart';
import 'package:akurasipupuk/features/fertilizer/presentation/model/weight/fertilizer_weight_input.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';


class FertilizerNameDropdown extends StatefulWidget {
  final List<MasterFertilizerModel> masterFertilizers;
  final void Function(MasterFertilizerModel?) onChanged;
  final FertilizerDropdownController? controller;

  const FertilizerNameDropdown({
    super.key,
    required this.masterFertilizers,
    required this.onChanged,
    this.controller
  });

  @override
  State<FertilizerNameDropdown> createState() => _FertilizerNameDropdownState();
}

class _FertilizerNameDropdownState extends State<FertilizerNameDropdown> {
  MasterFertilizerModel? _masterFertilizerSelected;

  final FocusNode _searchFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.controller != null){
      widget.controller!.reset = () {
        setState(() {
          _masterFertilizerSelected = null;
        });
        widget.onChanged(null);
      } ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<MasterFertilizerModel>(
      compareFn: (a, b) => a.name == b.name,
      items: (filter, loadProps) {
        // filter pencarian opsional
        if (filter.isEmpty) return widget.masterFertilizers;
        return widget.masterFertilizers
            .where((f) => f.name.toLowerCase().contains(filter.toLowerCase()))
            .toList();
      },

      selectedItem: _masterFertilizerSelected,
      itemAsString: (item) => item.name, // hanya tampilkan nama pupuk

      popupProps: PopupProps.menu(
        onItemsLoaded: (value) {
          Future.delayed(const Duration(milliseconds: 150), () {
            _searchFocus.requestFocus();
          });
        },
        showSearchBox: true, // aktifkan input pencarian
        itemBuilder: (context, item, isDisabled, isSelected) => ListTile(
          title: Text(item.name),
        ),
        searchFieldProps: TextFieldProps(
          focusNode: _searchFocus,
          decoration: InputDecoration(
            labelText: 'Cari pupuk...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),

      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          labelText: 'Pilih Pupuk',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),

      onChanged: (value) {
        if (value != null) {
          debugPrint("VALUE AFTER SELECT => ${value.name}");
          if (value.nutrientContents.isNotEmpty) {
            debugPrint(
              "Nutrient by fertilizer name ${value.nutrientContents[0].nutrientName} => ${value.nutrientContents[0].valueInPercent}",
            );
          }
        }
        setState(() => _masterFertilizerSelected = value);
        widget.onChanged(value);
      },
    );
  }
}
