import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hr/core/widgets/default_drawer.dart';
import 'package:hr/core/widgets/main_scaffold.dart';

class CompaniesView extends StatefulWidget {
  const CompaniesView({super.key});

  @override
  State<CompaniesView> createState() => _CompaniesViewState();
}

class _CompaniesViewState extends State<CompaniesView> {
  final TextEditingController _searchController = TextEditingController();
  final List<Employee> employees = [
    Employee(
      number: 1,
      name: 'Alice Johnson',
      createdAt: DateTime(2020, 4, 16),
    ),
    Employee(number: 2, name: 'Bob Smith', createdAt: DateTime(2021, 2, 10)),
    Employee(
      number: 3,
      name: 'Charlie Brown',
      createdAt: DateTime(2022, 7, 22),
    ),
  ];

  String _searchQuery = '';

  void _addEmployee() {
    // You can implement your add employee functionality here.
    // For demonstration, we'll simply add a dummy employee.
    setState(() {
      employees.add(
        Employee(
          number: employees.length + 1,
          name: 'New Employee ${employees.length + 1}',
          createdAt: DateTime.now(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredEmployees =
        employees.where((e) {
          return e.name.toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();
    return MainScaffold(
      appBarTitle: 'Companies',
      drawer: DefaultDrawer(),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search employees...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
              SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: _addEmployee,
                icon: Icon(Icons.add),
                label: Text('Add'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // List of employee cards
          Expanded(
            child: ListView.builder(
              itemCount: filteredEmployees.length,
              itemBuilder: (context, index) {
                final employee = filteredEmployees[index];
                return EmployeeCard(employee: employee)
                    .animate() // Using flutter_animate for a fade-in animation
                    .fadeIn(duration: Duration(milliseconds: 500))
                    .slide(begin: Offset(0, 0.1));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class EmployeeCard extends StatefulWidget {
  final Employee employee;

  const EmployeeCard({super.key, required this.employee});

  @override
  _EmployeeCardState createState() => _EmployeeCardState();
}

class _EmployeeCardState extends State<EmployeeCard>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: _toggleExpanded,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic information: number and name
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.teal,
                    child: Text(
                      widget.employee.number.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.employee.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              // Expanded content with animation
              AnimatedCrossFade(
                firstChild: SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Created at: ${widget.employee.createdAt.toLocal().toString().split(' ')[0]}',
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              // Implement edit functionality here.
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
                ),
                crossFadeState:
                    _expanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                duration: Duration(milliseconds: 300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Employee {
  final int number;
  final String name;
  final DateTime createdAt;

  Employee({required this.number, required this.name, required this.createdAt});
}
