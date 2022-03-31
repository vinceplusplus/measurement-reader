import SwiftUI

fileprivate class AutoScopeState: ObservableObject {
  private(set) lazy var autoScope: Int = getNextAutoScope()
}

public struct SafelyScopedMeasurementReader<Scope, Tag>: View where Tag: Hashable {
  private let version: AnyHashable
  private let reducer: MeasurementReducer
  private let content: (_ proxy: SafelyScopedMeasurementProxy<Tag>) -> AnyView
  
  @StateObject private var autoScopeState = AutoScopeState()
  
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
  
  private func makeBody() -> AnyView {
    func make<Subscope>(_ subscopeType: Subscope.Type) -> AnyView {
      .init(
        ScopedMeasurementReader<ScopeChain<Subscope, Scope>, Tag>(
          version: version,
          reducer: reducer
        ) {
          content(.init($0))
        }
      )
    }
    
    switch AutoScope(rawValue: autoScopeState.autoScope) {
    case .none, .autoScope0:
      return make(AutoScope0.self)
    case .autoScope1:
      return make(AutoScope1.self)
    case .autoScope2:
      return make(AutoScope2.self)
    case .autoScope3:
      return make(AutoScope3.self)
    case .autoScope4:
      return make(AutoScope4.self)
    case .autoScope5:
      return make(AutoScope5.self)
    case .autoScope6:
      return make(AutoScope6.self)
    case .autoScope7:
      return make(AutoScope7.self)
    case .autoScope8:
      return make(AutoScope8.self)
    case .autoScope9:
      return make(AutoScope9.self)
    case .autoScope10:
      return make(AutoScope10.self)
    case .autoScope11:
      return make(AutoScope11.self)
    case .autoScope12:
      return make(AutoScope12.self)
    case .autoScope13:
      return make(AutoScope13.self)
    case .autoScope14:
      return make(AutoScope14.self)
    case .autoScope15:
      return make(AutoScope15.self)
    case .autoScope16:
      return make(AutoScope16.self)
    case .autoScope17:
      return make(AutoScope17.self)
    case .autoScope18:
      return make(AutoScope18.self)
    case .autoScope19:
      return make(AutoScope19.self)
    case .autoScope20:
      return make(AutoScope20.self)
    case .autoScope21:
      return make(AutoScope21.self)
    case .autoScope22:
      return make(AutoScope22.self)
    case .autoScope23:
      return make(AutoScope23.self)
    case .autoScope24:
      return make(AutoScope24.self)
    case .autoScope25:
      return make(AutoScope25.self)
    case .autoScope26:
      return make(AutoScope26.self)
    case .autoScope27:
      return make(AutoScope27.self)
    case .autoScope28:
      return make(AutoScope28.self)
    case .autoScope29:
      return make(AutoScope29.self)
    case .autoScope30:
      return make(AutoScope30.self)
    case .autoScope31:
      return make(AutoScope31.self)
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
