//
//  ModelTests.swift
//  PaceConverterTests
//
//  Created by Martin Rist on 14/06/2021.
//

import XCTest
@testable import PaceConverter

class ModelTests: XCTestCase {

  func testBasicConversion() {
    let fiveMinuteKm = Measurement(value: 5, unit: UnitPace.minutesPerKilometer)
    let converted = fiveMinuteKm.converted(to: .minutesPerMile)

    XCTAssertEqual(converted.value, 8.0)
  }

}
