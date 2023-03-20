// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:template/di_container.dart';
// import 'package:template/sharedpref/shared_preference_helper.dart';

// import '../sharedpref/shared_preference_helper.dart';

// class SocketIO {
//   final IO.Socket socket = IO.io(
//       'wss://s31giaibaitap.izisoft.io/',
//       IO.OptionBuilder()
//           .setTransports(['websocket']) // for Flutter or Dart VM
//           .setExtraHeaders({'authorization': 'Bearer ${sl.get<SharedPreferenceHelper>().getJwtToken}'}) // headers
//           .enableAutoConnect()
//           .build());

//   ///
//   /// _init
//   ///
//   void init() {
//     if (socket.disconnected) {
//       socket.connect();
//       socket.onConnect(
//         (_) {
//           print("socket connect");
//         },
//       );
//     }
//   }
// }
