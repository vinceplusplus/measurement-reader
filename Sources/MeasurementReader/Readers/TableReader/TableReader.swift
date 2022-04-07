import SwiftUI

fileprivate struct TableScope {}

public struct TableReader<Scope, Tag>: View where Tag: Hashable {
  private let content: () -> AnyView
  
  public init<Content>(
    maxWidth: CGFloat,
    pads: Bool = true,
    version: AnyHashable = DefaultMeasurementVersion(),
    reducer: MeasurementReducer = .merge,
    @ViewBuilder content: @escaping (_ proxy: TableProxy<Tag>) -> Content
  )
  where
    Content: View
  {
    self.content = {
      .init(
        MeasurementReader<ScopeChain<Scope, TableScope>, Tag>(
          version: version,
          reducer: reducer
        ) { measurementProxy in
          content(.init(maxWidth: maxWidth, measurementProxy: measurementProxy, pads: pads))
        }
      )
    }
  }
  
  public var body: some View {
    content()
  }
}
