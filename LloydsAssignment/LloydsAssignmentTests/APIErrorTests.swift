//
//  APIErrorTests.swift
//  LloydsAssignmentTests
//
//  Created by Ashutosh Kulkarni on 02/11/23.
//

import XCTest
import Combine
@testable import LloydsAssignment

class APIErrorTests: XCTestCase {

    func testLocalizedDescriptionForBadURL() {
        XCTAssertEqual(APIError.badURL.localizedDescription, "Sorry, something went wrong.")
    }

    func testLocalizedDescriptionForBadResponse() {
        XCTAssertEqual(APIError.badResponse(statusCode: 404).localizedDescription, "Sorry, the connection to our server failed.")
    }

    func testLocalizedDescriptionForURLError() {
        XCTAssertEqual(APIError.url(URLError(URLError.Code.badURL)).localizedDescription, "Something went wrong.")
    }

    func testLocalizedDescriptionForParsingError() {
        XCTAssertEqual(APIError.parsing(nil).description, "parsing error")
    }

    func testLocalizedDescriptionForUnknownError() {
        XCTAssertEqual(APIError.unknown.localizedDescription, "Sorry, something went wrong.")
    }

    func testDescriptionForBadURL() {
        XCTAssertEqual(APIError.badURL.description, "invalid URL")
    }

    func testDescriptionForBadResponse() {
        XCTAssertEqual(APIError.badResponse(statusCode: 500).description, "bad response with status code 500")
    }

    func testDescriptionForURLError() {
        XCTAssertEqual(APIError.url(URLError(URLError.Code.unknown)).description, "url session error")
    }

    func testDescriptionForParsingError() {
        let decodingError = DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Data corrupted."))
        XCTAssertEqual(APIError.parsing(decodingError).description, "parsing error")
    }

    func testDescriptionForUnknownError() {
        XCTAssertEqual(APIError.unknown.description, "unknown error")
    }
}
