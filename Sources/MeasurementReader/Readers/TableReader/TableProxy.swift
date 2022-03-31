import SwiftUI

public struct TableProxy<Tag> where Tag: Hashable {
  private let measurementProxy: MeasurementProxy<Tag>
  private let padding: CGFloat
  private let maxColumnWidth: CGFloat
  
  internal init(maxWidth: CGFloat, measurementProxy: MeasurementProxy<Tag>, pads: Bool) {
    let totalWidth: CGFloat = measurementProxy.maxSizes.reduce(0) { $0 + $1.value.width }
    self.measurementProxy = measurementProxy
    self.padding = pads ? max(0, (maxWidth - totalWidth) / CGFloat(max(1, measurementProxy.maxSizes.count))) : 0
    self.maxColumnWidth = getMaxColumnWidth(
      maxWidth: maxWidth,
      columnWidths: measurementProxy.maxSizes.mapValues(\.width)
    )
  }

  public func columnWidth(_ tag: Tag) -> CGFloat? {
    if let width = measurementProxy.maxSizes[tag]?.width {
      return min(width + padding, maxColumnWidth)
    }
    return nil
  }
}

extension TableProxy: MeasurementProxyProtocol {
  public var maxSizes: [Tag: CGSize] {
    measurementProxy.maxSizes
  }
  
  public func measure(_ tag: Tag) -> some ViewModifier {
    measurementProxy.measure(tag)
  }
  
  public func maxSize(_ tag: Tag) -> CGSize? {
    measurementProxy.maxSize(tag)
  }
  
  public func maxWidth(_ tag: Tag) -> CGFloat? {
    measurementProxy.maxWidth(tag)
  }
  
  public func maxHeight(_ tag: Tag) -> CGFloat? {
    measurementProxy.maxHeight(tag)
  }
}
