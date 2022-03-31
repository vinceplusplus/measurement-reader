import SwiftUI

public struct MeasurementReader<Scope, Tag>: View where Tag: Hashable {
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
      .init(SafelyScopedMeasurementReader<Scope, Tag>(version: version, reducer: reducer) {
        content(.init($0))
      })
    }
  }
  
  public var body: some View {
    content()
  }
}
