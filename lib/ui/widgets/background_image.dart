import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WithBackGroundImage extends StatelessWidget {
  final Widget child;
  final bool showBottomCircularLoading;

  const WithBackGroundImage({
    super.key,
    required this.child,
    this.showBottomCircularLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/images/background.svg',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        child,
        showBottomCircularLoading
            ? const Positioned.fill(
                bottom: 15,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Color(0xFF21bf73),
                    ),
                  ),
                ),
              )
            : const SizedBox(height: 1)
      ],
    );
  }
}
