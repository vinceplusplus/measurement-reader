import SwiftUI

internal func getNextAutoScope() -> Int {
  struct State {
    static var next = 0
  }
  defer {
    State.next &+= 1
  }
  return State.next
}

internal class AutoScopeState: ObservableObject {
  private(set) lazy var autoScope: Int = getNextAutoScope()
}

public struct SafelyScopedMeasurementReader<Scope, Tag>: View where Tag: Hashable {
  let version: AnyHashable
  let reducer: MeasurementReducer
  let content: (_ proxy: SafelyScopedMeasurementProxy<Tag>) -> AnyView
  
  @StateObject var autoScopeState = AutoScopeState()
  
  public init<Content>(
    version: AnyHashable = DefaultMeasurementVersion(),
    reducer: MeasurementReducer = .replace,
    @ViewBuilder content: @escaping (_ proxy: SafelyScopedMeasurementProxy<Tag>) -> Content
  )
  where
    Content: View
  {
    self.version = version
    self.reducer = reducer
    self.content = {
      .init(content($0))
    }
  }
  
  public var body: some View {
    makeBody()
  }
  
  // TODO: if nested type is allowed in generic function, we could do the following which is cleaner and more scalable
  //internal func makeBody(with autoScope: AutoScope) -> AnyView {
  //  func make<Subscope>(_ subscopeType: Subscope.Type) -> AnyView {
  //    .init(
  //      ScopedMeasurementReader<ScopeChain<Subscope, Scope>, Tag>(
  //        version: version,
  //        reducer: reducer
  //      ) {
  //        content(.init($0))
  //      }
  //    )
  //  }
  //
  //  switch autoScope {
  //  case .autoScope0:
  //    struct AS {}
  //    return make(AS.self)
  //  case .autoScope1:
  //    struct AS {}
  //    return make(AS.self)
  //  // ...
  //  }
  //}
}
