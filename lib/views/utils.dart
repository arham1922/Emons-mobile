import 'package:flutter/material.dart';



TextStyle whiteTextStyle = const TextStyle(
  color: Colors.white,
  fontSize: 12,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w600,
  height: 0,
);

class MyTextStyles {
  static const TextStyle style1 = TextStyle(
    color: Color(0xFF22255A),
    fontSize: 13.5,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    height: 0,
  );

  static const TextStyle style2 = TextStyle(
      color: Colors.black,
    fontSize: 16,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,
  );

  static const TextStyle style3 = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
  );
  static const TextStyle style4 = TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    height: 0,
  );
   static const TextStyle style5 = TextStyle(
   color: Color(0xFFDE1F27),
   fontSize: 12,
   fontFamily: 'Poppins',
   fontWeight: FontWeight.w400,
   height: 0,
  );
     static const TextStyle style6 = TextStyle(
   color: Color.fromARGB(255, 0, 0, 0),
   fontSize: 10,
   fontFamily: 'Poppins',
   fontWeight: FontWeight.w400,
   height: 0,
  );
   static const TextStyle style7 = TextStyle(
   color: Color.fromARGB(255, 0, 0, 0),
   fontSize: 10,
   fontFamily: 'Poppins',
   fontWeight: FontWeight.w600,
   height: 0,
  );
   static const TextStyle style8 = TextStyle(
   color: Colors.white,
   fontSize: 20,
   fontFamily: 'Montserrat',
   fontWeight: FontWeight.w600,
   height: 0.07,
   letterSpacing: 2,
  );
  static TextStyle style9 =TextStyle(
  fontFamily: "Poppins",
  fontSize: 13,
  fontWeight: FontWeight.w400,
  color: Color(0xff000000),
  height: 20/13,
    );

  static const TextStyle style10 = TextStyle(
    color: Color.fromARGB(255, 255, 255, 255),
    fontSize: 20,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w900,
  );

  static const TextStyle style11 = TextStyle(
    color: Color.fromARGB(255, 255, 255, 255),
    fontSize: 15,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
  );

  static const TextStyle style12 = TextStyle(
    fontFamily: "Poppins",
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: Color.fromARGB(255, 0, 0, 0),
    height: 15/10,
    );

  static const TextStyle style13 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    );
  static const TextStyle style14 = TextStyle(
    fontSize: 16,
    color: Colors.grey, );
    static const TextStyle style15 = TextStyle(
    fontFamily: "Roboto",
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: Color.fromARGB(255, 255, 255, 255),
    height: 14/12,);

        static const TextStyle style16 = TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: 16,
      fontFamily: 'Source Sans Pro',
      fontWeight: FontWeight.w400,
      height: 0.09,
      letterSpacing: 0.50,);

      static const TextStyle style17 = TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            );
      static const TextStyle style18 = TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w300,
    height: 0,
  );
}

class MyBoxShadows {
  static const BoxShadow boxshadow1 = BoxShadow(
    color: Color(0x3F000000),
    blurRadius: 4,
    offset: Offset(0, 1),
    spreadRadius: 0,
  );

  static const BoxShadow boxshadow2 = BoxShadow(
    color: Color(0x3F000000),
    blurRadius: 4, 
    spreadRadius: 2, 
    offset: Offset(0, 2), 
  );
}

class MyContainer {
  static Container getContainerBesar() {
    return Container(
      width: 350,
      height: 640,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [MyBoxShadows.boxshadow2],
      ),
    );
  }
}

class TwoColumnTable extends StatelessWidget {
  final List<String> column1;
  final List<String> column2;

