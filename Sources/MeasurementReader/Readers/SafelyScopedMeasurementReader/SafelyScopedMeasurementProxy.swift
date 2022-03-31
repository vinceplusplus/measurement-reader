import SwiftUI

public struct SafelyScopedMeasurementProxy<Tag> where Tag: Hashable {
  private let maxSizeHandler: (_ tag: Tag) -> CGSize?
  private let maxWidthHandler: (_ tag: Tag) -> CGFloat?
  private let maxHeightHandler: (_ tag: Tag) -> CGFloat?
  private let measureHandler: (_ tag: Tag) -> SafelyScopedMeasurementMeasureModifier
  
  public let maxSizes: [Tag : CGSize]

  internal init<Scope>(_ proxy: ScopedMeasurementProxy<Scope, Tag>) {
    self.maxSizeHandler = { proxy.maxSize($0) }
    self.maxWidthHandler = { proxy.maxWidth($0) }
    self.maxHeightHandler = { proxy.maxHeight($0) }
    self.measureHandler = { .init(proxy.measure($0)) }
    self.maxSizes = proxy.maxSizes
  }
  
  public func maxSize(_ tag: Tag) -> CGSize? {
    maxSizeHandler(tag)
  }
  
  public func maxWidth(_ tag: Tag) -> CGFloat? {
    maxWidthHandler(tag)
  }
  
  public func maxHeight(_ tag: Tag) -> CGFloat? {
    maxHeightHandler(tag)
  }
  
  public func measure(_ tag: Tag) -> some ViewModifier {
    measureHandler(tag)
  }
}

extension SafelyScopedMeasurementProxy: MeasurementProxyProtocol {}
