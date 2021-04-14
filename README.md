## How to add row in Flutter DataTable (SfDataGrid)?

The Syncfusion Flutter DataTable  widget provides the support to add the row at run time.

The following steps explains how to add row at run time in Flutter DataTable,
## STEP 1
Create a data source class by extends DataGridSource for mapping data to the SfDataGrid.
```xml
class EmployeeDataSource extends DataGridSource {

  EmployeeDataSource({required List<Employee> employeeData}) {
    _employee = employeeData;
    updateDataGridRow();
  }

  List<DataGridRow> _employeeData = [];
  late List<Employee> _employee;

  void updateDataGridRow() {
    _employeeData = _employee
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(
                  columnName: 'designation', value: e.designation),
              DataGridCell<int>(columnName: 'salary', value: e.salary),
            ]))
        .toList();
  }

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  void updateDataGridSource() {
    notifyListeners();
  }
}
```
## STEP 2
Wrap the SfDataGrid inside the Expanded widget and initialize the SfDataGrid widget with all the required properties. Wrap the expanded widget inside the column widget. Add the row to collection from onPressed of MaterialButton. In this call back we are called notifyListener method after the row is added to the collection.

```xml
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
            employeeDataSource._employee
                .add(Employee(10015, 'Grimes', 'Developer', 15000));
            employeeDataSource.updateDataGridRow();
            employeeDataSource.updateDataGridSource();
          },
          child: Text('Add Row'),
        ),
        Expanded(
          child: SfDataGrid(
            source: employeeDataSource,
            columnWidthMode: ColumnWidthMode.fill,
            columns: <GridColumn>[
              GridTextColumn(
                  columnName: 'id',
                  label: Container(
                      padding: EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: Text(
                        'ID',
                      ))),
              GridTextColumn(
                  columnName: 'name',
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text('Name'))),
              GridTextColumn(
                  columnName: 'designation',
                  label: Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text(
                        'Designation',
                        overflow: TextOverflow.ellipsis,
                      ))),
              GridTextColumn(
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
```


