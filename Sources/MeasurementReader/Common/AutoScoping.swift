internal enum AutoScope: Int, CaseIterable {
  case autoScope0
  case autoScope1
  case autoScope2
  case autoScope3
  case autoScope4
  case autoScope5
  case autoScope6
  case autoScope7
  case autoScope8
  case autoScope9
  case autoScope10
  case autoScope11
  case autoScope12
  case autoScope13
  case autoScope14
  case autoScope15
  case autoScope16
  case autoScope17
  case autoScope18
  case autoScope19
  case autoScope20
  case autoScope21
  case autoScope22
  case autoScope23
  case autoScope24
  case autoScope25
  case autoScope26
  case autoScope27
  case autoScope28
  case autoScope29
  case autoScope30
  case autoScope31
}

internal struct AutoScope0 {}
internal struct AutoScope1 {}
internal struct AutoScope2 {}
internal struct AutoScope3 {}
internal struct AutoScope4 {}
internal struct AutoScope5 {}
internal struct AutoScope6 {}
internal struct AutoScope7 {}
internal struct AutoScope8 {}
internal struct AutoScope9 {}
internal struct AutoScope10 {}
internal struct AutoScope11 {}
internal struct AutoScope12 {}
internal struct AutoScope13 {}
internal struct AutoScope14 {}
internal struct AutoScope15 {}
internal struct AutoScope16 {}
internal struct AutoScope17 {}
internal struct AutoScope18 {}
internal struct AutoScope19 {}
internal struct AutoScope20 {}
internal struct AutoScope21 {}
internal struct AutoScope22 {}
internal struct AutoScope23 {}
internal struct AutoScope24 {}
internal struct AutoScope25 {}
internal struct AutoScope26 {}
internal struct AutoScope27 {}
internal struct AutoScope28 {}
internal struct AutoScope29 {}
internal struct AutoScope30 {}
internal struct AutoScope31 {}

internal func getNextAutoScope() -> Int {
  struct State {
    static var nextAutoScope = 0
  }
  defer {
    State.nextAutoScope = (State.nextAutoScope + 1) % AutoScope.allCases.count
  }
  return State.nextAutoScope
}
