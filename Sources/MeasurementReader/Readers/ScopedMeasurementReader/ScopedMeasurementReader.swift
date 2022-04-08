import SwiftUI

fileprivate func getNextBinID() -> Int {
  struct State {
    static var nextID = 0
  }
  defer {
    State.nextID &+= 1
  }
  return State.nextID
}

fileprivate class BinIDState: ObservableObject {
  private(set) lazy var binID: Int = getNextBinID()
}

public struct ScopedMeasurementReader<Scope, Tag>: View where Tag: Hashable {
  private let version: AnyHashable
  private let reducer: MeasurementReducer
  private let content: (_ proxy: ScopedMeasurementProxy<Scope, Tag>) -> AnyView
  
  @State private var binIDState = BinIDState()
  
  @State private var current: ScopedMeasurementPreferenceKey<Scope, Tag>.Bin = .init(
    version: DefaultInitialMeasurementVersion(), maxSizes: [:]
  )

  public init<Content>(
    version: AnyHashable = DefaultMeasurementVersion(),
    reducer: MeasurementReducer = .replace,
    @ViewBuilder content: @escaping (_ proxy: ScopedMeasurementProxy<Scope, Tag>) -> Content
  )
  where
    Content: View
  {
    self.version = version
    self.reducer = reducer
    self.content = {
      .init(content($0))
    }
  }
  
  public var body: some View {
    content(.init(
      binID: binIDState.binID,
      version: version,
      maxSizes: version == current.version ? current.maxSizes : [:]
    ))
    .onPreferenceChange(ScopedMeasurementPreferenceKey<Scope, Tag>.self) {
      if let bin = $0[binIDState.binID] {
        if bin.version != current.version {
          current = bin
        } else {
          switch reducer {
          case .replace:
            current = bin
          case .merge:
            current.version = bin.version
            for (tag, size) in bin.maxSizes {
              let currentSize = current.maxSizes[tag, default: size]
              current.maxSizes[tag] = .init(
                width: max(size.width, currentSize.width),
                height: max(size.height, currentSize.height)
              )
            }
          }
        }
      }
    }
  }
}
