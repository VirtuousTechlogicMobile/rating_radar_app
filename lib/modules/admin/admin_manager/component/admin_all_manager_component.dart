import 'package:RatingRadar_app/modules/admin/homepage/components/admin_homepage_recent_manager_component.dart';
import 'package:RatingRadar_app/modules/admin/homepage/model/admin_homepage_recent_manager_model.dart';
import 'package:flutter/material.dart';

class AdminAllManagerComponent extends StatelessWidget {
  final List<AdminHomepageRecentManagerModel>? managerList;
  const AdminAllManagerComponent({super.key, required this.managerList});

  @override
  Widget build(BuildContext context) {
    if (managerList == null || managerList!.isEmpty) {
      return const Center(
        child: Text(
          'No data available right now', // Replace with localized string if needed
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  managerList!.length,
                  (index) {
                    return AdminHomepageRecentManagerComponent(
                      adminHomepageRecentManagerModel: managerList![index],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
