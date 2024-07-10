
func test(value: String, matches expected: String) {
    if value == expected {
        print("PASSED value = \(value)")
    } else {
        print("FAILED value = \(value)")
    }
}


func fizzBuzz(_ number: Int) -> String{
    if number % 15 == 0 {
        return "fizz-buzz"
    } else if number % 3 == 0 {
        return "fizz"
    } else if number % 5 == 0 {
        return "buzz"
    }
    
    return "\(number)"
}

func testFizzBuzz() {
    test(value: fizzBuzz(1), matches: "1")
    test(value: fizzBuzz(3), matches: "fizz")
    test(value: fizzBuzz(5), matches: "buzz")
    test(value: fizzBuzz(15), matches: "fizz-buzz")
    test(value: fizzBuzz(7), matches: "7")
}

testFizzBuzz()
