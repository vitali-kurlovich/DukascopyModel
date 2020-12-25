import XCTest

#if !canImport(ObjectiveC)
    public func allTests() -> [XCTestCaseEntry] {
        [
            testCase(TicksContainerTest.allTests),
            testCase(TicksContainerMergeTest.allTests),
        ]
    }
#endif
