import SwiftUI

internal struct ScopedMeasurementPreferenceKey<Scope, Tag>: PreferenceKey where Tag: Hashable {
  static var defaultValue: Value { [:] }
  
  static func reduce(value: inout Value, nextValue getNextValue: () -> Value) {
    func updateBin(_ bin: inout Bin, with newBin: Bin) {
      // NOTE: if there is a new bin, it is always an initialized one (non empty)
      bin.version = newBin.version
      for (tag, newSize) in newBin.maxSizes {
        let currentSize = bin.maxSizes[tag, default: newSize]
        bin.maxSizes[tag] = .init(
          width: max(newSize.width, currentSize.width),
          height: max(newSize.height, currentSize.height)
        )
      }
    }
    
    let nextValue = getNextValue()
    
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
