import SwiftUI

fileprivate struct Unscoped {}

public struct SimpleSizeReader: View {
  private let content: () -> AnyView
  
  public init<Content>(
    version: AnyHashable = DefaultMeasurementVersion(),
    reducer: MeasurementReducer = .replace,
    @ViewBuilder content: @escaping (_ proxy: MeasurementProxy<Untagged>) -> Content
  )
  where
    Content: View
  {
    self.content = {
      .init(SizeReader<Unscoped>(version: version, reducer: reducer) {
        content($0)
      })
    }
  }
  
  public var body: some View {
    content()
  }
}
