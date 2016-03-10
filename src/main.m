#include <stdio.h>

@import JavaScriptCore;

int main(int argc, char** argv) {
  if (argc != 3) {
    fprintf(stderr,
            "usage: %s <browserfied-file> <script>\n"
            "  e.g. %s my-library.js \"library.foo(42)\"", argv[0], argv[0]);
    return -1;
  }

  JSContext* context = [JSContext new];

  [context setExceptionHandler:^(JSContext* context, JSValue* value) {
      NSLog(@"%@", value);
    }];

  NSString* file = [NSString stringWithUTF8String: argv[1]];
  NSString* content =
    [NSString stringWithContentsOfFile: file
                              encoding: NSUTF8StringEncoding
                                 error: nil];

  [context evaluateScript: content];

  NSLog(@"result is %@",
        [context evaluateScript: [NSString stringWithUTF8String: argv[2]]]);

  return 0;
}
