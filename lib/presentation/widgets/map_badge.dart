import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';

class MapBadge extends StatelessWidget {
  final String mapName;
  final bool isSelected;
  final VoidCallback? onTap;

  const MapBadge({
    super.key,
    required this.mapName,
    this.isSelected = false,
    this.onTap,
  });

  Color _getMapColor() {
    switch (mapName.toUpperCase()) {
      case 'ERANGEL':
        return AppColors.mapErangel;
      case 'MIRAMAR':
        return AppColors.mapMiramar;
      case 'SANHOK':
        return AppColors.mapSanhok;
      case 'RONDO':
        return AppColors.mapRondo;
      default:
        return AppColors.neonCyan;
    }
  }

  IconData _getMapIcon() {
    switch (mapName.toUpperCase()) {
      case 'ERANGEL':
        return Icons.forest_outlined;
      case 'MIRAMAR':
        return Icons.wb_sunny_outlined;
      case 'SANHOK':
        return Icons.water_drop_outlined;
      case 'RONDO':
        return Icons.location_city_outlined;
      default:
        return Icons.map_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getMapColor();

    Widget badgeContent = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? color.withOpacity(0.25) : color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isSelected ? color : color.withOpacity(0.4),
          width: isSelected ? 1.5 : 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getMapIcon(), size: 12, color: isSelected ? Colors.white : color),
          const SizedBox(width: 4),
          Text(
            mapName.toUpperCase(),
            style: GoogleFonts.rajdhani(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: isSelected ? Colors.white : color,
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: badgeContent,
      );
    }
    return badgeContent;
  }
}

