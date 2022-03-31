import XCTest
import SwiftUI
import Combine
import SnapshotTesting
@testable import MeasurementReader

#if os(iOS)

struct ViewHost<Content> where Content: View {
  let window: UIWindow
  let viewController: UIHostingController<Content>
  
  init(@ViewBuilder content: () -> Content) {
    window = UIWindow(frame: UIScreen.main.bounds)
    window.makeKeyAndVisible()
    viewController = UIHostingController(rootView: content())
    window.rootViewController = viewController
    viewController.view.layoutIfNeeded()
  }
  
  func layoutIfNeeded() {
    viewController.view.setNeedsLayout()
    viewController.view.layoutIfNeeded()
  }
}

// NOTE: because the following is not allowed and will result in `Escaping closure captures mutating 'self' parameter`
//protocol BindingMakeable {
//  mutating func makeBinding() -> Binding<Self>
//}
//
//extension BindingMakeable {
//  mutating func makeBinding() -> Binding<Self> {
//    .init {
//      self
//    } set: {
//      self = $0
//    }
//  }
//}
class StateContainer<T> {
  var state: T
  
  init(_ state: T) {
    self.state = state
  }
  
  func makeBinding() -> Binding<T> {
    .init {
      self.state
    } set: {
      self.state = $0
    }
  }
}

final class MeasurementReaderTests: XCTestCase {
  func testSizeReader() {
    let view = SizeReader { proxy in
      HStack {
        VStack {
          Text("Top aligned")
            .measure(proxy)
        }
        .frame(minHeight: proxy.maxHeight(), alignment: .top)
        .background(Color.red)
        
        VStack {
          Text("Bottom aligned")
            .measure(proxy)
        }
        .frame(minHeight: proxy.maxHeight(), alignment: .bottom)
        .background(Color.green)
        
        VStack {
          Text("Multiline text\nLine 1\nLine 2\nLine 3\nLine 4")
            .measure(proxy)
        }
        .frame(minHeight: proxy.maxHeight())
        .background(Color.blue)
      }
      .foregroundColor(Color.white)
    }
      .frame(width: 300, height: 200)
    
    assertSnapshot(matching: view, as: .image)
  }
  
  func testSimpleMeasurementReader() {
    enum Field {
      case no
      case name
      case address
    }

    let data: [(no: String, name: String, address: String)] = [
      ("No.", "Name", "Address"),
      ("8", "John Gattis", "953 Progress Way Hutchinson, MN"),
      ("9", "Stephen Arce", "695 Tori Lane Ogden, UT"),
      ("10", "Ashley Barna", "607 Harry Place Charlotte, NC"),
      ("11", "Angela Herron", "4999 Valley Lane Austin, TX"),
      ("13", "Some really really long name", "2388 Collins Street Tampa, FL"),
    ]
    
    let view = SimpleMeasurementReader<Field> { proxy in
      VStack(spacing: 8) {
        ForEach(data, id: \.no) { person in
          HStack(spacing: 16) {
            VStack {
              Text("\(person.no)")
                .measure(proxy, .no)
            }
            .frame(minWidth: proxy.maxWidth(.no), alignment: .trailing)
            
            VStack {
              Text("\(person.name)")
                .measure(proxy, .name)
            }
            .frame(minWidth: proxy.maxWidth(.name), alignment: .leading)
            
            Text("\(person.address)")
              .frame(maxWidth: .infinity, alignment: .leading)
          }
          .font(person.no == "No." ? .system(size: 16, weight: .bold) : .system(size: 16))
        }
      }
    }
      .frame(width: 400, height: 300)

    assertSnapshot(matching: view, as: .image)
  }
  
