import XCTest
@testable import CrashProbe

final class CrashProbeTests: XCTestCase {
    func testExample() throws {
        XCTAssertNotNil(CRLCrash.crashes())
    }
}
