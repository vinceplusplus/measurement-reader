import SwiftUI

fileprivate struct Unscoped {}

public struct SimpleTableReader<Tag>: View where Tag: Hashable {
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
        TableReader<Unscoped, Tag>(
          maxWidth: maxWidth,
          pads: pads,
          version: version,
          reducer: reducer
        ) {
          content($0)
        }
      )
    }
  }
  
  public var body: some View {
    content()
  }
}
