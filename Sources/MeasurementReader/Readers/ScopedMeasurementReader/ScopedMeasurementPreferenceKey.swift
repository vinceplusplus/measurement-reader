import SwiftUI

internal struct ScopedMeasurementPreferenceKey<Scope, Tag>: PreferenceKey where Tag: Hashable {
  static var defaultValue: Value { [:] }
  
  static func reduce(value: inout Value, nextValue getNextValue: () -> Value) {
    let nextValue = getNextValue()
    
    func updateBin(_ bin: inout Bin, with newBin: Bin) {
      bin.version = newBin.version != .init(DefaultInitialMeasurementVersion())
      ? newBin.version
      : bin.version
      
      for (tag, newSize) in newBin.maxSizes {
        let currentSize = bin.maxSizes[tag, default: newSize]
        bin.maxSizes[tag] = .init(
          width: max(newSize.width, currentSize.width),
          height: max(newSize.height, currentSize.height)
        )
      }
    }
    for (binID, newBin) in nextValue {
      updateBin(
        &value[binID, default: .init(version: DefaultInitialMeasurementVersion(), maxSizes: [:])],
        with: newBin
      )
    }
  }
}

internal extension ScopedMeasurementPreferenceKey {
  struct Bin: Equatable {
    var version: AnyHashable
    var maxSizes: [Tag: CGSize]
  }
  typealias Value = [Int: Bin]
}
