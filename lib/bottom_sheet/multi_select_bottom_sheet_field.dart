import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import '../util/multi_select_list_type.dart';
import '../chip_display/multi_select_chip_display.dart';
import '../util/multi_select_item.dart';
import 'multi_select_bottom_sheet.dart';

/// A customizable InkWell widget that opens the MultiSelectBottomSheet
// ignore: must_be_immutable
class MultiSelectBottomSheetField<V> extends FormField<List<V>> {
  /// Style the Container that makes up the field.
  final BoxDecoration? decoration;

  /// Set text that is displayed on the button.
  final Text? buttonText;

  /// Specify the button icon.
  final Icon? buttonIcon;

  /// List of items to select from.
  final List<MultiSelectItem<V>> items;

  /// The list of selected values before interaction.
  final List<V> initialValue;

  /// The text at the top of the dialog.
  final Widget? title;

  /// Fires when the an item is selected / unselected.
  final void Function(List<V>)? onSelectionChanged;

  /// Fires when confirm is tapped.
  final void Function(List<V>)? onConfirm;

  /// Toggles search functionality.
  final bool searchable;

  /// Text on the confirm button.
  final Text? confirmText;

  /// Text on the cancel button.
  final Text? cancelText;

  /// An enum that determines which type of list to render.
  final MultiSelectListType? listType;

  /// Sets the color of the checkbox or chip body when selected.
  final Color? selectedColor;

  /// Set the hint text of the search field.
  final String? searchHint;

  /// Set the initial height of the BottomSheet.
  final double? initialChildSize;

  /// Set the minimum height threshold of the BottomSheet before it closes.
  final double? minChildSize;

  /// Set the maximum height of the BottomSheet.
  final double? maxChildSize;

  /// Apply a ShapeBorder to alter the edges of the BottomSheet.
  final ShapeBorder? shape;

  /// Set the color of the space outside the BottomSheet.
  final Color? barrierColor;

  /// Overrides the default MultiSelectChipDisplay attached to this field.
  /// If you want to remove it, use MultiSelectChipDisplay.none().
  final MultiSelectChipDisplay<V>? chipDisplay;

  /// A function that sets the color of selected items based on their value.
  /// It will either set the chip color, or the checkbox color depending on the list type.
  final Color Function(V)? colorator;

  /// Set the background color of the bottom sheet.
  final Color? backgroundColor;

  /// Color of the chip body or checkbox border while not selected.
  final Color? unselectedColor;

  /// Replaces the deafult search icon when searchable is true.
  final Icon? searchIcon;

  /// Replaces the default close search icon when searchable is true.
  final Icon? closeSearchIcon;

  /// The TextStyle of the items within the BottomSheet.
  final TextStyle? itemsTextStyle;

  /// Style the text on the selected chips or list tiles.
  final TextStyle? selectedItemsTextStyle;

  /// Moves the selected items to the top of the list.
  final bool separateSelectedItems;

  /// Style the text that is typed into the search field.
  final TextStyle? searchTextStyle;

  /// Style the search hint.
  final TextStyle? searchHintStyle;

  /// Set the color of the check in the checkbox
  final Color? checkColor;

  /// Whether the user can dismiss the widget by tapping outside
  final bool isDismissible;

  /// Whether the MultiSelect is an item image or not.
  final bool isItemImage;

  final AutovalidateMode autoValidateMode;
  final FormFieldValidator<List<V>>? validator;
  final FormFieldSetter<List<V>>? onSaved;
  final GlobalKey<FormFieldState>? key;
  FormFieldState<List<V>>? state;

