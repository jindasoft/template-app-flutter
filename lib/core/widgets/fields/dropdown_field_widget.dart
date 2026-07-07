import 'package:flutter/material.dart';
import 'package:template_app_flutter/configs/theme_config.dart';

class DropdownFieldWidget extends StatelessWidget {
  final String? hint;
  final IconData? icon;
  final List<String> options;
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;
  final bool hasError;

  const DropdownFieldWidget({
    super.key,
    this.hint,
    this.icon,
    required this.options,
    this.selectedValue,
    this.onChanged,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: hasError
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).dividerColor,
            ),
            borderRadius: BorderRadius.circular(ThemeConfig.spacingMD),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: ThemeConfig.spacingBase,
                  ),
                  child: Icon(
                    icon,
                    size: ThemeConfig.iconSizeBase,
                    color: ThemeConfig.colorPrimary,
                  ),
                ),
              ],
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: icon == null ? ThemeConfig.spacingBase : 0,
                    right: ThemeConfig.spacingBase,
                  ),

                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedValue,
                      hint: Text(
                        hint ?? '',
                        style: TextStyle(color: ThemeConfig.colorGreyMedium),
                      ),
                      isExpanded: true,
                      onChanged: onChanged,
                      dropdownColor: Theme.of(context).colorScheme.surface,
                      items: options.map((option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(
                            option,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
