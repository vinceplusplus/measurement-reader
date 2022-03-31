import SwiftUI

internal func getMaxColumnWidth<Tag: Hashable>(maxWidth: CGFloat, columnWidths: [Tag: CGFloat]) -> CGFloat {
  // TODO: should build some sequence and use something like upper bound
  let widthCountMap = columnWidths.reduce(into: [CGFloat: Int]()) {
    $0[$1.value, default: 0] += 1
  }
  var runningCount = 0
  var prevWidth: CGFloat = 0
  var runningIncrement: CGFloat = 0
  for (width, count) in widthCountMap.sorted(by: { $0.key < $1.key }) {
    let increment = width - prevWidth
    let incrementCount = columnWidths.count - runningCount
    runningIncrement += increment * CGFloat(incrementCount)
    
    if runningIncrement > maxWidth {
      return width - (runningIncrement - maxWidth) / CGFloat(incrementCount)
    }

    runningCount += count
    prevWidth = width
  }
  return .infinity
}
