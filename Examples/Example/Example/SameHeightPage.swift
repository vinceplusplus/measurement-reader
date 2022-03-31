//
//  SameHeightPage.swift
//  Example
//
//  Created by Vincent Cheung on 31/3/2022.
//

import SwiftUI
import MeasurementReader

struct SameHeightPage: View {
  var body: some View {
    SizeReader { proxy in
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
  }
}

struct SameHeightPage_Previews: PreviewProvider {
    static var previews: some View {
        SameHeightPage()
    }
}
