//
//  DeviceOrientationEnvironmentProvider.swift
//  Example
//
//  Created by Vincent Cheung on 2/4/2022.
//

import SwiftUI

private struct DeviceOrientationEnvironmentKey: EnvironmentKey {
  static let defaultValue = UIDeviceOrientation.unknown
}

extension EnvironmentValues {
  public var deviceOrientation: UIDeviceOrientation {
    get {
      self[DeviceOrientationEnvironmentKey.self]
    }
    set {
      self[DeviceOrientationEnvironmentKey.self] = newValue
    }
  }
}

public struct DeviceOrientationEnvironmentProvider<Content>: View where Content: View {
  private let content: () -> Content
  @State private var deviceOrientation: UIDeviceOrientation = .unknown
  
  public init(@ViewBuilder content: @escaping () -> Content) {
    self.content = content
  }
  
  public var body: some View {
    content()
      .onReceive(
        NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
      ) { _ in
        deviceOrientation = UIDevice.current.orientation
      }
      .environment(\.deviceOrientation, deviceOrientation)
  }
}

struct DeviceOrientationEnvironmentProvider_Previews: PreviewProvider {
  static var previews: some View {
    DeviceOrientationEnvironmentProvider {
      EmptyView()
    }
  }
}
