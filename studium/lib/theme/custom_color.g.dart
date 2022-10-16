import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

const chartbrown = Color(0xFFC07015);

CustomColors lightCustomColors = const CustomColors(
  sourceChartbrown: Color(0xFFC07015),
  chartbrown: Color(0xFF8E4F00),
  onChartbrown: Color(0xFFFFFFFF),
  chartbrownContainer: Color(0xFFFFDCC1),
  onChartbrownContainer: Color(0xFF2E1600),
);

CustomColors darkCustomColors = const CustomColors(
  sourceChartbrown: Color(0xFFC07015),
  chartbrown: Color(0xFFFFB877),
  onChartbrown: Color(0xFF4C2700),
  chartbrownContainer: Color(0xFF6C3A00),
  onChartbrownContainer: Color(0xFFFFDCC1),
);

/// Defines a set of custom colors, each comprised of 4 complementary tones.
///
/// See also:
///   * <https://m3.material.io/styles/color/the-color-system/custom-colors>
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.sourceChartbrown,
    required this.chartbrown,
    required this.onChartbrown,
    required this.chartbrownContainer,
    required this.onChartbrownContainer,
  });

  final Color? sourceChartbrown;
  final Color? chartbrown;
  final Color? onChartbrown;
  final Color? chartbrownContainer;
  final Color? onChartbrownContainer;

  @override
  CustomColors copyWith({
    Color? sourceChartbrown,
    Color? chartbrown,
    Color? onChartbrown,
    Color? chartbrownContainer,
    Color? onChartbrownContainer,
  }) {
    return CustomColors(
      sourceChartbrown: sourceChartbrown ?? this.sourceChartbrown,
      chartbrown: chartbrown ?? this.chartbrown,
      onChartbrown: onChartbrown ?? this.onChartbrown,
      chartbrownContainer: chartbrownContainer ?? this.chartbrownContainer,
      onChartbrownContainer: onChartbrownContainer ?? this.onChartbrownContainer,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      sourceChartbrown: Color.lerp(sourceChartbrown, other.sourceChartbrown, t),
      chartbrown: Color.lerp(chartbrown, other.chartbrown, t),
      onChartbrown: Color.lerp(onChartbrown, other.onChartbrown, t),
      chartbrownContainer: Color.lerp(chartbrownContainer, other.chartbrownContainer, t),
      onChartbrownContainer: Color.lerp(onChartbrownContainer, other.onChartbrownContainer, t),
    );
  }

  /// Returns an instance of [CustomColors] in which the following custom
  /// colors are harmonized with [dynamic]'s [ColorScheme.primary].
  ///   * [CustomColors.sourceChartbrown]
  ///   * [CustomColors.chartbrown]
  ///   * [CustomColors.onChartbrown]
  ///   * [CustomColors.chartbrownContainer]
  ///   * [CustomColors.onChartbrownContainer]
  ///
  /// See also:
  ///   * <https://m3.material.io/styles/color/the-color-system/custom-colors#harmonization>
  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(
      sourceChartbrown: sourceChartbrown!.harmonizeWith(dynamic.primary),
      chartbrown: chartbrown!.harmonizeWith(dynamic.primary),
      onChartbrown: onChartbrown!.harmonizeWith(dynamic.primary),
      chartbrownContainer: chartbrownContainer!.harmonizeWith(dynamic.primary),
      onChartbrownContainer: onChartbrownContainer!.harmonizeWith(dynamic.primary),
    );
  }
}