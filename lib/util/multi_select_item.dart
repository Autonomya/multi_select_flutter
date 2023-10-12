/// A model class used to represent a selectable item.
class MultiSelectItem<T> {
  final T value;
  final String label;
  final String? imageUrl;

  MultiSelectItem(
    this.value,
    this.label,
    this.imageUrl,
  );

  MultiSelectItem.fromOther(MultiSelectItem<T> other)
      : value = other.value,
        label = other.label,
        imageUrl = other.imageUrl;
}
