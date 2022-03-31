import SwiftUI

public extension View {
  func measure<MeasurementProxy, Tag>(
    _ proxy: MeasurementProxy,
    _ tag: Tag
  ) -> some View
  where
    MeasurementProxy: MeasurementProxyProtocol,
    MeasurementProxy.Tag == Tag
  {
    self.modifier(proxy.measure(tag))
  }
  
  func measure<MeasurementProxy>(
    _ proxy: MeasurementProxy
  ) -> some View
  where
    MeasurementProxy: MeasurementProxyProtocol,
    MeasurementProxy.Tag == Untagged
  {
    self.modifier(proxy.measure())
  }
}
