import 'package:flutter/material.dart';

class StationAutocompleteField extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;
  final String labelText;
  final IconData? prefixIcon;
  final List<String> stations;

  const StationAutocompleteField({
    super.key,
    required this.value,
    required this.onChanged,
    required this.labelText,
    required this.stations,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      initialValue: value != null ? TextEditingValue(text: value!) : null,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        
        final query = textEditingValue.text.toLowerCase();
        return stations.where((String option) {
          return option.toLowerCase().contains(query);
        });
      },
      onSelected: (String selection) {
        onChanged(selection);
      },
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController textEditingController,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted,
      ) {
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          ),
          onChanged: (value) {
            // Якщо введене значення точно відповідає одній зі станцій, вибираємо її
            final exactMatch = stations.firstWhere(
              (station) => station.toLowerCase() == value.toLowerCase(),
              orElse: () => '',
            );
            if (exactMatch.isNotEmpty) {
              onChanged(exactMatch);
            } else {
              onChanged(null);
            }
          },
          onSubmitted: (value) => onFieldSubmitted(),
        );
      },
      optionsViewBuilder: (
        BuildContext context,
        AutocompleteOnSelected<String> onSelected,
        Iterable<String> options,
      ) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 200),
              width: MediaQuery.of(context).size.width - 32,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final String option = options.elementAt(index);
                  return ListTile(
                    title: Text(option),
                    onTap: () {
                      onSelected(option);
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
