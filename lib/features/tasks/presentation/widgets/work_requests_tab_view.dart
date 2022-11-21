import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/responsive_size.dart';
import '../../domain/entities/work_request/work_request.dart';
import 'work_request_tile.dart';

class WorkRequestsTabView extends StatelessWidget with ResponsiveSize {
  const WorkRequestsTabView({
    Key? key,
    required this.workRequests,
  }) : super(key: key);

  final List<WorkRequest> workRequests;

  @override
  Widget build(BuildContext context) {
    if (workRequests.isEmpty) {
      return SizedBox(
        child: Text(
          AppLocalizations.of(context)!.item_no_items,
        ),
      );
    } else {
      return AnimatedSize(
        duration: const Duration(milliseconds: 300),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: workRequests.length,
          itemBuilder: (context, index) => Padding(
            key: ValueKey(workRequests[index].id),
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 2,
            ),
            child: WorkRequestTile(
              workRequest: workRequests[index],
            ),
          ),
        ),
      );
    }
  }
}
