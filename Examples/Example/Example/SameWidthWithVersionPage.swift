//
//  SameWidthPage.swift
//  Example
//
//  Created by Vincent Cheung on 31/3/2022.
//

import SwiftUI
import MeasurementReader

fileprivate enum Field {
  case no
  case name
  case address
}

struct SameWidthWithVersionPage: View {
  var persons: some View {
    let data: [(no: String, name: String, address: String)] = [
      ("No.", "Name", "Address"),
      ("8", "John Gattis", "953 Progress Way Hutchinson, MN"),
      ("9", "Stephen Arce", "695 Tori Lane Ogden, UT"),
      ("10", "Ashley Barna", "607 Harry Place Charlotte, NC"),
      ("11", "Angela Herron", "4999 Valley Lane Austin, TX"),
      ("13", "Some really really long name", "2388 Collins Street Tampa, FL"),
    ]
    
    return SimpleSizeReader { containerProxy in
      VStack(spacing: 0) {
        Color.clear
          .frame(height: 0)
          .measure(containerProxy)
        
        SimpleMeasurementReader<Field>(version: containerProxy.maxWidth()) { proxy in
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
      }
    }
  }
  
  var body: some View {
    Color.clear
      .overlay(
        ScrollView {
          persons
            .padding(.horizontal, 32)
        }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      )
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("Persons")
  }
}

struct SameWidthWithVersion_Previews: PreviewProvider {
  static var previews: some View {
    SameWidthWithVersionPage()
  }
}
