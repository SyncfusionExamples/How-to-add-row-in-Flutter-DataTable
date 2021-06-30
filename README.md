# How to add row in Flutter DataTable (SfDataGrid)

The Syncfusion Flutter DataTable  widget provides the support to perform the CRUD operation at run time. DataGridSource class is listenable. You should call notifyListeners method to refresh the DataGrid whenever the CRUD operation is performed.

The following steps explains how to add a row at run time in Flutter DataTable,

## STEP 1
Create a data source class by extends DataGridSource for mapping data to the SfDataGrid. Since the notifyListeners method is protected, you have to create new method as public and call the notifyListeners method inside from new method. Also, created method named updateDataGridRows to recreate the DataGridRow collection based on CRUD operation.

```xml
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
```

## STEP 2
Wrap the SfDataGrid inside the Expanded widget and initialize the SfDataGrid widget with all the required properties. Wrap the Expanded widget inside the column widget.

On button pressed callback, new row is added and public method which is added in DataGridSource class and updateDataGridRows method is called.

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
```

**[View document in Syncfusion Flutter Knowledge base](https://www.syncfusion.com/kb/12517/how-to-add-row-in-flutter-datatable-sfdatagrid)**