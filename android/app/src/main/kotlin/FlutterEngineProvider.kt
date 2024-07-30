//package ba.vaktija.android
//
//import android.content.Context
//import io.flutter.embedding.engine.FlutterEngine
//import io.flutter.embedding.engine.dart.DartExecutor
//
//object FlutterEngineProvider {
//    private var flutterEngine: FlutterEngine? = null
//
//    fun getInstance(context: Context): FlutterEngine {
//        if (flutterEngine == null) {
//            flutterEngine = FlutterEngine(context).apply {
//                // Start executing Dart code to pre-warm the FlutterEngine.
//                dartExecutor.executeDartEntrypoint(
//                    DartExecutor.DartEntrypoint.createDefault()
//                )
//            }
//        }
//        return flutterEngine!!
//    }
//}
