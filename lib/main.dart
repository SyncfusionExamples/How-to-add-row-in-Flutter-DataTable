/// Package imports
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// DataGrid Package
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syncfusion DataGrid Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DataGridSample(),
    );
  }
}

class DataGridSample extends StatefulWidget {
  /// Creates the home page.
  DataGridSample({Key? key}) : super(key: key);

  @override
  _DataGridSampleState createState() => _DataGridSampleState();
}

class _DataGridSampleState extends State<DataGridSample> {
  List<Employee> employees = <Employee>[];
  late EmployeeDataSource employeeDataSource;

  @override
  void initState() {
    super.initState();
    employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employees: employees);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter DataGrid'),
      ),
      body: Column(children: [
        MaterialButton(
          color: Colors.blue,
          onPressed: () {
            employeeDataSource._employees
                .add(Employee(10015, 'Grimes', 'Developer', 15000));
            employeeDataSource.updateDataGridRows();
            employeeDataSource.updateDataGridSource();
          },
          child: Text('Add Row'),
        ),
        Expanded(
          child: SfDataGrid(
            source: employeeDataSource,
            columnWidthMode: ColumnWidthMode.fill,
            columns: <GridColumn>[
              GridColumn(
                  columnName: 'id',
                  label: Container(
                      padding: EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: Text(
                        'ID',
                      ))),
              GridColumn(
                  columnName: 'name',
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text('Name'))),
              GridColumn(
                  columnName: 'designation',
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text(
                        'Designation',
                        overflow: TextOverflow.ellipsis,
                      ))),
              GridColumn(
                  columnName: 'salary',
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text('Salary'))),
            ],
          ),
        ),
      ]),
    );
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(10001, 'James', 'Project Lead', 20000),
      Employee(10002, 'Kathryn', 'Manager', 30000),
      Employee(10003, 'Lara', 'Developer', 15000),
      Employee(10004, 'Michael', 'Designer', 15000),
      Employee(10005, 'Martin', 'Developer', 15000),
      Employee(10006, 'Newberry', 'Developer', 15000),
      Employee(10007, 'Balnc', 'Developer', 15000),
      Employee(10008, 'Perry', 'Developer', 15000),
      Employee(10009, 'Gable', 'Developer', 15000),
      Employee(10010, 'Grimes', 'Developer', 15000),
      Employee(10011, 'James', 'Project Lead', 20000),
      Employee(10012, 'Kathryn', 'Manager', 30000),
      Employee(10013, 'Lara', 'Developer', 15000),
      Employee(10014, 'Michael', 'Designer', 15000),
    ];
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Employee {
  /// Creates the employee class with required details.
  Employee(this.id, this.name, this.designation, this.salary);

  /// Id of an employee.
  final int id;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String designation;

  /// Salary of an employee.
  final int salary;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Employee> employees}) {
    _employees = employees;
    updateDataGridRows();
  }

  List<DataGridRow> dataGridRow = [];
  late List<Employee> _employees;
  Color? rowBackgroundColor;

  void updateDataGridRows() {
    dataGridRow = _employees
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: dataGridRow.id),
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<String>(
                  columnName: 'designation', value: dataGridRow.designation),
              DataGridCell<int>(
                  columnName: 'salary', value: dataGridRow.salary),
            ]))
        .toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRow;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  void updateDataGridSource() {
    notifyListeners();
  }
}
