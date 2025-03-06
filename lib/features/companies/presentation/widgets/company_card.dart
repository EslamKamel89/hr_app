import 'package:flutter/material.dart';
import 'package:hr/core/router/app_routes_names.dart';
import 'package:hr/core/widgets/collapsible_card.dart';
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
              widget.company.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Employees number: ${widget.company.employeesCount}',
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          Text(
            'Created at: ${widget.company.createdAt.toLocal().toString().split(' ')[0]}',
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
              ElevatedButton.icon(
                onPressed: () {
                  // Implement delete functionality here.
                },
                icon: Icon(Icons.delete, size: 18),
                label: Text('Delete'),
                style: ElevatedButton.styleFrom(
                  // primary: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
