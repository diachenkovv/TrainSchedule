import 'package:flutter/material.dart';

class MultiSelectTrainTypeField extends StatelessWidget {
  final List<String> selectedTypes;
  final ValueChanged<List<String>> onChanged;
  final String labelText;
  final IconData? prefixIcon;

  static const List<String> allTrainTypes = [
    'Усі',
    'Швидкий',
    'Пасажирський',
    'Експрес',
    'Інтерсіті',
    'Інтерсіті+',
    'Приміські',
    'Регіональні',
  ];

  const MultiSelectTrainTypeField({
    super.key,
    required this.selectedTypes,
    required this.onChanged,
    required this.labelText,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showMultiSelectDialog(context),
      borderRadius: BorderRadius.circular(8),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          suffixIcon: const Icon(Icons.arrow_drop_down),
        ),
        child: Text(
          _getDisplayText(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }

  String _getDisplayText() {
    if (selectedTypes.isEmpty || selectedTypes.contains('Усі')) {
      return 'Усі';
    }
    if (selectedTypes.length == 1) {
      return selectedTypes.first;
    }
    return '${selectedTypes.length} типів обрано';
  }

  void _showMultiSelectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          title: 'Оберіть типи поїздів',
          items: allTrainTypes,
          selectedItems: selectedTypes,
          onSelectionChanged: onChanged,
        );
      },
    );
  }
}

class MultiSelectDialog extends StatefulWidget {
  final String title;
  final List<String> items;
  final List<String> selectedItems;
  final ValueChanged<List<String>> onSelectionChanged;

  const MultiSelectDialog({
    super.key,
    required this.title,
    required this.items,
    required this.selectedItems,
    required this.onSelectionChanged,
  });

  @override
  State<MultiSelectDialog> createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  late List<String> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = List.from(widget.selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            final item = widget.items[index];
            final isSelected = _selectedItems.contains(item);
            final isAll = item == 'Усі';

            return CheckboxListTile(
              title: Text(item),
              value: isAll ? _selectedItems.isEmpty || _selectedItems.contains('Усі') : isSelected,
              onChanged: (bool? value) {
                setState(() {
                  if (isAll) {
                    if (value == true) {
                      _selectedItems.clear();
                      _selectedItems.add('Усі');
                    } else {
                      _selectedItems.remove('Усі');
                    }
                  } else {
                    if (value == true) {
                      _selectedItems.remove('Усі');
                      _selectedItems.add(item);
                    } else {
                      _selectedItems.remove(item);
                    }
                    
                    // Якщо нічого не вибрано, автоматично вибираємо "Усі"
                    if (_selectedItems.isEmpty) {
                      _selectedItems.add('Усі');
                    }
                  }
                });
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Скасувати'),
        ),
        FilledButton(
          onPressed: () {
            widget.onSelectionChanged(_selectedItems);
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