  MultiSelectBottomSheetField({
    required this.items,
    this.onConfirm,
    this.title,
    this.buttonText,
    this.buttonIcon,
    this.listType,
    this.decoration,
    this.onSelectionChanged,
    this.chipDisplay,
    this.initialValue = const [],
    this.searchable = false,
    this.confirmText,
    this.cancelText,
    this.selectedColor,
    this.initialChildSize,
    this.minChildSize,
    this.maxChildSize,
    this.shape,
    this.barrierColor,
    this.searchHint,
    this.colorator,
    this.backgroundColor,
    this.unselectedColor,
    this.searchIcon,
    this.closeSearchIcon,
    this.itemsTextStyle,
    this.searchTextStyle,
    this.searchHintStyle,
    this.selectedItemsTextStyle,
    this.separateSelectedItems = false,
    this.checkColor,
    this.isDismissible = true,
    this.key,
    this.onSaved,
    this.validator,
    this.isItemImage = false,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: autoValidateMode,
          initialValue: initialValue,
          builder: (FormFieldState<List<V>> state) {
            return _MultiSelectBottomSheetFieldView<V>(
              items: items,
              decoration: decoration,
              unselectedColor: unselectedColor,
              colorator: colorator,
              itemsTextStyle: itemsTextStyle,
              selectedItemsTextStyle: selectedItemsTextStyle,
              backgroundColor: backgroundColor,
              title: title,
              initialValue: initialValue,
              barrierColor: barrierColor,
              buttonIcon: buttonIcon,
              buttonText: buttonText,
              cancelText: cancelText,
              chipDisplay: chipDisplay,
              closeSearchIcon: closeSearchIcon,
              confirmText: confirmText,
              initialChildSize: initialChildSize,
              listType: listType,
              maxChildSize: maxChildSize,
              minChildSize: minChildSize,
              onConfirm: onConfirm,
              onSelectionChanged: onSelectionChanged,
              searchHintStyle: searchHintStyle,
              searchIcon: searchIcon,
              searchHint: searchHint,
              searchTextStyle: searchTextStyle,
              searchable: searchable,
              selectedColor: selectedColor,
              separateSelectedItems: separateSelectedItems,
              shape: shape,
              checkColor: checkColor,
              state: state,
              isDismissible: isDismissible,
              isItemImage: isItemImage,
            );
          },
        );
}

class _MultiSelectBottomSheetFieldView<V> extends StatefulWidget {
  final BoxDecoration? decoration;
  final Text? buttonText;
  final Icon? buttonIcon;
  final List<MultiSelectItem<V>> items;
  final List<V> initialValue;
  final Widget? title;
  final void Function(List<V>)? onSelectionChanged;
  final void Function(List<V>)? onConfirm;
  final bool searchable;
  final Text? confirmText;
  final Text? cancelText;
  final MultiSelectListType? listType;
  final Color? selectedColor;
  final String? searchHint;
  final double? initialChildSize;
  final double? minChildSize;
  final double? maxChildSize;
  final ShapeBorder? shape;
  final Color? barrierColor;
  final MultiSelectChipDisplay<V>? chipDisplay;
  final Color Function(V)? colorator;
  final Color? backgroundColor;
  final Color? unselectedColor;
  final Icon? searchIcon;
  final Icon? closeSearchIcon;
  final TextStyle? itemsTextStyle;
  final TextStyle? selectedItemsTextStyle;
  final TextStyle? searchTextStyle;
  final TextStyle? searchHintStyle;
  final bool separateSelectedItems;
  final Color? checkColor;
  final bool isDismissible;
  final FormFieldState<List<V>> state;
  final bool isItemImage;

  _MultiSelectBottomSheetFieldView({
    required this.items,
    required this.state,
    this.title,
    this.buttonText,
    this.buttonIcon,
    this.listType,
    this.decoration,
    this.onSelectionChanged,
    this.onConfirm,
    this.chipDisplay,
    required this.initialValue,
    required this.searchable,
    this.confirmText,
    this.cancelText,
    this.selectedColor,
    this.initialChildSize,
    this.minChildSize,
    this.maxChildSize,
    this.shape,
    this.barrierColor,
    this.searchHint,
    this.colorator,
    this.backgroundColor,
    this.unselectedColor,
    this.searchIcon,
    this.closeSearchIcon,
    this.itemsTextStyle,
    this.searchTextStyle,
    this.searchHintStyle,
    this.selectedItemsTextStyle,
    required this.separateSelectedItems,
    this.checkColor,
    required this.isDismissible,
    this.isItemImage = false,
  });

