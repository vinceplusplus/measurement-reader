import SwiftUI

public struct ScopedMeasurementMeasureModifier<Scope, Tag>: ViewModifier where Tag: Hashable {
  public let version: AnyHashable
  public let tag: Tag

  internal init(version: AnyHashable, tag: Tag) {
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
              value: .init(version: version, maxSizes: [tag: proxy.size])
            )
        }
      )
  }
}
