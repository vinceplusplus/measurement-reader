import SwiftUI

public struct ScopedMeasurementReader<Scope, Tag>: View where Tag: Hashable {
  private let version: AnyHashable
  private let reducer: MeasurementReducer
  private let content: (_ proxy: ScopedMeasurementProxy<Scope, Tag>) -> AnyView
  
  @State private var current: ScopedMeasurementPreferenceKey<Scope, Tag>.Value =
    .init(version: DefaultInitialMeasurementVersion(), maxSizes: [:])

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
      version: version,
      maxSizes: version == current.version ? current.maxSizes : [:]
    ))
    .onPreferenceChange(ScopedMeasurementPreferenceKey<Scope, Tag>.self) {
      if $0.version != current.version {
        current = $0
      } else {
        switch reducer {
        case .replace:
          current = $0
        case .merge:
          current.version = $0.version
          for (tag, size) in $0.maxSizes {
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
