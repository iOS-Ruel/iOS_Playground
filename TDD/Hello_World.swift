#!/usr/bin/env xcrun swift

func main() {
    guard CommandLine.argc > 1 else {
        print("Hello, world!")
        return
    }
    print("Hello, \(CommandLine.arguments[1])")
}

main()
