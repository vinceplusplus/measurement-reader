import SwiftUI

public protocol MeasurementProxyProtocol {
  associatedtype Tag: Hashable
  associatedtype MeasureViewModifier: ViewModifier
  
  var maxSizes: [Tag: CGSize] { get }
  
  func measure(_ tag: Tag) -> MeasureViewModifier
  func maxSize(_ tag: Tag) -> CGSize?
  func maxWidth(_ tag: Tag) -> CGFloat?
  func maxHeight(_ tag: Tag) -> CGFloat?
}

public extension MeasurementProxyProtocol where Tag == Untagged {
  func maxSize() -> CGSize? {
    maxSize(.init())
  }
  
  func maxWidth() -> CGFloat? {
    maxWidth(.init())
  }
  
  func maxHeight() -> CGFloat? {
    maxHeight(.init())
  }
  
  func measure() -> MeasureViewModifier {
    measure(.init())
  }
}
