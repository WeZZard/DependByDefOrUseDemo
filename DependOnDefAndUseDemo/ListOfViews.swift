//
//  ListOfViews.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/27/24.
//

import SwiftUI

struct ListOfViews: View {
  
  static let title = "Dog Views"
  
  var body: some View {
      List {
        NavigationLink(DogViewWithState())
        NavigationLink(DogViewWithStateObject())
        NavigationLink(DogViewWithObservedObject())
        NavigationLink(DogViewWithObservableInstance())
        NavigationLink(DogViewWithEnvironment())
        NavigationLink(DogViewWithEnvironmentObject())
        NavigationLink(DogViewWithBinding(upstream: .state))
        NavigationLink(DogViewWithBinding(upstream: .stateObject))
        NavigationLink(DogViewWithBinding(upstream: .observedObject))
        NavigationLink(DogViewWithBinding(upstream: .bindable))
      }.navigationTitle(Self.title)
      .navigationBarTitleDisplayMode(.inline)
  }
  
}
