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
        makeUnitPickerSection(title: "Input Unit", binding: $inputUnit)
        makeUnitPickerSection(title: "Output Unit", binding: $outputUnit)

        Section(header: Text("Input Value")) {
          GeometryReader { geometry in
            HStack {
              Picker("Minutes", selection: $inputMinutes) {
                ForEach(0..<20) {
                  Text("\($0)")
                }
              }
              .pickerStyle(WheelPickerStyle())
              .frame(width: geometry.size.width / 2, height: 200, alignment: .center)
              .clipped()

              Picker("Seconds", selection: $inputSeconds) {
                ForEach(0..<60) {
                  Text("\($0)")
                }
              }
              .pickerStyle(WheelPickerStyle())
              .frame(width: geometry.size.width / 2, height: 200, alignment: .center)
              .clipped()
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

  fileprivate func makeUnitPickerSection(title: String, binding: Binding<Int>) -> some View {
    return Section(header: Text(title)) {
      Picker(title, selection: binding) {
        ForEach(0..<units.count) { index in
          Text(units[index])
        }
      }
      .pickerStyle(SegmentedPickerStyle())
    }
  }

}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
