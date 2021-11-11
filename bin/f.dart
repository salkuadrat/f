import 'package:f/emulators.dart';
import 'package:f/f.dart';

main(List<String> args) async {
  if (args.isNotEmpty) {
    final cmd = args.first;

    switch (cmd) {
      case "c":
        return await create(args);
      case "a":
        return await analyze(args);
      case "as": 
        return await assemble(args);
      case "at": 
        return await attach(args);
      case "b":
        return await build(args);
      case "bs": 
        return await buildSplitPerAbi(args);
      case "ch": 
        return await channel(args);
      case "dev": 
        return await devices(args);
      case "doc": 
        return await doctor();
      case "down": 
        return await downgrade();
      case "drv": 
        return await drive();
      case "e": 
        return await emulators();
      case "f": 
        return await format(args);
      case "i": 
        return await install(args); 
      case "l": 
        return await logs();
      case "r": 
        return await run(args);
      case "rp": 
        return await runProfile(args);
      case "rr": 
        return await runRelease(args);
      case "t": 
        return await test(args);
      case "up": 
        return await upgrade();
      default:
        break;
    }
  }

  _error();
}

void _error() {
  print('Please use a correct f command');
  print('');
}