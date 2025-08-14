import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

typedef CategoryTapCallback = void Function(
  int index, {
  required String id,
  required String title,
});

class CategoryItem extends StatelessWidget {
  final int index;
  final String id;
  final String title;
  final bool isSelected;
  final CategoryTapCallback onItemClick;

  const CategoryItem(
    this.index,
    this.id,
    this.title,
    this.isSelected,
    this.onItemClick, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onItemClick(index, id: id, title: title),
      child: Container(
        color: isSelected ? ColorManager.white : Colors.transparent,
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Row(
          children: [
            Visibility(
              visible: isSelected,
              child: Container(
                width: AppSize.s8,
                height: AppSize.s60,
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(AppSize.s100),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p16,
                  horizontal: AppPadding.p8,
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: getMediumStyle(
                    color: ColorManager.primary,
                    fontSize: FontSize.s14,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
