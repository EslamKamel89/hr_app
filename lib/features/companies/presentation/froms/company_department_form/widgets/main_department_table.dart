// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hr/utils/styles/styles.dart';

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
  // late MainDepartmentDataSource _dataSource;

  @override
  void initState() {
    super.initState();
    // _dataSource = MainDepartmentDataSource(_generateData());
  }

  List<Department> _generateData() {
    return List.generate(
      50,
      (index) => Department(
        id: index + 1,
        subDepartment: "This is Sub Department ${index + 1}",
        mainDepartment: "This is Main Department ${((index) / 5).floor() + 1}",
      ),
    );
  }

  final borderSide = BorderSide(color: Colors.grey);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: _generateData().length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(border: Border(bottom: BorderSide())),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: txt('Main\nDepartment', e: St.bold16, textAlign: TextAlign.center),
                    ),

                    Expanded(
                      flex: 1,
                      child: txt('Action', e: St.bold16, textAlign: TextAlign.center),
                    ),
                  ],
                ),
              );
            }
            index = index - 1;
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(border: Border(bottom: borderSide)),

              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(left: borderSide, right: borderSide),
                      ),
                      child: txt(
                        _generateData()[index].mainDepartment,
                        e: St.reg16,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(border: Border(right: borderSide)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(onTap: () {}, child: Icon(Icons.edit, size: 25))
                              .animate()
                              .fadeIn(duration: const Duration(milliseconds: 300))
                              .slideX(begin: -0.1, duration: const Duration(milliseconds: 300)),
                          SizedBox(width: 10),
                          InkWell(
                                onTap: () {},
                                child: Icon(Icons.delete, size: 25, color: Colors.redAccent),
                              )
                              .animate()
                              .fadeIn(duration: const Duration(milliseconds: 300))
                              .slideX(begin: 0.1, duration: const Duration(milliseconds: 300)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        )
        .animate()
        .fadeIn(duration: const Duration(milliseconds: 600))
        .slideY(begin: 0.2, duration: const Duration(milliseconds: 600));
    // return PaginatedDataTable(
    //       // header: const Text(
    //       //   "Departments",
    //       //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    //       // ),
    //       columns: const [
    //         // DataColumn(label: Text("ID", style: TextStyle(fontWeight: FontWeight.bold))),
    //         // DataColumn(
    //         //   label: Text(
    //         //     "Sub\nCategory",
    //         //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
    //         //     textAlign: TextAlign.center,
    //         //   ),
    //         // ),
    //         DataColumn(
    //           label: Text(
    //             "Main\nDepartment",
    //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
    //             textAlign: TextAlign.center,
    //           ),
    //         ),
    //         DataColumn(
    //           label: Text("Action", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
    //         ),
    //       ],
    //       source: _dataSource,
    //       rowsPerPage: 10,
    //       availableRowsPerPage: const [10, 20, 50],
    //     )
    //     .animate()
    //     .fadeIn(duration: const Duration(milliseconds: 600))
    //     .slideY(begin: 0.2, duration: const Duration(milliseconds: 600));
  }
}

// class MainDepartmentDataSource extends DataTableSource {
//   final List<Department> departments;
//   MainDepartmentDataSource(this.departments);

//   @override
//   DataRow? getRow(int index) {
//     if (index >= departments.length) return null;
//     final dept = departments[index];
//     return DataRow.byIndex(
//       index: index,
//       cells: [
//         // DataCell(Text(dept.id.toString())),
//         // DataCell(Text(dept.subDepartment)),
//         DataCell(Text(dept.mainDepartment)),
//         DataCell(
//           Row(
//             children: [
//               InkWell(onTap: () {}, child: Icon(Icons.edit, size: 25))
//                   .animate()
//                   .fadeIn(duration: const Duration(milliseconds: 300))
//                   .slideX(begin: -0.1, duration: const Duration(milliseconds: 300)),
//               SizedBox(width: 10),
//               InkWell(onTap: () {}, child: Icon(Icons.delete, size: 25, color: Colors.redAccent))
//                   .animate()
//                   .fadeIn(duration: const Duration(milliseconds: 300))
//                   .slideX(begin: 0.1, duration: const Duration(milliseconds: 300)),
//               // ElevatedButton.icon(
//               //       onPressed: () {
//               //         // Edit action here.
//               //       },
//               //       icon: const Icon(Icons.edit, size: 16),
//               //       label: const Text("Edit", style: TextStyle(fontSize: 12)),
//               //       style: ElevatedButton.styleFrom(
//               //         // primary: Colors.blue,
//               //         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               //       ),
//               //     )
//               //     .animate()
//               //     .fadeIn(duration: const Duration(milliseconds: 300))
//               //     .slideX(begin: -0.1, duration: const Duration(milliseconds: 300)),
//               // const SizedBox(width: 8),
//               // ElevatedButton.icon(
//               //       onPressed: () {
//               //         // Delete action here.
//               //       },
//               //       icon: const Icon(Icons.delete, size: 16),
//               //       label: const Text("Delete", style: TextStyle(fontSize: 12)),
//               //       style: ElevatedButton.styleFrom(
//               //         // primary: Colors.red,
//               //         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               //       ),
//               //     )
//               //     .animate()
//               //     .fadeIn(duration: const Duration(milliseconds: 300))
//               //     .slideX(begin: 0.1, duration: const Duration(milliseconds: 300)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   bool get isRowCountApproximate => false;
//   @override
//   int get rowCount => departments.length;
//   @override
//   int get selectedRowCount => 0;
// }
