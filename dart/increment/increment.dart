import "package:ini/ini.dart";
import "dart:io";

void main() {
    File file = new File("etc/main.conf");
    file.readAsLines()
        .then((lines) => new Config.fromStrings(lines))
        .then((Config config) => {print(config)});
//    new File("config.ini").readAsLines()
//        .then((lines) => new Config.fromStrings(lines))
//    .then((Config config) => ...);
    final now = DateTime.now();
    double i = 0.0;
    double finale = 100000000;
    double step = finale / 10;

    while (i < finale) {
        i = i+1;
        if (i % step == 1) {
            print("\r ${i/finale*100}%");
        }
    }
    print("\n ${i.toString()} end\n");
    print(config)
}


