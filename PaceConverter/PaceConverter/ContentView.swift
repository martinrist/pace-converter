//
//  ContentView.swift
//  PaceConverter
//
//  Created by Martin Rist on 14/06/2021.
//

import SwiftUI

struct ContentView: View {

  @State private var inputUnit = 0
  @State private var outputUnit = 1
  @State private var inputMinutes = 0
  @State private var inputSeconds = 0

  let units: [UnitPace] = [.minutesPerKilometer, .minutesPerMile]

  var inputSymbol: String { units[inputUnit].symbol }
  var outputSymbol: String { units[outputUnit].symbol }

  var outputPace: (minutes: Int, seconds: Int) {
    let inputPace = Measurement(minutes: inputMinutes, seconds: inputSeconds, unit: units[inputUnit])
    let outputPace = inputPace.converted(to: units[outputUnit])
    return outputPace.value
  }

  var body: some View {
    NavigationView {
      Form {
        makeUnitPickerSection("Input Unit", binding: $inputUnit)
        makeUnitPickerSection("Output Unit", binding: $outputUnit)

        Section(header: Text("Input Value")) {
          GeometryReader { geometry in
            HStack {
              makeValuePicker("Minutes", maxValue: 20,
                              width: geometry.size.width / 2, height: 200,
                              binding: $inputMinutes)

              makeValuePicker("Seconds", maxValue: 60,
                              width: geometry.size.width / 2, height: 200,
                              binding: $inputSeconds)
            }
          }
          .frame(minHeight: 200)
        }

        Section(header: Text("Result")) {
          Text("""
            \(inputMinutes):\(inputSeconds, specifier: "%02d") \(inputSymbol) = \
            \(outputPace.minutes):\(outputPace.seconds, specifier: "%02d") \(outputSymbol)
            """)
        }
      }
      .navigationBarTitle("Pace Converter")
    }
  }

  fileprivate func makeUnitPickerSection(_ title: String, binding: Binding<Int>) -> some View {
    return Section(header: Text(title)) {
      Picker(title, selection: binding) {
        ForEach(0..<units.count) { index in
          Text("\(units[index].symbol)")
        }
      }
      .pickerStyle(SegmentedPickerStyle())
    }
  }

  fileprivate func makeValuePicker(_ title: String, maxValue: Int, width: CGFloat, height: CGFloat, binding: Binding<Int>) -> some View {
    return Picker(title, selection: binding) {
      ForEach(0..<maxValue) {
        Text("\($0)")
      }
    }
    .pickerStyle(WheelPickerStyle())
    .frame(width: width, height: height, alignment: .center)
    .clipped()
  }

}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
