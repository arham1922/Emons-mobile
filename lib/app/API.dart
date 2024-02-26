import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  final String baseUrl =
      '10.10.7.241:10521/emware-ws-sams/rr';

  Future<Map<String, String>> fetchData() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final userData = responseData['data']['usermap'];

        if (userData != null) {
          final userName = userData['usernm'];
          final userEmail = userData['email'];

          return {'username': userName, 'email': userEmail};
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while fetching data: $e');
    }
    return {'username': 'Error', 'email': 'Error'};
  }
}

//API Terminal

class DashboardApi {
  final String baseUrl =
      'http://10.10.7.9:8083/emon-ws/emonmbl/dashboardterm';

  Future<Map<String, dynamic>> fetchDashboardData() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final inServiceCount = responseData['nTermInService'];
        final serviceUpCount = responseData['nTerminalServiceUp'];
        final outServiceCount = responseData['nTermOutService'];
        final offline = responseData['nTerminalServiceDown'];
        //Supply Issue
        final empty = responseData['nTermSupplyEmpty'];
        final low = responseData['nTermSupplyLow'];
        final full = responseData['nTermSupplyFull'];
        final good = responseData['nTermSupplyGood'];
        //Hardware Issue
        final fatal = responseData['nTermHwFatalError'];
        final warning = responseData['nTermHwWarning'];

        return {
          'inServiceCount': inServiceCount.toString(),
          'serviceUpCount': serviceUpCount.toString(),
          'outServiceCount': outServiceCount.toString(),
          'offline': offline.toString(),
          
          //supply issue
          'empty': empty.toString(),
          'low': low.toString(),
          'full': full.toString(),
          'good': good.toString(),
          //Hardware Issue
          'fatal': fatal.toString(),
          'warning': warning.toString(),
        };
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle other types of errors such as network issues
      print('Error while fetching data: $e');
    }

    return {
      'inServiceCount': 'Error',
      'serviceUpCount': 'Error',
      'outServiceCount': 'Error',
      'offline': 'Error',
      //supply issue
      'empty': 'Error',
      'low': 'Error',
      'full': 'Error',
      'good': 'Error',
      //hardware issue
      'fatal': 'Error',
      'warning': 'Error',
    };
  }
}


//API Host



// class HostApi {
//   final String baseUrl;

//   HostApi(this.baseUrl);

//   Future<List<Map<String, dynamic>>?> fetchHostApi() async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/emon-ws/emonmbl/dashboardhost'));

//       if (response.statusCode == 200) {
//         // ignore: unnecessary_null_comparison
//         if (response.body != null) {
//           final dynamic decodedResponse = jsonDecode(response.body);

//           if (decodedResponse is List<dynamic>) {
//             final List<dynamic> dataList = decodedResponse;

//             List<Map<String, dynamic>> data = [];

//             for (var entry in dataList) {
//               final int status = entry['status'];
//               final String description = entry['description']?.toString() ?? '';
//               final int count = entry['count'];

//               data.add({
//                 'status': status,
//                 'description': description,
//                 'count': count,
//               });
//             }

//             return data;
//           } else {
//             print('Error: Response body is not a List<dynamic>.');
//             return null;
//           }
//         } else {
//           print('Error: Response body is null.');
//           return null;
//         }
//       } else {
//         throw Exception('Gagal mengambil data: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       print('Error accessing API: $e');
//       return null;
//     }
//   }

//   Future<int?> getCountForStatus(int status) async {
//     final List<Map<String, dynamic>>? data = await fetchHostApi();

//     if (data != null) {
//       for (var entry in data) {
//         if (entry['status'] == status) {
//           return entry['count'];
//         }
//       }
//     }

//     return null;
//   }
// }


class HostApi {
  final String baseUrl =
      'http://10.10.7.9:8083/emon-ws/emonmbl/dashboardhost';


  Future<HostData> fetchHostApi() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);

        if (responseData.isNotEmpty) {
          String signON = responseData
              .firstWhere((data) => data['description'] == 'Sign On')['count']
              .toString();
          String signOff = responseData
              .firstWhere((data) => data['description'] == 'Sign Off')['count']
              .toString();
          String down = responseData
              .firstWhere((data) => data['description'] == 'Offline')['count']
              .toString();
          int signOnStatus = responseData
              .firstWhere((data) => data['description'] == 'Sign On')['status'];
          int signOffStatus = responseData
              .firstWhere((data) => data['description'] == 'Sign Off')['status'];
          int downStatus = responseData
              .firstWhere((data) => data['description'] == 'Offline')['status'];

          return HostData(
            signON: signON,
            signOff: signOff,
            down: down,
            signOnStatus: signOnStatus.toString(),
            signOffStatus: signOffStatus.toString(),
            downStatus: downStatus.toString(),
          );
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while fetching data: $e');
    }

    return HostData(
      signON: 'Error',
      signOff: 'Error',
      down: 'Error',
      signOnStatus: 'Error',
      signOffStatus: 'Error',
      downStatus: 'Error',
    );
  }
}

class HostData {
  final String signON;
  final String signOff;
  final String down;
  final String signOnStatus;
  final String signOffStatus;
  final String downStatus;

  HostData({
    required this.signON,
    required this.signOff,
    required this.down,
    required this.signOnStatus,
    required this.signOffStatus,
    required this.downStatus,
  });
}



//

// class HostApi {
//   final String baseUrl =
//       'http://10.10.7.9:8083/emon-ws/emonmbl/dashboardhost';

//   Future<Map<String, String>> fetchStatus() async {
//     try {
//       final response = await http.get(Uri.parse(baseUrl));

//       if (response.statusCode == 200) {
//         final List<dynamic> responseData = json.decode(response.body);

//         if (responseData.isNotEmpty) {
//           final signON = responseData.firstWhere(
//               (data) => data['status'] == 1,
//               orElse: () => {'count': 0})['count'].toString();
//           final signOff = responseData.firstWhere(
//               (data) => data['status'] == 4,
//               orElse: () => {'count': 0})['count'].toString();
//           final down = responseData.firstWhere(
//               (data) => data['status'] == 3,
//               orElse: () => {'count': 0})['count'].toString();

//           return {'signON': signON, 'signOff': signOff, 'down': down};
//         }
//       } else {
//         print('Failed to load data. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error while fetching data: $e');
//     }

//     return {'signON': 'Error', 'signOff': 'Error', 'down': 'Error'};
//   }
// }
