import 'package:flutter/material.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/models/dropdown_option.dart';
import 'package:line_icons/line_icons.dart';

class BottomSheetFieldWidget extends StatelessWidget {
  final String hint;
  final String sheetTitle;
  final IconData icon;
  final List<DropdownOption> options;
  final DropdownOption? selectedOption;
  final bool hasError;
  final ValueChanged<String> onChanged;

  const BottomSheetFieldWidget({
    super.key,
    required this.hint,
    required this.sheetTitle,
    required this.icon,
    required this.options,
    required this.selectedOption,
    required this.onChanged,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    DropdownOption? selected = selectedOption;
    for (final option in options) {
      if (option.value == selectedOption?.value) {
        selected = option;
        break;
      }
    }
    final hasSelection = selected != null;
    final displayText = hasSelection ? selected.label : hint;

    return Material(
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: hasError
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).dividerColor,
        ),
        borderRadius: BorderRadius.circular(ThemeConfig.spacingMD),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(ThemeConfig.spacingMD),
        onTap: () => _openSheet(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: ThemeConfig.spacingMD,
            vertical: ThemeConfig.spacingSM,
          ),
          child: Row(
            children: [
              Icon(icon, color: ThemeConfig.colorPrimary),
              const SizedBox(width: ThemeConfig.spacingSM),
              Expanded(
                child: Text(
                  displayText,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: hasSelection
                        ? Theme.of(context).colorScheme.onSurface
                        : ThemeConfig.colorGreyMedium,
                  ),
                ),
              ),
              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openSheet(BuildContext context) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.sizeOf(sheetContext).height * 0.55,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(ThemeConfig.spacingBase),
                  child: Text(
                    sheetTitle,
                    style: Theme.of(sheetContext).textTheme.titleLarge,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      final option = options[index];
                      final isSelected = option.value == selectedOption?.value;
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: ThemeConfig.spacingBase,
                        ),
                        leading: Icon(
                          isSelected ? LineIcons.checkCircle : LineIcons.circle,
                          color: isSelected ? ThemeConfig.colorPrimary : null,
                        ),
                        title: Text(option.label),
                        onTap: () => Navigator.pop(sheetContext, option.value),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (!context.mounted || selected == null) return;
    onChanged(selected);
  }
}
