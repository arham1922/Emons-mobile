
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_application_1/app/API.dart';
import 'package:flutter_application_1/views/SuplayIssue/empty.dart';
import 'package:flutter_application_1/views/SuplayIssue/low.dart';
import 'package:flutter_application_1/views/SuplayIssue/full.dart';
import 'package:flutter_application_1/views/SuplayIssue/good.dart';
import 'package:flutter_application_1/views/HardwareIssue/fatal.dart';
import 'package:flutter_application_1/views/HardwareIssue/warning.dart';
import 'package:flutter_application_1/views/Host/SignOn.dart';
import 'package:flutter_application_1/views/Host/SignOff.dart';
import 'package:flutter_application_1/views/Host/Down.dart';
import 'package:flutter_application_1/views/StatusTerminal/InService.dart';
import 'package:flutter_application_1/views/StatusTerminal/ServiceUp.dart';
import 'package:flutter_application_1/views/StatusTerminal/OutService.dart';
import 'package:flutter_application_1/views/StatusTerminal/Offline.dart';
import 'package:flutter_application_1/views/notification.dart';
import 'package:flutter_application_1/views/login.dart';
import 'package:flutter_application_1/views/profile/profile.dart';
import 'package:flutter_application_1/views/ticket%20CM/ticketingCM.dart';
import 'package:flutter_application_1/views/ticket/ticketing.dart';

import 'package:flutter_application_1/views/utils.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<HostData> status;
  Api api = Api();
  DashboardApi dashboardApi = DashboardApi();
  HostApi hostApi = HostApi();
  

  String username = '';
  String email = '';
  double inServicePercentage = 0;
  double serviceUpPercentage = 0;
  double outServicePercentage = 0;
  double offlinePercentage = 0;
  String inServiceCount = '';
  String serviceUpCount = '';
  String outServiceCount = '';
  //host
  String offline = '';
  String signON = '';
  String signOff = '';
  String down = '';
  //supplyissue
  String empty = '';
  String low = '';
  String full = '';
  String good = '';
  //hardware issue
  String fatal = '';
  String warning = '';

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchDashboardData();
    fetchHostData();
    status = HostApi().fetchHostApi(); 
  }

  void fetchData() async {
    final data = await api.fetchData();

    setState(() {
      username = data['username'] ?? '';
      email = data['email'] ?? '';
    });
  }

