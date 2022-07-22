import 'package:flutter/material.dart';

import '../../../domain/entities/location.dart';

class AddressRow extends StatelessWidget {
  final Location location;
  const AddressRow({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Wrap(
        children: [
          // address
          if (location.address!.isNotEmpty)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.store_mall_directory_sharp,
                  size: 15,
                  color: Colors.grey.shade200,
                ),
                Text(
                  location.address!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  width: 4,
                ),
              ],
            ),
          // city
          if (location.city!.isNotEmpty)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_city,
                  size: 15,
                  color: Colors.grey.shade200,
                ),
                Text(
                  location.city!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  width: 4,
                ),
              ],
            ),
          // post code
          if (location.postCode!.isNotEmpty)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.mail_sharp,
                  size: 15,
                  color: Colors.grey.shade200,
                ),
                Text(
                  location.postCode!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  width: 4,
                ),
              ],
            ),
          // country
          if (location.country!.isNotEmpty)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.flag,
                  size: 15,
                  color: Colors.grey.shade200,
                ),
                Text(
                  location.country!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  width: 4,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
