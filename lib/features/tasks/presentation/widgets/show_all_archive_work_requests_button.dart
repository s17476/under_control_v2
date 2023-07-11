import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../blocs/work_request_archive/work_request_archive_bloc.dart';

class ShowAllArchiveWorkRequestsButton extends StatelessWidget {
  const ShowAllArchiveWorkRequestsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkRequestArchiveBloc, WorkRequestArchiveState>(
      builder: (context, state) {
        if (state is WorkRequestArchiveLoadedState &&
            !state.isAllWorkRequests) {
          return InkWell(
            onTap: () => context
                .read<WorkRequestArchiveBloc>()
                .add(GetWorkRequestsArchiveStreamEvent(isAllWorkRequest: true)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 30,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.show_all,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Expanded(
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
