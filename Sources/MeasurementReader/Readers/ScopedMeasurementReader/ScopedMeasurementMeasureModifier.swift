import SwiftUI

public struct ScopedMeasurementMeasureModifier<Scope, Tag>: ViewModifier where Tag: Hashable {
  public let binID: Int
  public let version: AnyHashable
  public let tag: Tag

  internal init(binID: Int, version: AnyHashable, tag: Tag) {
    self.binID = binID
    self.version = version
    self.tag = tag
  }

  public func body(content: Content) -> some View {
    content
      .background(
        GeometryReader { proxy in
          Color.clear
            .preference(
              key: ScopedMeasurementPreferenceKey<Scope, Tag>.self,
              value: [binID: .init(version: version, maxSizes: [tag: proxy.size])]
            )
        }
      )
  }
}
