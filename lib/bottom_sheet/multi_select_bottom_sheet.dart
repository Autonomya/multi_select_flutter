import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../util/multi_select_item.dart';
import '../util/multi_select_actions.dart';
import '../util/multi_select_list_type.dart';

/// A bottom sheet widget containing either a classic checkbox style list, or a chip style list.
class MultiSelectBottomSheet<T> extends StatefulWidget
    with MultiSelectActions<T> {
  /// List of items to select from.
  final List<MultiSelectItem<T>> items;

  /// The list of selected values before interaction.
  final List<T> initialValue;

  /// The text at the top of the BottomSheet.
  final Widget? title;

  /// Fires when the an item is selected / unselected.
  final void Function(List<T>)? onSelectionChanged;

  /// Fires when confirm is tapped.
  final void Function(List<T>)? onConfirm;

  /// Toggles search functionality.
  final bool searchable;

  /// Text on the confirm button.
  final Text? confirmText;

  /// Text on the cancel button.
  final Text? cancelText;

  /// An enum that determines which type of list to render.
  final MultiSelectListType? listType;

  /// Sets the color of the checkbox or chip when it's selected.
  final Color? selectedColor;

  /// Set the initial height of the BottomSheet.
  final double? initialChildSize;

  /// Set the minimum height threshold of the BottomSheet before it closes.
  final double? minChildSize;

  /// Set the maximum height of the BottomSheet.
  final double? maxChildSize;

  /// Set the placeholder text of the search field.
  final String? searchHint;

  /// A function that sets the color of selected items based on their value.
  /// It will either set the chip color, or the checkbox color depending on the list type.
  final Color? Function(T)? colorator;

  /// Color of the chip body or checkbox border while not selected.
  final Color? unselectedColor;

  /// Icon button that shows the search field.
  final Icon? searchIcon;

  /// Icon button that hides the search field
  final Icon? closeSearchIcon;

  /// Style the text on the chips or list tiles.
  final TextStyle? itemsTextStyle;

  /// Style the text on the selected chips or list tiles.
  final TextStyle? selectedItemsTextStyle;

  /// Style the search text.
  final TextStyle? searchTextStyle;

  /// Style the search hint.
  final TextStyle? searchHintStyle;

  /// Moves the selected items to the top of the list.
  final bool separateSelectedItems;

  /// Set the color of the check in the checkbox
  final Color? checkColor;

  /// Has image
  final bool isItemImage;

  MultiSelectBottomSheet({
    required this.items,
    this.initialValue = const [],
    this.title,
    this.onSelectionChanged,
    this.onConfirm,
    this.listType,
    this.cancelText,
    this.confirmText,
    this.searchable = false,
    this.selectedColor,
    this.initialChildSize,
    this.minChildSize,
    this.maxChildSize,
    this.colorator,
    this.unselectedColor,
    this.searchIcon,
    this.closeSearchIcon,
    this.itemsTextStyle,
    this.searchTextStyle,
    this.searchHint,
    this.searchHintStyle,
    this.selectedItemsTextStyle,
    this.separateSelectedItems = false,
    this.checkColor,
    this.isItemImage = false,
  });

  @override
  _MultiSelectBottomSheetState<T> createState() =>
      _MultiSelectBottomSheetState<T>();
}

class _MultiSelectBottomSheetState<T> extends State<MultiSelectBottomSheet<T>> {
  late List<T> _selectedValues = widget.initialValue;
  late List<MultiSelectItem<T>> _items = widget.items;
  bool _showSearch = false;

