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

  let units = ["min/km", "min/mile"]

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
          Text("Not implemented")
        }
      }
      .navigationBarTitle("Pace Converter")
    }
  }

  fileprivate func makeUnitPickerSection(_ title: String, binding: Binding<Int>) -> some View {
    return Section(header: Text(title)) {
      Picker(title, selection: binding) {
        ForEach(0..<units.count) { index in
          Text(units[index])
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
