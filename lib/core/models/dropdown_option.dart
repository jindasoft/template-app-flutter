class DropdownOption {
  final String value;
  final String label;

  const DropdownOption({required this.value, required this.label});

  factory DropdownOption.fromData({
    required String value,
    required String label,
  }) {
    return DropdownOption(value: value, label: label);
  }

  @override
  String toString() => 'DropdownOption(value: $value, label: $label)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DropdownOption &&
        other.value == value &&
        other.label == label;
  }

  @override
  int get hashCode => value.hashCode ^ label.hashCode;
}
