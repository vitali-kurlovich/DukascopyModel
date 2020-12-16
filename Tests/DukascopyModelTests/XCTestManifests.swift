import XCTest

#if !canImport(ObjectiveC)
    public func allTests() -> [XCTestCaseEntry] {
        [
            testCase(DukascopyModelTests.allTests),
        ]
    }
#endif
