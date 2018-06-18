# CommandHandler
Handling commands using Dart.

# Information
This is ofcourse not ready. I was writing this to use with TeleDart, and thought to post it in case somebody needed it.  
  
It's to serve as a basic introduction to handling commands using Dart. Feel free to use it as you wish.

# Usage
```dart
import 'Commands.dart';
class Test extends Command {
  Test() : super("test","Testing a command", "/test");
  
  @override
  run(dynamic message) async {
    print("Hello!");
  }
}

main(){
  new Commands(/* params */).addMany( [ new Test() ] );
}```