void fetchHostData() async {
  final hostData = await hostApi.fetchHostApi();

  setState(() {
    signON = hostData.signON;
    signOff = hostData.signOff;
    down = hostData.down;
  });
}

  void fetchDashboardData() async {
    final dashboardData = await dashboardApi.fetchDashboardData();

    setState(() {
      inServiceCount = dashboardData['inServiceCount'].toString();
      serviceUpCount = dashboardData['serviceUpCount'].toString();
      outServiceCount = dashboardData['outServiceCount'].toString();
      offline = dashboardData['offline'].toString();
      //supply issue
      empty = dashboardData['empty'].toString();
      low = dashboardData['low'].toString();
      full = dashboardData['full'].toString();
      good = dashboardData['good'].toString();
      //hardware issue
      fatal = dashboardData['fatal'].toString();
      warning = dashboardData['warning'].toString();

      final totalTerminals = double.parse(inServiceCount) +
          double.parse(serviceUpCount) +
          double.parse(outServiceCount) +
          double.parse(offline);

      inServicePercentage = double.parse(inServiceCount) / totalTerminals;
      serviceUpPercentage = double.parse(serviceUpCount) / totalTerminals;
      outServicePercentage = double.parse(outServiceCount) / totalTerminals;
      offlinePercentage = double.parse(offline) / totalTerminals;
    });
  }

 void fetchHostApi() async {
  final HostData hostData = await hostApi.fetchHostApi();

  setState(() {
    signON = hostData.signON.toString();
    signOff = hostData.signOff.toString();
    down = hostData.down.toString();
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                drawer: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      UserAccountsDrawerHeader(
                        accountName: Text (username,style: MyTextStyles.style10),
                        accountEmail: Text(email,style: MyTextStyles.style11),
                        currentAccountPicture: CircleAvatar(
                          child: ClipOval(
                            child: Image(
                              image: AssetImage('assets/icon/user2.jpg'),
                              fit: BoxFit.cover,
                              width: 90,
                              height: 90,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/logo/header.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ListTile(leading: Icon(Icons.home), title: Text("Beranda"),
                    onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomePage(),));},),
                    ListTile( leading: Icon(Icons.confirmation_number), title: Text("Ticketing"), 
                    onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TicketingPage(),));},), 
                    ListTile( leading: Icon(Icons.account_circle), title: Text("Profil"), 
                    onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfilePage()));},), 
                    ListTile( leading: Icon(Icons.info), title: Text("Tentang"), 
                    onTap: (){},),
                    Divider(),ListTile(title: Text('Exit'),leading: Icon(Icons.exit_to_app),
                    onTap: () {showDialog(context: context,builder: (BuildContext context) {
                    return AlertDialog(
                    title: Text('Konfirmasi Keluar !!'),
                    content: Text('Anda yakin ingin keluar dari aplikasi?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {Navigator.of(context).pop();  },child: Text('Batal'),  ),
                      TextButton(
                        onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage())); },
                      
                        child: Text('Keluar'),
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo/BackgroundHeader.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
               
        //container besar 
                    Stack(
                      children: [
                        const Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 110),
                              Text(
                                'e-Monitoring',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  height: 0.04,
                                  letterSpacing: 2.50,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 85,
                          right: 20,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const NotifPage(),
                              ));
                            },
                            child: Icon(
                              Icons.notifications,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 80,
                          left: 10,
                          child: Builder(
                            builder: (context) => IconButton(
                              icon: Image.asset('assets/icon/menu.png'),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          top: 175,
                          left: 35,
                          child: Container(
                            width: 327,
                            height: 197,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [MyBoxShadows.boxshadow2],
                            ),
                          ),
                        ),

                      //pie chart
                        Positioned(
                        top: 270, 
                        left: 100, 
                        child: SizedBox(
                          width: 20, 
                          height: 20, 
                          child: PieChart(
                            PieChartData(
                              sectionsSpace: 1,
                              centerSpaceRadius: 20, 
                              sections: [
                                PieChartSectionData(
                                  value: outServicePercentage, 
                                  color: const Color(0xFFF2B53E), 
                                  showTitle: false,
                                ),
                                PieChartSectionData(
                                  value: offlinePercentage, 
                                  color: const Color(0xFFE03232),
                                  showTitle: false,
                                ),
                                PieChartSectionData(
                                  value:inServicePercentage, 
                                  color: const Color(0xFF61E540), 
                                  showTitle: false,
                                ),
                                PieChartSectionData(
                                  value: serviceUpPercentage, 
                                  color: const Color(0xFF3763FF),
                                  showTitle: false,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                  // "In Service"
                    Positioned(
                      left: 200,
                      top: 222,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const InServicePage(),
                          ));
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 13,
                              height: 13,
                              decoration: const ShapeDecoration(
                                color: Color(0xFF61E540),
                                shape: CircleBorder(),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'In Service',
                              style: MyTextStyles.style3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  Positioned(
                  right: 60,
                  top: 222,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const InServicePage(),
                      ));
                    },
                    child: Container(
                      width: 25.64,
                      height: 21,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 2,
                            child: Container(
                              width: 25.64,
                              height: 17,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [MyBoxShadows.boxshadow1],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 9.10,
                            top: 0,
                            child: Text(
                              inServiceCount,
                              style: MyTextStyles.style1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                

//Service Up
                  Positioned(
                    left: 200,
                    top: 251,
                    child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ServiceUpPage(),
                      ));
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 13,
                          height: 13,
                          decoration: const ShapeDecoration(
                            color: Color(0xFF3763FF),
                            shape: CircleBorder(),
                          ),
                        ),

                        const SizedBox(width: 8), 
                        const Text(
                          'Service Up',
                          style: MyTextStyles.style3,
                        ),
                      ],
                    ),
                  ),
                ),
                   Stack(
                    children: [
                      Positioned(
                        right: 60,
                        top: 251, 
                        child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>  ServiceUpPage(),
                          ));
                        },
                        child: Container(
                          width: 25.64,
                          height: 21,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 2,
                                child: Container(
                                  width: 25.64,
                                  height: 17,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: const [MyBoxShadows.boxshadow1],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 9.10,
                                top: 0,
                                child: Text(
                                  serviceUpCount,
                                  style: MyTextStyles.style1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),


//Out Service

                  Positioned(
                    left: 200,
                    top: 280,
                    child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const OutServicePage(),
                      ));
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 13,
                          height: 13,
                          decoration: const ShapeDecoration(
                            color: Color(0xFFF2B53E),
                            shape: CircleBorder(),
                          ),
                        ),

                        const SizedBox(width: 8), 
                        const Text(
                          'Out Service',
                          style: MyTextStyles.style3,
                        ),
                      ],
                    ),
                  ),
                  ),
                   Stack(
                    children: [
                      Positioned(
                        right: 60,
                        top: 280, 
                        child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const OutServicePage(),
                          ));
                        },
                        child: Container(
                          width: 25.64,
                          height: 21,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 2,
                                child: Container(
                                  width: 25.64,
                                  height: 17,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: const [MyBoxShadows.boxshadow1],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 9.10,
                                top: 0,
                                child: Text(
                                  outServiceCount,
                                  style: MyTextStyles.style1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),


//Offline

                  Positioned(
                    left: 200,
                    top: 308,
                     child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const OfflinePage(),
                      ));
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 13,
                          height: 13,
                          decoration: const ShapeDecoration(
                            color: Color(0xFFE03232),
                            shape: CircleBorder(),
                          ),
                        ),

                        const SizedBox(width: 8), 
                        const Text(
                          'Offline',
                          style: MyTextStyles.style3,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
                    Stack(
                    children: [
                      Positioned(
                        right: 60,
                        top: 308, 
                        child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const OfflinePage(),
                          ));
                        },
                        child: Container(
                          width: 25.64,
                          height: 21,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 2,
                                child: Container(
                                  width: 25.64,
                                  height: 17,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: const [MyBoxShadows.boxshadow1],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 9.10,
                                top: 0,
                                child: Text(
                                  offline,
                                  style: MyTextStyles.style1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ), 
                    ),
                  ],
                ),
          // Host
          const Positioned(
            top: 385,
            left: 30,
            child: Text(
              'Host :',
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Poppins",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // SignOn
          Stack(
            children: [
              Positioned(
                top: 427,
                left: 70,
                child:  GestureDetector(
        onTap: () { {Navigator.of(context).push(MaterialPageRoute(  builder: (context) => SignOnPage(status: '1'),));};},
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3DD34C),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      Text(
                        signON,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
              const Positioned(
                top: 491,
                left: 70,
                child: Column(
                  children: [
                    Text(
                      'Sign On',
                      style: TextStyle(
                        color: Color(0xFF3DD34C),
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // SignOff
          Stack(
            children: [
              Positioned(
                top: 427,
                right: 170,
                child: GestureDetector(
                  onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignOffPage(status: '4'), ));},
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFA913B),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      Text(
                        signOff,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
              const Positioned(
                top: 491,
                right: 170,
                child: Column(
                  children: [
                    Text(
                      'Sign Off',
                      style: TextStyle(
                        color: Color(0xFFFA913B),
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Down
          Stack(
            children: [
              Positioned(
                top: 427,
                right: 70,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DownPage(status: '3')));
                  },
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF0000),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      Text(
                        down,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
              const Positioned(
                top: 491,
                right: 77,
                child: Column(
                  children: [
                    Text(
                      'Down',
                      style: TextStyle(
                        color: Color(0xFFFF0000),
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              
              

          // Terminal
          const Positioned(
            top: 520,
            left: 30,
            child: Text(
              'Terminal :',
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Poppins",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Supply Issue
          Stack(
            children: [
              Positioned(
                top: 570,
                left: 20,
                child: Container(
                  width: 160,
                  height: 164,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [MyBoxShadows.boxshadow2],
                  ),
                  child: const Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'Supply Issue',
                        style: MyTextStyles.style2,
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              //Empty

              Positioned(
                top: 614,
                left: 35,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EmptyPage()));
                  },
                  child: Container(
                    width: 123.08,
                    height: 21,
                    child: Stack(
                      children: [
                        const Positioned(
                          left: 0,
                          top: 2,
                          child: SizedBox(
                            width: 69.74,
                            child: Text(
                              'Empty',
                               style: MyTextStyles.style1,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 97.44,
                          top: 0,
                          child: Container(
                            width: 25.64,
                            height: 21,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 2,
                                  child: Container(
                                    width: 25.64,
                                    height: 17,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                      shadows: const [MyBoxShadows.boxshadow1],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 9.10,
                                  top: 0,
                                  child: Text(
                                    empty,
                                    style: MyTextStyles.style1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),


              //Low

              Positioned(
                top: 643, 
                left: 35, 
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  LowPage()));
                  },
                child: Container(
                  width: 123.08,
                  height: 21,
                  child: Stack(
                    children: [
                      const Positioned(
                        left: 0,
                        top: 2,
                        child: SizedBox(
                          width: 69.74,
                          child: Text(
                            'Low',
                           style: MyTextStyles.style1,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 97.44,
                        top: 0,
                        child: Container(
                          width: 25.64,
                          height: 21,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 2,
                                child: Container(
                                  width: 25.64,
                                  height: 17,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    shadows: const [MyBoxShadows.boxshadow1],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 9.10,
                                top: 0,
                                child: Text(
                                  low,
                                  style: MyTextStyles.style1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

              //Full

              Positioned(
                top: 670, 
                left: 35, 
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FullPage()));
                  },
                child: Container(
                  width: 123.08,
                  height: 21,
                  child: Stack(
                    children: [
                      const Positioned(
                        left: 0,
                        top: 2,
                        child: SizedBox(
                          width: 69.74,
                          child: Text(
                            'Full',
                            style: MyTextStyles.style1,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 97.44,
                        top: 0,
                        child: Container(
                          width: 25.64,
                          height: 21,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 2,
                                child: Container(
                                  width: 25.64,
                                  height: 17,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    shadows: const [MyBoxShadows.boxshadow1],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 9.10,
                                top: 0,
                                child: Text(
                                  full,
                                  style: MyTextStyles.style1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ), 

              //Good

              Positioned(
                top: 697, 
                left: 35,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => GoodPage()));}, 
                child: Container(
                  width: 123.08,
                  height: 21,
                  child: Stack(
                    children: [
                      const Positioned(
                        left: 0,
                        top: 2,
                        child: SizedBox(
                          width: 69.74,
                          child: Text(
                            'Good',
                            style: MyTextStyles.style1,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 97.44,
                        top: 0,
                        child: Container(
                          width: 25.64,
                          height: 21,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 2,
                                child: Container(
                                  width: 25.64,
                                  height: 17,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    shadows: const [MyBoxShadows.boxshadow1],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 9.10,
                                top: 0,
                                child: Text(
                                  good,
                                  style: MyTextStyles.style1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ],
          ),
          
          
           // Hardware Issue
          Stack(
            children: [
              Positioned(
                top: 570,
                right: 20,
                child: Container(
                  width: 160,
                  height: 164,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [MyBoxShadows.boxshadow2],
                  ),
                  child: const Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'Hardware Issue',
                        style: MyTextStyles.style2,
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              //Fatal

              Positioned(
                top: 616, 
                right: 40, 
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FatalPage()));
                  },
                child: Container(
                  width: 123.08,
                  height: 21,
                  child: Stack(
                    children: [
                      const Positioned(
                        left: 0,
                        top: 2,
                        child: SizedBox(
                          width: 69.74,
                          child: Text(
                            'Fatal',
                            style: MyTextStyles.style1,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 97.44,
                        top: 0,
                        child: Container(
                          width: 25.64,
                          height: 21,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 2,
                                child: Container(
                                  width: 25.64,
                                  height: 17,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    shadows: const [MyBoxShadows.boxshadow1],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 9.10,
                                top: 0,
                                child: Text(
                                  fatal,
                                  style: MyTextStyles.style1,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

              //Warning

              Positioned(
                top: 642, 
                right: 40, 
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const WarningPage()));
                  },
                child: Container(
                  width: 123.08,
                  height: 21,
                  child: Stack(
                    children: [
                      const Positioned(
                        left: 0,
                        top: 2,
                        child: SizedBox(
                          width: 69.74,
                          child: Text(
                            'Warning',
                            style: MyTextStyles.style1,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 97.44,
                        top: 0,
                        child: Container(
                          width: 25.64,
                          height: 21,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 2,
                                child: Container(
                                  width: 25.64,
                                  height: 17,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    shadows: const [MyBoxShadows.boxshadow1],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 9.10,
                                top: 0,
                                child: Text(
                                  warning,
                                  style: MyTextStyles.style1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
             ),
            ],
          ),
           // Navbar Bawah
Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIcon(Icons.home, "Home", () {
                }),
                _buildIcon(Icons.confirmation_number, "PM", () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => TicketingPage()));
                }),
                _buildIcon(Icons.description, "CM", () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => TicketingCMPage()));
                }),
                _buildIcon(Icons.person, "Profile", () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage()));
                }),
              ],
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
Widget _buildIcon(IconData icon, String label, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          width: 64,
          height: 64,
          padding: const EdgeInsets.all(5),
          child: Icon(
            icon,
            color: Colors.grey,
            size: 35,
          ),
        ),
        SizedBox(height: 0), 
        Text(
          label,
          style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}