  /// Returns a CheckboxListTile
  Widget _buildListItem(MultiSelectItem<T> item) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: widget.unselectedColor ?? Colors.black54,
      ),
      child: CheckboxListTile(
        checkColor: widget.checkColor,
        value: _selectedValues.contains(item.value),
        activeColor: widget.colorator != null
            ? widget.colorator!(item.value) ?? widget.selectedColor
            : widget.selectedColor,
        title: Text(
          item.label,
          style: _selectedValues.contains(item.value)
              ? widget.selectedItemsTextStyle
              : widget.itemsTextStyle,
        ),
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (checked) {
          setState(() {
            if (checked!) {
              _selectedValues.add(item.value);
            } else {
              _selectedValues.remove(item.value);
            }
          });
          if (widget.onSelectionChanged != null) {
            widget.onSelectionChanged!(_selectedValues);
          }
        },
      ),
    );
  }

  /// Returns a ChoiceChip
  Widget _buildChipItem(MultiSelectItem<T> item) {
    final hasImageUrl = item.imageUrl != null && item.imageUrl!.isNotEmpty;
    final isItemSelected = _selectedValues.contains(item.value);

    return Padding(
      padding: const EdgeInsets.all(2),
      child: hasImageUrl
          ? GestureDetector(
              onTap: () {
                setState(() {
                  if (isItemSelected) {
                    _selectedValues.remove(item.value);
                  } else {
                    _selectedValues.add(item.value);
                  }
                });
                if (widget.onSelectionChanged != null) {
                  widget.onSelectionChanged!(_selectedValues);
                }
              },
              child: CircleAvatar(
                radius: 38,
                backgroundColor:
                    isItemSelected ? widget.selectedColor : Colors.transparent,
                child: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 230, 231, 245),
                  radius: 35,
                  child: CachedNetworkImage(
                    imageUrl: item.imageUrl!,
                    height: 60,
                    width: 60,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            )
          : ChoiceChip(
              backgroundColor: widget.unselectedColor,
              selectedColor: widget.colorator != null &&
                      widget.colorator!(item.value) != null
                  ? widget.colorator!(item.value)
                  : widget.selectedColor != null
                      ? widget.selectedColor
                      : Theme.of(context).primaryColor.withOpacity(0.35),
              label: Text(
                item.label,
                style: _selectedValues.contains(item.value)
                    ? TextStyle(
                        color: widget.selectedItemsTextStyle?.color ??
                            widget.colorator?.call(item.value) ??
                            widget.selectedColor?.withOpacity(1) ??
                            Theme.of(context).primaryColor,
                        fontSize: widget.selectedItemsTextStyle != null
                            ? widget.selectedItemsTextStyle!.fontSize
                            : null,
                      )
                    : widget.itemsTextStyle,
              ),
              selected: isItemSelected,
              onSelected: (checked) {
                setState(() {
                  if (checked) {
                    _selectedValues.add(item.value);
                  } else {
                    _selectedValues.remove(item.value);
                  }
                });
                if (widget.onSelectionChanged != null) {
                  widget.onSelectionChanged!(_selectedValues);
                }
              },
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.separateSelectedItems) {
      _items.sort((a, b) => (_selectedValues.contains(b.value) ? 1 : -1)
          .compareTo(_selectedValues.contains(a.value) ? 1 : -1));
    }

    MediaQueryData mData = MediaQuery.of(context);

    return Container(
      padding: EdgeInsets.only(
          bottom: mData.viewInsets.bottom + (mData.viewPadding.bottom * 0.3)),
      child: DraggableScrollableSheet(
        initialChildSize: widget.initialChildSize ?? 0.5,
        minChildSize: widget.minChildSize ?? 0.3,
        maxChildSize: widget.maxChildSize ?? 0.6,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _showSearch
                        ? Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextField(
                                autofocus: true,
                                style: widget.searchTextStyle,
                                decoration: InputDecoration(
                                  hintStyle: widget.searchHintStyle,
                                  hintText: widget.searchHint ?? "Search",
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: widget.selectedColor ??
                                            Theme.of(context).primaryColor),
                                  ),
                                ),
                                onChanged: (val) {
                                  List<MultiSelectItem<T>> filteredList = [];
                                  filteredList = widget.updateSearchQuery(
                                      val, widget.items);
                                  setState(() {
                                    _items = List.generate(
                                        filteredList.length,
                                        (index) => MultiSelectItem<T>.fromOther(
                                            filteredList[index]));
                                  });
                                },
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: widget.title ??
                                Text(
                                  "Select",
                                  style: TextStyle(fontSize: 18),
                                ),
                          ),
                    widget.searchable
                        ? IconButton(
                            icon: _showSearch
                                ? widget.closeSearchIcon ?? Icon(Icons.close)
                                : widget.searchIcon ?? Icon(Icons.search),
                            onPressed: () {
                              setState(() {
                                _showSearch = !_showSearch;
                                if (!_showSearch) {
                                  _items = widget.items;
                                }
                              });
                            },
                          )
                        : Padding(
                            padding: EdgeInsets.all(15),
                          ),
                  ],
                ),
              ),
              Expanded(
                child: widget.listType == null ||
                        widget.listType == MultiSelectListType.LIST
                    ? ListView.builder(
                        controller: scrollController,
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          return _buildListItem(_items[index]);
                        },
                      )
                    : SingleChildScrollView(
                        controller: scrollController,
                        child: Container(
                          width: double.infinity,
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                          child: Wrap(
                            alignment: widget.isItemImage
                                ? WrapAlignment.center
                                : WrapAlignment.start,
                            spacing: widget.isItemImage ? 5.0 : 0,
                            runSpacing: widget.isItemImage ? 5.0 : 0,
                            children: _items.map(_buildChipItem).toList(),
                          ),
                        ),
                      ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: widget.cancelText ??
                            Text(
                              "CANCEL",
                              style: TextStyle(
                                color: (widget.selectedColor != null &&
                                        widget.selectedColor !=
                                            Colors.transparent)
                                    ? widget.selectedColor!.withOpacity(1)
                                    : Theme.of(context).primaryColor,
                              ),
                            ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          if (widget.onConfirm != null) {
                            widget.onConfirm!(_selectedValues);
                          }
                        },
                        child: widget.confirmText ??
                            Text(
                              "OK",
                              style: TextStyle(
                                color: (widget.selectedColor != null &&
                                        widget.selectedColor !=
                                            Colors.transparent)
                                    ? widget.selectedColor!.withOpacity(1)
                                    : Theme.of(context).primaryColor,
                              ),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
