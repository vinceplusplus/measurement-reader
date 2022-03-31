import SwiftUI

public struct SizeReader: View {
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
      .init(SimpleMeasurementReader<Untagged>(version: version, reducer: reducer) {
        content($0)
      })
    }
  }
  
  public var body: some View {
    content()
  }
}