  TwoColumnTable({required this.column1, required this.column2});

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultColumnWidth: IntrinsicColumnWidth(),
      children: List<TableRow>.generate(
        column1.length,
        (int index) => TableRow(
          decoration: BoxDecoration(
            color: index.isEven ?Colors.grey.shade300: Colors.white  ,
          ),
          children: [
            TableCell(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
                child: Text(
                  column1[index],
                  style: MyTextStyles.style4,
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
                child: Text(
                  column2[index],
                  style: MyTextStyles.style5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TwoColumnTable2 extends StatelessWidget {
  final List<String> column1;
  final List<String> column2;

  TwoColumnTable2({required this.column1, required this.column2});

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultColumnWidth: IntrinsicColumnWidth(),
      children: List<TableRow>.generate(
        column1.length,
        (int index) => TableRow(
          decoration: BoxDecoration(
            color: index.isEven ?Colors.grey.shade300: Colors.white  ,
          ),
          children: [
            TableCell(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
                child: Text(
                  column1[index],
                  style: MyTextStyles.style4,
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
                child: Text(
                  column2[index],
                  style: TextStyle(
                    color: getColorForStatus(column2[index]), 
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w900,
                    height: 0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
class TwoColumnTable3 extends StatelessWidget {
  final List<String> column1;
  final List<String> column2;

  TwoColumnTable3({required this.column1, required this.column2});

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultColumnWidth: IntrinsicColumnWidth(),
      children: List<TableRow>.generate(
        column1.length,
        (int index) => TableRow(
          decoration: BoxDecoration(
            color: index.isEven ?Colors.grey.shade300: Colors.white  ,
          ),
          children: [
            TableCell(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
                child: Text(
                  column1[index],
                  style: MyTextStyles.style4,
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
                child: Text(
                  column2[index],
                  style: MyTextStyles.style18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FourColumnTable extends StatelessWidget {
  final List<String> column1;
  final List<String> column2;
  final List<String> column3; 
  final List<String> column4; 

  FourColumnTable({
    required this.column1,
    required this.column2,
    required this.column3,
    required this.column4,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultColumnWidth: IntrinsicColumnWidth(),
      children: List<TableRow>.generate(
        column1.length,
        (int index) => TableRow(
          decoration: BoxDecoration(
            color: index.isEven ?Colors.grey.shade300: Colors.white  ,
          ),
          children: [
            TableCell(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0),
                child: Container(
                  width: 40, 
                  alignment: Alignment.center,
                  child: Text(
                    column1[index],
                    style: MyTextStyles.style4,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0),
                child: Container(
                  width: 116, 
                  alignment: Alignment.center,
                  child: Text(
                    column2[index],
                    style: MyTextStyles.style4,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
                child: Container(
                  width: 67, 
                  alignment: Alignment.center,
                  child: Text(
                    column3[index],
                    style: MyTextStyles.style4,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
                child: Container(
                  width: 67, 
                  alignment: Alignment.center,
                  child: Text(
                    column4[index],
                    style: MyTextStyles.style4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class button extends StatelessWidget {
  final double width;
  final double height;
  final Widget child; 
  final Function() onTap;

  button({
    required this.width,
    required this.height,
    required this.child, 
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [MyBoxShadows.boxshadow2],
        ),
        child: Center(child: child), 
      ),
    );
  }
}




class ThreeColumnTable extends StatelessWidget {
  final List<String> column1;
  final List<String> column2;
  final List<String> column3;

  ThreeColumnTable({
    required this.column1,
    required this.column2,
    required this.column3,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultColumnWidth: IntrinsicColumnWidth(),
      children: List<TableRow>.generate(
        column1.length,
        (int index) => TableRow(
          decoration: BoxDecoration(
            color: index.isEven ? Colors.grey.shade300 : Colors.white,
          ),
          children: [
            TableCell(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0),
                child: Container(
                  width: 117,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    column1[index],
                    style: MyTextStyles.style4,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0),
                child: Container(
                  width: 53,
                  alignment: Alignment.center,
                  child: Text(
                    column2[index],
                    style: MyTextStyles.style4,
                  ),
                ),
              ),
            ),
            TableCell(
  child: Padding(
    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
    child: Container(
      width: 53,
      alignment: Alignment.center,
      
      child: Text(
        column3[index],
        style: TextStyle(
          color: getColorForStatus(column3[index]), 
          fontWeight: FontWeight.bold, 
        ),
      ),
    ),
  ),
),
          ],
        ),
      ),
    );
  }
}
Color getColorForStatus(String status) {
  return 
    status == 'GOOD' ? Colors.green : 
    status == 'ROUTINE' ? Colors.blue :
    status == 'WARNING' ? Colors.orange: 
    status == 'SUSPEND' ? Colors.yellow: 
    status == 'FATAL' ? Colors.red : 
    status == 'PROBLEM' ? Colors.purple : 
    status == 'NOT_CONFIGURE' ? Color.fromARGB(255, 112, 7, 0) :
    status == '0' ? Color.fromARGB(255, 0, 0, 0) :
    status == 'EMPTY' ? Colors.grey :
    status == 'LOW' ? Colors.amber : 
    status == 'FULL' ? Colors.greenAccent : 
  Color.fromARGB(255, 0, 0, 0);
}