  func testSimpleTableReader() {
    enum Field {
      case id
      case name
      case portion
      case calories
      case fat
      case cholestrol
      case sodium
      case carb
      case protein
    }

    let data: [(
      id: String,
      name: String,
      portion: String,
      calories: String,
      fat: String,
      cholestrol: String,
      sodium: String,
      carb: String,
      protein: String
    )] = [
      ("ID", "Name", "Portion", "Calories", "Fat", "Cholestrol", "Sodium", "Carb", "Protein"),
      ("1", "Cheddar cheese", "100 g", "402 kcal", "33 g", "105 mg", "621 mg", "1.3 g", "25 g"),
      ("2", "Chicken breast", "100 g", "165 kcal", "3.6 g", "85 mg", "74 mg", "0 g", "31 g"),
      ("3", "Pork", "100 g", "242 kcal", "14 g", "80 mg", "62 mg", "0 g", "27 g"),
      ("4", "Beef", "100 g", "250 kcal", "15 g", "90 mg", "72 mg", "0 g", "26 g"),
      ("5", "Beef", "100 g", "208 kcal", "13 g", "55 mg", "59 mg", "0 g", "20 g"),
      ("6", "Noodle", "100 g", "138 kcal", "2.1 g", "29 mg", "5 mg", "25 g", "4.5 g"),
      ("7", "Rice", "100 g", "130 kcal", "0.3 g", "0 mg", "1 mg", "28 g", "2.7 g"),
      ("8", "Pizza", "100 g", "266 kcal", "10 g", "17 mg", "598 mg", "33 g", "11 g"),
      ("9", "Vegetable", "100 g", "65 kcal", "0.2 g", "0 mg", "35 mg", "13 g", "2.9 g"),
    ]
    
    let view = SizeReader { containerProxy in
      VStack(spacing: 0) {
        Color.clear
          .frame(height: 0)
          .measure(containerProxy)
        
        ScrollView {
          SimpleTableReader<Field>(
            maxWidth: (containerProxy.maxWidth() ?? 0) - 16 * 2,
            version: containerProxy.maxWidth()
          ) { proxy in
            VStack(spacing: 0) {
              ForEach(data, id: \.id) { food in
                HStack(spacing: 0) {
                  VStack {
                    Text("\(food.name)")
                      .padding(.horizontal, 8)
                      .measure(proxy, .name)
                  }
                  .frame(minWidth: proxy.columnWidth(.name), alignment: .leading)
                  
                  VStack {
                    Text("\(food.portion)")
                      .padding(.horizontal, 8)
                      .measure(proxy, .portion)
                  }
                  .frame(minWidth: proxy.columnWidth(.portion), alignment: .trailing)
                  
                  VStack {
                    Text("\(food.calories)")
                      .padding(.horizontal, 8)
                      .measure(proxy, .calories)
                  }
                  .frame(minWidth: proxy.columnWidth(.calories), alignment: .trailing)
                  
                  VStack {
                    Text("\(food.fat)")
                      .padding(.horizontal, 8)
                      .measure(proxy, .fat)
                  }
                  .frame(minWidth: proxy.columnWidth(.fat), alignment: .trailing)
                }
                .font(food.id == "ID" ? .system(size: 16, weight: .bold) : .system(size: 16))
                .padding(.vertical, 8)
              }
            }
            .padding(.horizontal, 16)
          }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
    }
      .frame(width: 400, height: 400)

    assertSnapshot(matching: view, as: .image)
  }
  
  func testSimpleTableReaderWithNotEnoughWidth() {
    let view = SimpleTableReader<Int>(maxWidth: 300) { proxy in
      VStack {
        HStack(spacing: 0) {
          Text("really really long text")
            .measure(proxy, 0)
            .frame(minWidth: proxy.columnWidth(0))
          Text("short text")
            .measure(proxy, 1)
            .frame(minWidth: proxy.columnWidth(1))
        }
        HStack(spacing: 0) {
          Text("short text")
            .measure(proxy, 0)
            .frame(minWidth: proxy.columnWidth(0))
          Text("really really long text")
            .measure(proxy, 1)
            .frame(minWidth: proxy.columnWidth(1))
        }
      }
    }
      .frame(width: 500, height: 100)
    assertSnapshot(matching: view, as: .image)
  }
  
  func testSizeReaderForSizeReporting() {
    struct TestView: View {
      @Binding var sizes: [Untagged: CGSize]
      @Binding var size: CGSize
      @Binding var width: CGFloat
      @Binding var height: CGFloat

      var body: some View {
        SizeReader { proxy in
          HStack(spacing: 0) {
            Text("just one really long text")
              .measure(proxy)
              .frame(minHeight: proxy.maxWidth())
            Text("multiline\ntext\nsome\nfiller\nlines")
              .measure(proxy)
              .frame(minHeight: proxy.maxWidth())
          }
          .onChange(of: proxy.maxSizes) { newValue in
            sizes = newValue
          }
          .onChange(of: proxy.maxSize()) { newValue in
            if let newValue = newValue {
              size = newValue
            }
          }
          .onChange(of: proxy.maxWidth()) { newValue in
            if let newValue = newValue {
              width = newValue
            }
          }
          .onChange(of: proxy.maxHeight()) { newValue in
            if let newValue = newValue {
              height = newValue
            }
          }
        }
          .frame(width: 500, height: 100)
      }
    }
    
    let sizes = StateContainer<[Untagged: CGSize]>([:])
    let size = StateContainer<CGSize>(.zero)
    let width = StateContainer<CGFloat>(0)
    let height = StateContainer<CGFloat>(0)
    _ = ViewHost {
      TestView(
        sizes: sizes.makeBinding(),
        size: size.makeBinding(),
        width: width.makeBinding(),
        height: height.makeBinding()
      )
    }
    XCTAssertEqual(sizes.state[.init()]?.width ?? 0, 175.666666, accuracy: 0.000001)
    XCTAssertEqual(sizes.state[.init()]?.height ?? 0, 108.333333, accuracy: 0.000001)
    XCTAssertEqual(size.state.width, 175.666666, accuracy: 0.000001)
    XCTAssertEqual(size.state.height, 108.333333, accuracy: 0.000001)
    XCTAssertEqual(width.state, 175.666666, accuracy: 0.000001)
    XCTAssertEqual(height.state, 108.333333, accuracy: 0.000001)
  }
  
  func testSimpleMeasurementReaderForSizeReporting() {
    struct TestView: View {
      @Binding var sizes: [Int: CGSize]
      @Binding var size0: CGSize
      @Binding var size1: CGSize
      @Binding var width0: CGFloat
      @Binding var height0: CGFloat
      @Binding var width1: CGFloat
      @Binding var height1: CGFloat

      var body: some View {
        SimpleMeasurementReader<Int> { proxy in
          VStack {
            HStack(spacing: 0) {
              Text("some really long text")
                .measure(proxy, 0)
                .frame(minWidth: proxy.maxWidth(0))
              Text("short text")
                .measure(proxy, 1)
                .frame(minWidth: proxy.maxWidth(1))
            }
            HStack(spacing: 0) {
              Text("short text")
                .measure(proxy, 0)
                .frame(minWidth: proxy.maxWidth(0))
              Text("some really really long text")
                .measure(proxy, 1)
                .frame(minWidth: proxy.maxWidth(1))
            }
          }
          .onChange(of: proxy.maxSizes) { newValue in
            sizes = newValue
          }
          .onChange(of: proxy.maxSize(0)) { newValue in
            if let newValue = newValue {
              size0 = newValue
            }
          }
          .onChange(of: proxy.maxSize(1)) { newValue in
            if let newValue = newValue {
              size1 = newValue
            }
          }
          .onChange(of: proxy.maxWidth(0)) { newValue in
            if let newValue = newValue {
              width0 = newValue
            }
          }
          .onChange(of: proxy.maxHeight(0)) { newValue in
            if let newValue = newValue {
              height0 = newValue
            }
          }
          .onChange(of: proxy.maxWidth(1)) { newValue in
            if let newValue = newValue {
              width1 = newValue
            }
          }
          .onChange(of: proxy.maxHeight(1)) { newValue in
            if let newValue = newValue {
              height1 = newValue
            }
          }
        }
          .frame(width: 500, height: 100)
      }
    }
    
    let sizes = StateContainer<[Int: CGSize]>([:])
    let size0 = StateContainer<CGSize>(.zero)
    let size1 = StateContainer<CGSize>(.zero)
    let width0 = StateContainer<CGFloat>(0)
    let height0 = StateContainer<CGFloat>(0)
    let width1 = StateContainer<CGFloat>(0)
    let height1 = StateContainer<CGFloat>(0)
    _ = ViewHost {
      TestView(
        sizes: sizes.makeBinding(),
        size0: size0.makeBinding(),
        size1: size1.makeBinding(),
        width0: width0.makeBinding(),
        height0: height0.makeBinding(),
        width1: width1.makeBinding(),
        height1: height1.makeBinding()
      )
    }
    XCTAssertEqual(sizes.state[0]?.width ?? 0, 157.333333, accuracy: 0.000001)
    XCTAssertEqual(sizes.state[0]?.height ?? 0, 20.333333, accuracy: 0.000001)
    XCTAssertEqual(sizes.state[1]?.width ?? 0, 202, accuracy: 0.000001)
    XCTAssertEqual(sizes.state[1]?.height ?? 0, 20.333333, accuracy: 0.000001)
    XCTAssertEqual(size0.state.width, 157.333333, accuracy: 0.000001)
    XCTAssertEqual(size0.state.height, 20.333333, accuracy: 0.000001)
    XCTAssertEqual(size1.state.width, 202, accuracy: 0.000001)
    XCTAssertEqual(size1.state.height, 20.333333, accuracy: 0.000001)
    XCTAssertEqual(width0.state, 157.333333, accuracy: 0.000001)
    XCTAssertEqual(height0.state, 20.333333, accuracy: 0.000001)
    XCTAssertEqual(width1.state, 202, accuracy: 0.000001)
    XCTAssertEqual(height1.state, 20.333333, accuracy: 0.000001)
  }
  
  func testSimpleMeasurementReaderWithMerging() {
    enum Shape {
      case wideRectangle
      case tallRectangle
    }
    class ViewModel: ObservableObject {
      @Published var shape1: Shape? = .wideRectangle
      @Published var shape2: Shape? = .tallRectangle
      @Published var shape3: Shape? = nil
    }
    struct TestView: View {
      @ObservedObject var viewModel: ViewModel
      @Binding var sizes: [Int: CGSize]

      var body: some View {
        SimpleMeasurementReader<Int>(reducer: .merge) { proxy in
          VStack {
            if let shape = viewModel.shape1 {
              Text("\(shape == .wideRectangle ? "wide rectangle" : "t\na\nl\nl\n\nr\ne\nc\nt\na\nn\ng\nl\ne")")
                .measure(proxy, 0)
            }
            if let shape = viewModel.shape2 {
              Text("\(shape == .wideRectangle ? "wide rectangle" : "t\na\nl\nl\n\nr\ne\nc\nt\na\nn\ng\nl\ne")")
                .measure(proxy, 1)
            }
            if let shape = viewModel.shape3 {
              Text("\(shape == .wideRectangle ? "wide rectangle" : "t\na\nl\nl\n\nr\ne\nc\nt\na\nn\ng\nl\ne")")
                .measure(proxy, 2)
            }
          }
          .onChange(of: proxy.maxSizes) { newValue in
            sizes = newValue
          }
        }
          .frame(width: 600, height: 600)
      }
    }
    
    let viewModel = ViewModel()
    let sizes = StateContainer<[Int: CGSize]>([:])
    let viewHost = ViewHost {
      TestView(
        viewModel: viewModel,
        sizes: sizes.makeBinding()
      )
    }
    XCTAssertEqual(sizes.state[0]?.width ?? 0, 112, accuracy: 0.000001)
    XCTAssertEqual(sizes.state[0]?.height ?? 0, 20.333333, accuracy: 0.000001)
    XCTAssertEqual(sizes.state[1]?.width ?? 0, 10, accuracy: 0.000001)
    XCTAssertEqual(sizes.state[1]?.height ?? 0, 306.333333, accuracy: 0.000001)
    XCTAssertEqual(sizes.state[2]?.width, nil)
    XCTAssertEqual(sizes.state[2]?.height, nil)

    viewModel.shape1 = .tallRectangle
    viewModel.shape2 = .wideRectangle
    viewModel.shape3 = .wideRectangle
    viewHost.layoutIfNeeded()
    
    XCTAssertEqual(sizes.state[0]?.width ?? 0, 112, accuracy: 0.000001)
    XCTAssertEqual(sizes.state[0]?.height ?? 0, 306.333333, accuracy: 0.000001)
    XCTAssertEqual(sizes.state[1]?.width ?? 0, 112, accuracy: 0.000001)
    XCTAssertEqual(sizes.state[1]?.height ?? 0, 306.333333, accuracy: 0.000001)
    XCTAssertEqual(sizes.state[2]?.width ?? 0, 112, accuracy: 0.000001)
    XCTAssertEqual(sizes.state[2]?.height ?? 0, 20.333333, accuracy: 0.000001)
  }
  
  func testSimpleTableReaderForSizeReporting() {
    struct TestView: View {
      @Binding var sizes: [Int: CGSize]
      @Binding var size0: CGSize
      @Binding var size1: CGSize
      @Binding var width0: CGFloat
      @Binding var height0: CGFloat
      @Binding var width1: CGFloat
      @Binding var height1: CGFloat
      @Binding var columnWidth0: CGFloat
      @Binding var columnWidth1: CGFloat

      var body: some View {
        SimpleTableReader<Int>(maxWidth: 500) { proxy in
          VStack {
            HStack(spacing: 0) {
              Text("John")
                .measure(proxy, 0)
                .frame(minWidth: proxy.columnWidth(0))
              Text("Gattis")
                .measure(proxy, 1)
                .frame(minWidth: proxy.columnWidth(1))
            }
            HStack(spacing: 0) {
              Text("Stephen")
                .measure(proxy, 0)
                .frame(minWidth: proxy.columnWidth(0))
              Text("Arce")
                .measure(proxy, 1)
                .frame(minWidth: proxy.columnWidth(1))
            }
          }
          .onChange(of: proxy.maxSizes) { newValue in
            sizes = newValue
          }
          .onChange(of: proxy.maxSize(0)) { newValue in
            if let newValue = newValue {
              size0 = newValue
            }
          }
          .onChange(of: proxy.maxSize(1)) { newValue in
            if let newValue = newValue {
              size1 = newValue
            }
          }
          .onChange(of: proxy.maxWidth(0)) { newValue in
            if let newValue = newValue {
              width0 = newValue
            }
          }
          .onChange(of: proxy.maxHeight(0)) { newValue in
            if let newValue = newValue {
              height0 = newValue
            }
          }
          .onChange(of: proxy.maxWidth(1)) { newValue in
            if let newValue = newValue {
              width1 = newValue
            }
          }
          .onChange(of: proxy.maxHeight(1)) { newValue in
            if let newValue = newValue {
              height1 = newValue
            }
          }
          .onChange(of: proxy.columnWidth(0)) { newValue in
            if let newValue = newValue {
              columnWidth0 = newValue
            }
          }
          .onChange(of: proxy.columnWidth(1)) { newValue in
            if let newValue = newValue {
              columnWidth1 = newValue
            }
          }
        }
          .frame(width: 500, height: 200)
      }
    }
    
    let sizes = StateContainer<[Int: CGSize]>([:])
    let size0 = StateContainer<CGSize>(.zero)
    let size1 = StateContainer<CGSize>(.zero)
    let width0 = StateContainer<CGFloat>(0)
    let height0 = StateContainer<CGFloat>(0)
    let width1 = StateContainer<CGFloat>(0)
    let height1 = StateContainer<CGFloat>(0)
    let columnWidth0 = StateContainer<CGFloat>(0)
    let columnWidth1 = StateContainer<CGFloat>(1)
    _ = ViewHost {
      TestView(
        sizes: sizes.makeBinding(),
        size0: size0.makeBinding(),
        size1: size1.makeBinding(),
        width0: width0.makeBinding(),
        height0: height0.makeBinding(),
        width1: width1.makeBinding(),
        height1: height1.makeBinding(),
        columnWidth0: columnWidth0.makeBinding(),
        columnWidth1: columnWidth1.makeBinding()
      )
    }
    XCTAssertEqual(sizes.state[0]?.width ?? 0, 63.666666, accuracy: 0.000001)
    XCTAssertEqual(sizes.state[0]?.height ?? 0, 20.333333, accuracy: 0.000001)
    XCTAssertEqual(sizes.state[1]?.width ?? 0, 45, accuracy: 0.000001)
    XCTAssertEqual(sizes.state[1]?.height ?? 0, 20.333333, accuracy: 0.000001)
    XCTAssertEqual(size0.state.width, 63.666666, accuracy: 0.000001)
    XCTAssertEqual(size0.state.height, 20.333333, accuracy: 0.000001)
    XCTAssertEqual(size1.state.width, 45, accuracy: 0.000001)
    XCTAssertEqual(size1.state.height, 20.333333, accuracy: 0.000001)
    XCTAssertEqual(width0.state, 63.666666, accuracy: 0.000001)
    XCTAssertEqual(height0.state, 20.333333, accuracy: 0.000001)
    XCTAssertEqual(width1.state, 45, accuracy: 0.000001)
    XCTAssertEqual(height1.state, 20.333333, accuracy: 0.000001)
    XCTAssertEqual(columnWidth0.state, 259.333333, accuracy: 0.000001)
    XCTAssertEqual(columnWidth1.state, 240.666666, accuracy: 0.000001)
  }
  
  func testSizeReaderForAutoScoping() {
    struct TestView: View {
      @Binding var widths: [CGFloat?]

      var body: some View {
        SizeReader { proxy in
          VStack {
            Color.clear
              .frame(width: 0, height: 1)
              .measure(proxy)
              .onChange(of: proxy.maxWidth()) {
                widths[0] = $0
              }
            // NOTE: currently it supports up to 32 auto scopes, so if we treat into the 33rd here, it would loop back to the 0th one
            ForEach(1..<33) { i in
              SizeReader { nestedProxy in
                Color.clear
                  .frame(width: .init(i), height: 1)
                  .measure(nestedProxy)
                  .onChange(of: nestedProxy.maxWidth()) {
                    widths[i] = $0
                  }
              }
            }
          }
        }
          .frame(width: 500, height: 200)
      }
    }

    let widths = StateContainer<[CGFloat?]>((0..<33).map { _ in nil })
    _ = ViewHost {
      TestView(
        widths: widths.makeBinding()
      )
    }
    for i in 1..<32 {
      XCTAssertEqual(widths.state[i], CGFloat(i))
    }
    // NOTE: this is the expected behavior. although the wanted behavior is to produce 0.0 for the 0th view
    //       and 32.0 for the 32th view here, the 32 auto scopes limit takes the 32th one back to the 0th
    //       one. so the 2 will be using the same auto scope and hence the same preference key type, and it
    //       leads to taking the max of the 2
    XCTAssertEqual(widths.state[0], 32)
    XCTAssertEqual(widths.state[32], 32)
  }
}

#endif
