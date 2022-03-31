import SwiftUI

fileprivate struct Unscoped {}

public struct SimpleMeasurementReader<Tag>: View where Tag: Hashable {
  private let content: () -> AnyView
  
  public init<Content>(
    version: AnyHashable = DefaultMeasurementVersion(),
    reducer: MeasurementReducer = .replace,
    @ViewBuilder content: @escaping (_ proxy: MeasurementProxy<Tag>) -> Content
  )
  where
    Content: View
  {
    self.content = {
      .init(MeasurementReader<Unscoped, Tag>(version: version, reducer: reducer) {
        content($0)
      })
    }
  }
  
  public var body: some View {
    content()
  }
}
