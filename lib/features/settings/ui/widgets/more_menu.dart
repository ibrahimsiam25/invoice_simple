import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_simple/core/theme/app_colors.dart';
import 'package:invoice_simple/core/theme/app_text_styles.dart';

class MoreMenu extends StatefulWidget {
  final VoidCallback? onDelete;
  const MoreMenu({super.key, this.onDelete});

  @override
  State<MoreMenu> createState() => MoreMenuState();
}

class MoreMenuState extends State<MoreMenu> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void _showMenu() {
    _overlayEntry = _buildOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _buildOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final buttonPosition = renderBox.localToGlobal(Offset.zero);
    final buttonSize = renderBox.size;

    // The menu is positioned to the left of the icon, vertically centered with the icon.
    return OverlayEntry(
      builder: (context) => Positioned(
        top: buttonPosition.dy + buttonSize.height / 2 - 28, // half menu height for vertical centering
        left: buttonPosition.dx - 150, // menu width + small margin
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _hideMenu,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Delete account',
                    style: AppTextStyles.poFont20BlackWh400.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.red,
                    ),
                  ),
                  const SizedBox(width: 8),
               Icon(Icons.delete, color: AppColors.red, size: 20.sp),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: IconButton(
        icon: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: AppColors.black),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.more_horiz, color: AppColors.black, size: 20),
        ),
        onPressed: () {
          if (_overlayEntry == null) {
            _showMenu();
          } else {
            _hideMenu();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _hideMenu();
    super.dispose();
  }
}
