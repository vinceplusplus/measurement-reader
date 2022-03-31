import SwiftUI

public struct ScopedMeasurementProxy<Scope, Tag> where Tag: Hashable {
  public let version: AnyHashable
  public let maxSizes: [Tag: CGSize]

  internal init(version: AnyHashable, maxSizes: [Tag : CGSize]) {
    self.version = version
    self.maxSizes = maxSizes
  }

  public func measure(_ tag: Tag) -> ScopedMeasurementMeasureModifier<Scope, Tag> {
    .init(version: version, tag: tag)
  }
  
  public func maxSize(_ tag: Tag) -> CGSize? {
    maxSizes[tag]
  }

  public func maxWidth(_ tag: Tag) -> CGFloat? {
    maxSize(tag)?.width
  }

  public func maxHeight(_ tag: Tag) -> CGFloat? {
    maxSize(tag)?.height
  }
}

extension ScopedMeasurementProxy: MeasurementProxyProtocol {}
