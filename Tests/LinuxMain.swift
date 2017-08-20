#if os(Linux)

import XCTest
@testable import HTTPTests
@testable import TCPTests

XCTMain([
	// MARK: HTTP
    testCase(ParserTests.allTests),

    // MARK: TCP
    testCase(SocketsTests.allTests),
])

#endif