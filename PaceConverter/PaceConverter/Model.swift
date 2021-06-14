//
//  Model.swift
//  PaceConverter
//
//  Created by Martin Rist on 14/06/2021.
//

import Foundation

/// A custom `Dimension` to represent common paces for running or other forms of transport.
final class UnitPace: Dimension {
  override class func baseUnit() -> UnitPace { return minutesPerKilometer }
  static let minutesPerKilometer = UnitPace(symbol: "min/km", converter: UnitConverterLinear(coefficient: 1.0))
  static let minutesPerMile = UnitPace(symbol: "min/mi", converter: UnitConverterLinear(coefficient: 0.625))
}

extension Measurement where UnitType == UnitPace {

  /// Initialises the pace measurement with minutes and seconds per `unit`
  /// - Parameters:
  ///   - minutes: The number of minutes to travel the distance represented by `unit`
  ///   - seconds: The number of seconds to travel the distance represented by `unit`
  ///   - unit: The unit in which the pace is measured.
  init(minutes: Int, seconds: Int, unit: UnitPace) {
    let value = Double(minutes) + Double(seconds) / 60
    self.init(value: value, unit: unit)
  }

  /// The value of the measurement in integral minutes and seconds
  var value: (minutes: Int, seconds: Int) {
    let outputMinutes = Int(self.value)
    let outputSeconds = (self.value - Double(outputMinutes)) * 60
    return (minutes: Int(outputMinutes), seconds: Int(outputSeconds))
  }
}
