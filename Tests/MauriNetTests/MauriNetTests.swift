import XCTest
@testable import MauriNet

final class MauriNetTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(MauriNet().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
