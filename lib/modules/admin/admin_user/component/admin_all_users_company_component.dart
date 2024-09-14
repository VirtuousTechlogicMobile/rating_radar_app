import 'package:RatingRadar_app/modules/admin/homepage/model/admin_homepage_recent_user_company_model.dart';
import 'package:flutter/material.dart';

import '../../homepage/components/admin_homepage_recent_user_company_components.dart';

class AdminAllUsersCompanyComponent extends StatelessWidget {
  final List<AdminHomepageRecentUserCompanyModel>? userList;

  const AdminAllUsersCompanyComponent({
    super.key,
    required this.userList,
  });

  @override
  Widget build(BuildContext context) {
    if (userList == null || userList!.isEmpty) {
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
                  userList!.length,
                  (index) {
                    return AdminHomepageRecentUserCompanyComponents(
                      adminHomepageRecentUserCompanyModel: userList![index],
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
