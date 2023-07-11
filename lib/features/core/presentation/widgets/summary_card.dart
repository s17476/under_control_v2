import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    Key? key,
    required this.title,
    required this.validator,
    required this.child,
    required this.pageController,
    required this.onTapAnimateToPage,
    this.errorColor,
  }) : super(key: key);

  final String title;
  final String? Function() validator;
  final Widget child;
  final PageController pageController;
  final int onTapAnimateToPage;
  final Color? errorColor;

  Color getBackgroundColor(
    BuildContext context,
    String? errorMessage, [
    Color? errorColor,
  ]) =>
      errorMessage == null
          ? Theme.of(context).primaryColor
          : errorColor ?? Theme.of(context).colorScheme.error.withAlpha(220);
  IconData getIcon(BuildContext context, String? errorMessage) =>
      errorMessage == null ? Icons.done : Icons.clear;

  @override
  Widget build(BuildContext context) {
    // validate
    final errorMessage = validator();

    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () async => pageController.animateToPage(
        onTapAnimateToPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: getBackgroundColor(context, errorMessage, errorColor),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(2, 2),
                blurRadius: 5,
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title row
            Padding(
              padding: const EdgeInsets.only(
                top: 4,
                left: 16,
                right: 8,
              ),
              child: Row(
                children: [
                  // title
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade200,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // icon
                  Icon(
                    getIcon(context, errorMessage),
                    size: 30,
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1.5,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 8,
              ),
              child: child,
            ),
            if (errorMessage != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    thickness: 1.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 8,
                    ),
                    child: Text(
                      errorMessage,
                      style: TextStyle(
                        color: Colors.grey.shade200,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
