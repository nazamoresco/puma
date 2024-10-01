import 'package:game/flame_components/layout_component.dart';

/// Allows laying out children in a row by defining a [LayoutComponentAlignment]
/// type.
class RowComponent extends LayoutComponent {
  RowComponent({
    LayoutComponentAlignment alignment = LayoutComponentAlignment.start,
    double gap = 0.0,
  }) : super(
          Direction.horizontal,
          alignment,
          gap,
        );
}
