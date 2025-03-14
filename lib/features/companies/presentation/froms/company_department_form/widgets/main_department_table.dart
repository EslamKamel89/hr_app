import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Department {
  final int id;
  final String subDepartment;
  final String mainDepartment;

  Department({required this.id, required this.subDepartment, required this.mainDepartment});
}

class MainDepartmentTableWidget extends StatefulWidget {
  const MainDepartmentTableWidget({super.key});

  @override
  _MainDepartmentTableWidgetState createState() => _MainDepartmentTableWidgetState();
}

class _MainDepartmentTableWidgetState extends State<MainDepartmentTableWidget> {
  late MainDepartmentDataSource _dataSource;

  @override
  void initState() {
    super.initState();
    _dataSource = MainDepartmentDataSource(_generateData());
  }

  List<Department> _generateData() {
    return List.generate(
      50,
      (index) => Department(
        id: index + 1,
        subDepartment: "SubDept ${index + 1}",
        mainDepartment: "MainDept ${((index) / 5).floor() + 1}",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
          // header: const Text(
          //   "Departments",
          //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          // ),
          columns: const [
            // DataColumn(label: Text("ID", style: TextStyle(fontWeight: FontWeight.bold))),
            // DataColumn(
            //   label: Text(
            //     "Sub\nCategory",
            //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            //     textAlign: TextAlign.center,
            //   ),
            // ),
            DataColumn(
              label: Text(
                "Main\nCategory",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            DataColumn(
              label: Text("Action", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          ],
          source: _dataSource,
          rowsPerPage: 10,
          availableRowsPerPage: const [10, 20, 50],
        )
        .animate()
        .fadeIn(duration: const Duration(milliseconds: 600))
        .slideY(begin: 0.2, duration: const Duration(milliseconds: 600));
  }
}

class MainDepartmentDataSource extends DataTableSource {
  final List<Department> departments;
  MainDepartmentDataSource(this.departments);

  @override
  DataRow? getRow(int index) {
    if (index >= departments.length) return null;
    final dept = departments[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        // DataCell(Text(dept.id.toString())),
        // DataCell(Text(dept.subDepartment)),
        DataCell(Text(dept.mainDepartment)),
        DataCell(
          Row(
            children: [
              InkWell(onTap: () {}, child: Icon(Icons.edit, size: 25))
                  .animate()
                  .fadeIn(duration: const Duration(milliseconds: 300))
                  .slideX(begin: -0.1, duration: const Duration(milliseconds: 300)),
              SizedBox(width: 10),
              InkWell(onTap: () {}, child: Icon(Icons.delete, size: 25, color: Colors.redAccent))
                  .animate()
                  .fadeIn(duration: const Duration(milliseconds: 300))
                  .slideX(begin: 0.1, duration: const Duration(milliseconds: 300)),
              // ElevatedButton.icon(
              //       onPressed: () {
              //         // Edit action here.
              //       },
              //       icon: const Icon(Icons.edit, size: 16),
              //       label: const Text("Edit", style: TextStyle(fontSize: 12)),
              //       style: ElevatedButton.styleFrom(
              //         // primary: Colors.blue,
              //         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              //       ),
              //     )
              //     .animate()
              //     .fadeIn(duration: const Duration(milliseconds: 300))
              //     .slideX(begin: -0.1, duration: const Duration(milliseconds: 300)),
              // const SizedBox(width: 8),
              // ElevatedButton.icon(
              //       onPressed: () {
              //         // Delete action here.
              //       },
              //       icon: const Icon(Icons.delete, size: 16),
              //       label: const Text("Delete", style: TextStyle(fontSize: 12)),
              //       style: ElevatedButton.styleFrom(
              //         // primary: Colors.red,
              //         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              //       ),
              //     )
              //     .animate()
              //     .fadeIn(duration: const Duration(milliseconds: 300))
              //     .slideX(begin: 0.1, duration: const Duration(milliseconds: 300)),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => departments.length;
  @override
  int get selectedRowCount => 0;
}
