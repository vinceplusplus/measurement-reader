//
//  Menu.swift
//  Example
//
//  Created by Vincent Cheung on 31/3/2022.
//

import SwiftUI

struct MenuPage: View {
  var body: some View {
    VStack {
      NavigationLink(destination: SameHeightPage()) {
        Text("Same Height")
      }
      NavigationLink(destination: SameWidthPage()) {
        Text("Same Width")
      }
      NavigationLink(destination: SameWidthWithVersionPage()) {
        Text("Same Width with Version")
      }
      NavigationLink(destination: TablePage()) {
        Text("Table")
      }
    }
  }
}

struct MenuPage_Previews: PreviewProvider {
  static var previews: some View {
    MenuPage()
  }
}
