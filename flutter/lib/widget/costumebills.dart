import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyCustomBill extends StatelessWidget {
  const MyCustomBill({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'date:2023/4/12',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'DetailsBillPage');
                  },
                  icon: const Icon(
                    FontAwesomeIcons.circleExclamation,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            DataTable(
              border: const TableBorder(
                  verticalInside: BorderSide(color: Colors.white),
                  right: BorderSide(color: Colors.white),
                  left: BorderSide(color: Colors.white),
                  top: BorderSide(color: Colors.white),
                  bottom: BorderSide(color: Colors.white)),
              columns: const [
                DataColumn(
                    label: Text(
                  'Column 1',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                )),
                DataColumn(
                    label: Text(
                  'Column 2',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                )),
                DataColumn(
                    label: Text(
                  'Column 3',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                )),
              ],
              rows: List<DataRow>.generate(
                9,
                (index) => DataRow(
                  cells: [
                    DataCell(Text(
                      'Cell ${index + 1}',
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    )),
                    DataCell(Text(
                      'Cell ${index + 10}',
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    )),
                    DataCell(Text(
                      'Cell ${index + 19}',
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    )),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Total: 5000',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                Text(
                  'State:',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
