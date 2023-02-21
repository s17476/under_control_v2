import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';

import '../../../domain/entities/task/task.dart';
import '../../../domain/entities/work_request/work_request.dart';
import '../task_tile.dart';
import '../work_request_tile.dart';

class EventsList extends StatelessWidget {
  final List<dartz.Either<WorkRequest, Task>> events;
  const EventsList({
    Key? key,
    required this.events,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8),
      itemCount: events.length,
      separatorBuilder: (context, index) => const SizedBox(
        height: 8,
      ),
      itemBuilder: (context, index) {
        return events[index].fold(
          (workRequest) => WorkRequestTile(workRequest: workRequest),
          (task) => TaskTile(task: task),
        );
      },
    );
  }
}
