import SwiftUI

internal struct SafelyScopedMeasurementMeasureModifier: ViewModifier {
  private let bodyHandler: (_ content: Content) -> AnyView

  internal init<Scope, Tag>(_ modifier: ScopedMeasurementMeasureModifier<Scope, Tag>) {
    bodyHandler = { .init($0.modifier(modifier)) }
  }
  
  public func body(content: Content) -> some View {
    bodyHandler(content)
  }
}
