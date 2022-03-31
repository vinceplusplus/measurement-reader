import SwiftUI

public struct MeasurementProxy<Tag> where Tag: Hashable {
  private let proxy: SafelyScopedMeasurementProxy<Tag>
  
  public let maxSizes: [Tag : CGSize]
  
  internal init(_ proxy: SafelyScopedMeasurementProxy<Tag>) {
    self.proxy = proxy
    self.maxSizes = proxy.maxSizes
  }
  
  public func maxSize(_ tag: Tag) -> CGSize? {
    proxy.maxSize(tag)
  }
  
  public func maxWidth(_ tag: Tag) -> CGFloat? {
    proxy.maxWidth(tag)
  }
  
  public func maxHeight(_ tag: Tag) -> CGFloat? {
    proxy.maxHeight(tag)
  }
  
  public func measure(_ tag: Tag) -> some ViewModifier {
    proxy.measure(tag)
  }
}

extension MeasurementProxy: MeasurementProxyProtocol {}
