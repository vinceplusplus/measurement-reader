//
//  TablePage.swift
//  Example
//
//  Created by Vincent Cheung on 1/4/2022.
//

import SwiftUI
import MeasurementReader

fileprivate enum Field {
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

struct TablePage: View {
  @Environment(\.horizontalSizeClass) var horizontalSizeClass
  @Environment(\.deviceOrientation) var deviceOrientation

  func renderList(pageSize: CGSize) -> some View {
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
    
    return SimpleSizeReader { containerProxy in
      VStack(spacing: 0) {
        Color.clear
          .frame(height: 0)
          .measure(containerProxy)
        
        ScrollView {
          SimpleTableReader<Field>(
            maxWidth: (containerProxy.maxWidth() ?? 0) - 16 * 2,  // minus horizontal padding
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
                  
                  if horizontalSizeClass == .regular || deviceOrientation.isLandscape {
                    VStack {
                      Text("\(food.fat)")
                        .padding(.horizontal, 8)
                        .measure(proxy, .fat)
                    }
                    .frame(minWidth: proxy.columnWidth(.fat), alignment: .trailing)
                    
                    VStack {
                      Text("\(food.cholestrol)")
                        .padding(.horizontal, 8)
                        .measure(proxy, .cholestrol)
                    }
                    .frame(minWidth: proxy.columnWidth(.cholestrol), alignment: .trailing)
                    
                    VStack {
                      Text("\(food.sodium)")
                        .padding(.horizontal, 8)
                        .measure(proxy, .sodium)
                    }
                    .frame(minWidth: proxy.columnWidth(.sodium), alignment: .trailing)
                    
                    VStack {
                      Text("\(food.carb)")
                        .padding(.horizontal, 8)
                        .measure(proxy, .carb)
                    }
                    .frame(minWidth: proxy.columnWidth(.carb), alignment: .trailing)
                    
                    VStack {
                      Text("\(food.protein)")
                        .padding(.horizontal, 8)
                        .measure(proxy, .protein)
                    }
                    .frame(minWidth: proxy.columnWidth(.protein), alignment: .trailing)
                  }
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
  }
  
  var body: some View {
    GeometryReader { proxy in
      Color.clear
        .overlay(
          renderList(pageSize: proxy.size)
        )
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Nutrition Facts")
    }
  }
}

struct TablePage_Previews: PreviewProvider {
  static var previews: some View {
    TablePage()
  }
}
