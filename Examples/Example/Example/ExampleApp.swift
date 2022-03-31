//
//  ExampleApp.swift
//  Shared
//
//  Created by Vincent Cheung on 31/3/2022.
//

import SwiftUI

@main
struct ExampleApp: App {
  var body: some Scene {
    WindowGroup {
      DeviceOrientationEnvironmentProvider {
        ContentView()
      }
    }
  }
}
