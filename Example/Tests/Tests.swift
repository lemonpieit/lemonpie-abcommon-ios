import XCTest
@testable import ABcommon

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Number+XT
    
    func testIntToDouble() {
        let int: Int = 3
        let double = int.toDouble()
        XCTAssertEqual(String(double), "3.0")
    }
    
    func testIntToString() {
        let int: Int = 3
        let string = int.toString()
        XCTAssertEqual(string, "3")
    }

    func testDoubleToInt() {
        let double: Double = 3.12
        let int = double.toInt()
        XCTAssertEqual(String(int), "3")
    }
    
    func testDoubleToString() {
        let double: Double = 3.12
        let string = double.toString()
        XCTAssertEqual(string, "3.12")
    }

    // MARK: - String+XT
    
    func testSanitized() {
        let string = "  Ciao   "
        let sanitizedString = string.sanitized()
        XCTAssertEqual(sanitizedString, "Ciao")
    }

    func testSanitizedEmptyString() {
        let string = "     "
        XCTAssertThrowsError(try string.sanitizedNonEmpty()) { error in
            let error = error as! SanitizedError
            XCTAssertEqual(error, .isEmpty)
        }
    }

    func testSanitizedNonEmptyString() {
        let string = "  Ciao   "
        XCTAssertNoThrow(try string.sanitizedNonEmpty())
    }
    
    func testCondensedSpace() {
        let string = "  Ciao   come  va?"
        let condensedString = string.condenseWhitespace()
        XCTAssertEqual(condensedString, "Ciao come va?")
    }
    
    func testGetInitials() {
        let string = "Ciao come va?"
        let initials = string.getInitials()
        XCTAssertEqual(initials, "Ccv")
    }

}
