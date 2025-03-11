import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/core/models/api_response_model.dart';
import 'package:hr/core/router/app_routes_names.dart';
import 'package:hr/core/widgets/collapsible_card.dart';
import 'package:hr/core/widgets/show_are_you_sure_dialog.dart';
import 'package:hr/features/companies/cubits/companies_index_cubit.dart';
import 'package:hr/features/companies/models/company_model.dart';

class CompanyCard extends StatefulWidget {
  final CompanyModel company;
  final int number;
  const CompanyCard({super.key, required this.company, required this.number});

  @override
  _CompanyCardState createState() => _CompanyCardState();
}

class _CompanyCardState extends State<CompanyCard> {
  @override
  Widget build(BuildContext context) {
    return CollapsibleCard(
      header: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.teal,
            child: Text(
              widget.number.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              widget.company.companyName ?? '',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   'Employees number: ${widget.company.employeesCount}',
          //   style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          // ),
          Text(
            'Created at: ${widget.company.createdAt?.split('T')[0]}',
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutesNames.companyCreateEditView,
                    arguments: widget.company,
                  );
                },
                icon: Icon(Icons.edit, size: 18),
                label: Text('Edit'),
                style: ElevatedButton.styleFrom(
                  // primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(width: 8),
              BlocBuilder<
                CompaniesIndexCubit,
                ApiResponseModel<List<CompanyModel>>
              >(
                builder: (context, state) {
                  final controller = context.read<CompaniesIndexCubit>();
                  if (state.response == ResponseEnum.loading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ElevatedButton.icon(
                    onPressed: () async {
                      final confirm = await showAreYouSureDialog();
                      if (confirm == true && widget.company.id != null) {
                        controller.delete(widget.company.id!);
                      }
                    },
                    icon: Icon(Icons.delete, size: 18),
                    label: Text('Delete'),
                    style: ElevatedButton.styleFrom(
                      // primary: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
