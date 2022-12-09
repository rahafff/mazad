import 'package:animated_search_bar/debouncer.dart';
import 'package:elite_auction/core/widgets/constant_box_decorations_and_shadows.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/resources/app_validation_functions.dart';

class CustomAnimatedSearchBar extends StatefulWidget {
  const CustomAnimatedSearchBar({
    Key? key,
    this.alignment = TextAlign.start,
    this.animationDuration = 350,
    this.duration = const Duration(milliseconds: 300),
    this.height,
    this.closeIcon = const Icon(Icons.close, key: ValueKey("close")),
    this.searchIcon = const Icon(Icons.search, key: ValueKey("search")),
    required this.controller,
    required this.onFieldSubmitted,
    required this.onEditingComplete,
    required this.searchFieldKey,
    required this.appBarTitle,
  }) : super(key: key);

  final int animationDuration;
  final TextAlign alignment;
  final Duration duration;
  final double? height;
  final Widget closeIcon;
  final Widget searchIcon;
  final TextEditingController? controller;
  final void Function(String)? onFieldSubmitted;
  final VoidCallback? onEditingComplete;
  final GlobalKey<FormState> searchFieldKey;
  final String appBarTitle;
  @override
  _CustomAnimatedSearchBarState createState() =>
      _CustomAnimatedSearchBarState();
}

class _CustomAnimatedSearchBarState extends State<CustomAnimatedSearchBar> {
  bool _isSearch = false;
  final _fnSearch = FocusNode();
  final _debouncer = Debouncer();
  late TextEditingController _conSearch;

  @override
  void initState() {
    super.initState();
    _conSearch = widget.controller ?? TextEditingController();
    _isSearch = _conSearch.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    _debouncer.duration = widget.duration;

    // Use row as Root view
    return SizedBox(
      width: _isSearch ? 80.w : 100.w,
      child: Stack(alignment: Alignment.center, children: [
        !_isSearch
            ? Text(
                widget.appBarTitle,
                style: Theme.of(context).appBarTheme.titleTextStyle,
                textAlign: TextAlign.center,
              )
            : Container(),
        GestureDetector(
          onTap: () {
            if (!_isSearch) {
              setState(() {
                _isSearch = true;
                _fnSearch.requestFocus();
              });
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Handle Animated Change view for Title and TextField Search
              Expanded(
                  // Use animated Switcher to show animation in transition widget
                  child: AnimatedSwitcher(
                duration: Duration(milliseconds: widget.animationDuration),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  //animated from right to left
                  final inAnimation = Tween<Offset>(
                          begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                      .animate(animation);
                  //animated from left to right
                  final outAnimation = Tween<Offset>(
                          begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
                      .animate(animation);

                  // show different animation base on key
                  if (child.key == ValueKey("textF")) {
                    return ClipRect(
                      child:
                          SlideTransition(position: inAnimation, child: child),
                    );
                  } else {
                    return ClipRect(
                      child:
                          SlideTransition(position: outAnimation, child: child),
                    );
                  }
                },
                child: _isSearch
                    ? Form(
                        key: widget.searchFieldKey,
                        child: SizedBox(
                          key: ValueKey("textF"),
                          height: widget.height ?? 8.0.h,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextFormField(
                                focusNode: _fnSearch,
                                controller: _conSearch,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.search,
                                textAlign: widget.alignment,
                                minLines: 1,
                                maxLines: 1,
                                onFieldSubmitted: widget.onFieldSubmitted,
                                validator: (value) {
                                  return AppValidation.validateSearch(value);
                                },
                                onEditingComplete: widget.onEditingComplete,
                                decoration: ConstantBoxDecorationsAndShadows
                                    .searchFieldInputDecoration,
                                textAlignVertical: TextAlignVertical.center,
                              )),
                        ),
                      )
                    :
                    //Container of Label
                    const SizedBox(
                        key: ValueKey("align"),
                        height: 60,
                      ),

                //Container of Label
              )),
              // Handle Animated Change view for Search Icon and Close Icon
              IconButton(
                icon:
                    // Use animated Switcher to show animation in transition widget
                    AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    //animated from top to bottom
                    final inAnimation = Tween<Offset>(
                            begin: const Offset(0.0, 1.0),
                            end: const Offset(0.0, 0.0))
                        .animate(animation);
                    //animated from bottom to top
                    final outAnimation = Tween<Offset>(
                            begin: const Offset(0.0, -1.0),
                            end: const Offset(0.0, 0.0))
                        .animate(animation);

                    // show different animation base on key
                    if (child.key == const ValueKey("close")) {
                      return ClipRect(
                        child: SlideTransition(
                          position: inAnimation,
                          child: child,
                        ),
                      );
                    } else {
                      return ClipRect(
                        child: SlideTransition(
                            position: outAnimation, child: child),
                      );
                    }
                  },
                  child: _isSearch
                      ?
                      //if is search, set icon as Close
                      widget.closeIcon
                      //if is !search, set icon as Search
                      : widget.searchIcon,
                ),
                onPressed: () {
                  setState(() {
                    /// Check if search active and it's not empty
                    if (_isSearch && _conSearch.text.isNotEmpty) {
                      _conSearch.clear();
                    } else {
                      _isSearch = !_isSearch;
                      if (_isSearch) _fnSearch.requestFocus();
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