  @override
  __MultiSelectBottomSheetFieldViewState createState() =>
      __MultiSelectBottomSheetFieldViewState<V>();
}

class __MultiSelectBottomSheetFieldViewState<V>
    extends State<_MultiSelectBottomSheetFieldView<V>> {
  Widget _buildInheritedChipDisplay() {
    List<MultiSelectItem<V>?> chipDisplayItems = [];
    chipDisplayItems = widget.state.value!
        .map((e) =>
            widget.items.firstWhereOrNull((element) => e == element.value))
        .toList();
    chipDisplayItems.removeWhere((element) => element == null);
    if (widget.chipDisplay != null) {
      // if user has specified a chipDisplay, use its params
      if (widget.chipDisplay!.disabled!) {
        return Container();
      } else {
        return Padding(
          padding: EdgeInsets.only(bottom: chipDisplayItems.isNotEmpty ? 8 : 0),
          child: MultiSelectChipDisplay<V>(
            items: chipDisplayItems,
            colorator: widget.chipDisplay!.colorator ?? widget.colorator,
            onTap: (item) {
              /*
              List<V> newValues = List.from(widget.state.value!);
              newValues.remove(item);
              widget.state.didChange(newValues);
              if (widget.chipDisplay!.onTap != null) {
                widget.chipDisplay!.onTap!(item);
              }
              */
            },
            decoration: widget.chipDisplay!.decoration,
            chipColor: widget.chipDisplay!.chipColor ??
                ((widget.selectedColor != null &&
                        widget.selectedColor != Colors.transparent)
                    ? widget.selectedColor!.withOpacity(0.35)
                    : null),
            alignment: widget.chipDisplay!.alignment,
            textStyle: widget.chipDisplay!.textStyle,
            icon: widget.chipDisplay!.icon,
            shape: widget.chipDisplay!.shape,
            scroll: widget.chipDisplay!.scroll,
            scrollBar: widget.chipDisplay!.scrollBar,
            height: widget.chipDisplay!.height,
            chipWidth: widget.chipDisplay!.chipWidth,
            isItemImage: widget.isItemImage,
          ),
        );
      }
    } else {
      // user didn't specify a chipDisplay, build the default
      return MultiSelectChipDisplay<V>(
        items: chipDisplayItems,
        colorator: widget.colorator,
        chipColor: (widget.selectedColor != null &&
                widget.selectedColor != Colors.transparent)
            ? widget.selectedColor!.withOpacity(0.35)
            : null,
        onTap: (item) {
          List<V> newValues = List.from(widget.state.value!);
          newValues.remove(item);
          widget.state.didChange(newValues);
        },
        isItemImage: widget.isItemImage,
      );
    }
  }

  _showBottomSheet(BuildContext ctx) async {
    await showModalBottomSheet<List<V>>(
        isDismissible: widget.isDismissible,
        backgroundColor: widget.backgroundColor,
        barrierColor: widget.barrierColor,
        shape: widget.shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
            ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return MultiSelectBottomSheet<V>(
            checkColor: widget.checkColor,
            selectedItemsTextStyle: widget.selectedItemsTextStyle,
            searchTextStyle: widget.searchTextStyle,
            searchHintStyle: widget.searchHintStyle,
            itemsTextStyle: widget.itemsTextStyle,
            searchIcon: widget.searchIcon,
            closeSearchIcon: widget.closeSearchIcon,
            unselectedColor: widget.unselectedColor,
            colorator: widget.colorator,
            searchHint: widget.searchHint,
            selectedColor: widget.selectedColor,
            listType: widget.listType,
            items: widget.items,
            cancelText: widget.cancelText,
            confirmText: widget.confirmText,
            separateSelectedItems: widget.separateSelectedItems,
            initialValue: List<V>.from(widget.state.value!),
            onConfirm: (selected) {
              widget.state.didChange(selected);
              if (widget.onConfirm != null) {
                widget.onConfirm!(selected);
              }
            },
            onSelectionChanged: widget.onSelectionChanged,
            searchable: widget.searchable,
            title: widget.title,
            initialChildSize: widget.initialChildSize,
            minChildSize: widget.minChildSize,
            maxChildSize: widget.maxChildSize,
            isItemImage: widget.isItemImage,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () {
            _showBottomSheet(context);
          },
          child: Container(
            decoration: widget.decoration ??
                BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: widget.state.hasError
                          ? Colors.red.shade800.withOpacity(0.6)
                          : widget.state.value!.isNotEmpty
                              ? (widget.selectedColor != null &&
                                      widget.selectedColor !=
                                          Colors.transparent)
                                  ? widget.selectedColor!
                                  : Theme.of(context).primaryColor
                              : Colors.black45,
                      width: widget.state.value!.isNotEmpty
                          ? (widget.state.hasError)
                              ? 1.4
                              : 1.8
                          : 1.2,
                    ),
                  ),
                ),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(child: widget.buttonText ?? Text("Select")),
                widget.buttonIcon ?? Icon(Icons.arrow_downward),
              ],
            ),
          ),
        ),
        _buildInheritedChipDisplay(),
        widget.state.hasError ? SizedBox(height: 5) : Container(),
        widget.state.hasError ? SizedBox(height: 5) : Container(),
        widget.state.hasError
            ? Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      widget.state.errorText!,
                      style: TextStyle(
                        color: Colors.red[800],
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}
