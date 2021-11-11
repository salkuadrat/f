import 'package:f/emulators.dart';
import 'package:f/f.dart';

void main(List<String> args) {
  if (args.isNotEmpty) {
    final cmd = args.first;

    switch (cmd) {
      case "c":
        create(args);
        return;
      case "a":
        analyze(args);
        return;
      case "as":
        assemble(args);
        return;
      case "at":
        attach(args);
        return;
      case "b":
        build(args);
        return;
      case "bs":
        buildSplitPerAbi(args);
        return;
      case "ch":
        channel(args);
        return;
      case "dev":
        devices(args);
        return;
      case "doc":
        doctor();
        return;
      case "down":
        downgrade();
        return;
      case "drv":
        drive();
        return;
      case "e":
        emulators();
        return;
      case "f":
        format(args);
        return;
      case "i":
        install(args);
        return;
      case "l":
        logs();
        return;
      case "r":
        run(args);
        return;
      case "rp":
        runProfile(args);
        return;
      case "rr":
        runRelease(args);
        return;
      case "t":
        test(args);
        return;
      case "up":
        upgrade();
        return;
    }
  }

  _error();
}

void _error() {
  print('Please use a correct f command');
  print('');
}
