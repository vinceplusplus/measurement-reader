import SwiftUI

internal struct ScopedMeasurementPreferenceKey<Scope, Tag>: PreferenceKey where Tag: Hashable {
  static var defaultValue: Value {
    .init(
      version: DefaultInitialMeasurementVersion(),
      maxSizes: [:]
    )
  }
  
  static func reduce(value: inout Value, nextValue getNextValue: () -> Value) {
    let nextValue = getNextValue()
    
    value.version = nextValue.version != .init(DefaultInitialMeasurementVersion())
    ? nextValue.version
    : value.version
    
    for (nextTag, nextSize) in nextValue.maxSizes {
      let currentSize = value.maxSizes[nextTag, default: nextSize]
      value.maxSizes[nextTag] = .init(
        width: max(nextSize.width, currentSize.width),
        height: max(nextSize.height, currentSize.height)
      )
    }
  }
}

internal extension ScopedMeasurementPreferenceKey {
  struct Value: Equatable {
    var version: AnyHashable
    var maxSizes: [Tag: CGSize]
  }
}
