import 'package:flutter/material.dart';
import 'package:trainshedule/generated/l10n.dart';

class MultiSelectTrainTypeField extends StatelessWidget {
  final List<String> selectedTypes;
  final ValueChanged<List<String>> onChanged;
  final String labelText;
  final IconData? prefixIcon;

  // Використовуємо ключі для типів поїздів
  static const List<String> allTrainTypeKeys = [
    'train_type_all',
    'train_type_fast',
    'train_type_passenger',
    'train_type_express',
    'train_type_intercity',
    'train_type_intercity_plus',
    'train_type_suburban',
    'train_type_regional',
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
          fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(128),
          suffixIcon: const Icon(Icons.arrow_drop_down),
        ),
        child: Text(
          _getDisplayText(context),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }

  // Повертає локалізовану назву типу поїзда за ключем
  String _getTrainTypeName(BuildContext context, String key) {
    final s = S.of(context);
    switch (key) {
      case 'train_type_all':
        return s.train_type_all;
      case 'train_type_fast':
        return s.train_type_fast;
      case 'train_type_passenger':
        return s.train_type_passenger;
      case 'train_type_express':
        return s.train_type_express;
      case 'train_type_intercity':
        return s.train_type_intercity;
      case 'train_type_intercity_plus':
        return s.train_type_intercity_plus;
      case 'train_type_suburban':
        return s.train_type_suburban;
      case 'train_type_regional':
        return s.train_type_regional;
      default:
        return key;
    }
  }

  String _getDisplayText(BuildContext context) {
    if (selectedTypes.isEmpty || selectedTypes.contains('train_type_all')) {
      return _getTrainTypeName(context, 'train_type_all');
    }
    if (selectedTypes.length == 1) {
      return _getTrainTypeName(context, selectedTypes.first);
    }
    return '${selectedTypes.length} ${S.of(context).train_type}';
  }

  void _showMultiSelectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          title: S.of(context).train_type,
          items: allTrainTypeKeys,
          selectedItems: selectedTypes,
          onSelectionChanged: onChanged,
          getTrainTypeName: (key) => _getTrainTypeName(context, key),
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
  final String Function(String) getTrainTypeName;

  const MultiSelectDialog({
    super.key,
    required this.title,
    required this.items,
    required this.selectedItems,
    required this.onSelectionChanged,
    required this.getTrainTypeName,
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
            final key = widget.items[index];
            final isSelected = _selectedItems.contains(key);
            final isAll = key == 'train_type_all';

            return CheckboxListTile(
              title: Text(widget.getTrainTypeName(key)),
              value: isAll ? _selectedItems.isEmpty || _selectedItems.contains('train_type_all') : isSelected,
              onChanged: (bool? value) {
                setState(() {
                  if (isAll) {
                    if (value == true) {
                      _selectedItems.clear();
                      _selectedItems.add('train_type_all');
                    } else {
                      _selectedItems.remove('train_type_all');
                    }
                  } else {
                    if (value == true) {
                      _selectedItems.remove('train_type_all');
                      _selectedItems.add(key);
                    } else {
                      _selectedItems.remove(key);
                    }
                    if (_selectedItems.isEmpty) {
                      _selectedItems.add('train_type_all');
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
          child: Text(S.of(context).cancel),
        ),
        FilledButton(
          onPressed: () {
            widget.onSelectionChanged(_selectedItems);
            Navigator.of(context).pop();
          },
          child: Text('OK'), // Можна додати ключ для "OK" у локалізацію
        ),
      ],
    );
  }
}
