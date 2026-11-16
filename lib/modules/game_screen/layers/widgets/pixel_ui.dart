import 'package:flutter/material.dart';

const pixelInk = Color(0xFF17243A);
const pixelBlue = Color(0xFF3C8DDB);
const pixelYellow = Color(0xFFFFD34E);
const pixelPaper = Color(0xFFFFF7D6);

class PixelPanel extends StatelessWidget {
  const PixelPanel({required this.child, this.padding = const EdgeInsets.fromLTRB(24, 28, 24, 24), this.maxWidth = 520, super.key});
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double maxWidth;

  @override
  Widget build(BuildContext context) => ConstrainedBox(
    constraints: BoxConstraints(maxWidth: maxWidth),
    child: Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: pixelYellow,
        boxShadow: [BoxShadow(color: Color(0xCC07162D), offset: Offset(8, 8), blurRadius: 0)],
      ),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: pixelPaper,
          border: Border.all(color: pixelInk, width: 3),
        ),
        child: child,
      ),
    ),
  );
}

class PixelOverlay extends StatelessWidget {
  const PixelOverlay({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) => ClipRect(
    child: ColoredBox(
      color: const Color(0x99091B32),
      child: Center(child: SafeArea(minimum: const EdgeInsets.all(18), child: SingleChildScrollView(child: child))),
    ),
  );
}

class PixelButton extends StatefulWidget {
  const PixelButton({required this.label, required this.onPressed, this.icon, this.width, this.compact = false, this.backgroundColor = pixelYellow, super.key});
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final double? width;
  final bool compact;
  final Color backgroundColor;

  @override
  State<PixelButton> createState() => _PixelButtonState();
}

class _PixelButtonState extends State<PixelButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: widget.width,
    child: GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 75),
        transform: Matrix4.translationValues(0, _pressed ? 4 : 0, 0),
        padding: EdgeInsets.symmetric(horizontal: widget.compact ? 10 : 22, vertical: widget.compact ? 9 : 15),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          border: Border.all(color: pixelInk, width: 3),
          boxShadow: [BoxShadow(color: pixelInk, offset: Offset(4, _pressed ? 1 : 5), blurRadius: 0)],
        ),
        child: Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: [
          if (widget.icon != null) ...[Icon(widget.icon, color: pixelInk, size: widget.compact ? 19 : 23), if (widget.label.isNotEmpty) const SizedBox(width: 8)],
          if (widget.label.isNotEmpty) Flexible(child: Text(widget.label, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: pixelInk, fontWeight: FontWeight.w900, letterSpacing: 1))),
        ]),
      ),
    ),
  );
}

class PixelHeading extends StatelessWidget {
  const PixelHeading(this.text, {this.color = const Color(0xFF0754B8), super.key});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) => Text(text, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: color, fontWeight: FontWeight.w900, letterSpacing: 1.5, height: 1.15));
}
