//
//  ListOfPlatformViews.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/27/24.
//

import SwiftUI

struct ListOfPlatformViews: View {
  
  static let title = "Dog UIViewRepresentables"
  
  var body: some View {
      List {
        NavigationLink(PlatformDogViewWithState())
        NavigationLink(PlatformDogViewWithStateObject())
        NavigationLink(PlatformDogViewWithObservedObject())
        NavigationLink(PlatformDogViewWithObservableInstance())
        NavigationLink(PlatformDogViewWithBinding(upstream: .state))
        NavigationLink(PlatformDogViewWithBinding(upstream: .stateObject))
        NavigationLink(PlatformDogViewWithBinding(upstream: .observedObject))
        NavigationLink(PlatformDogViewWithBinding(upstream: .bindable))
      }.navigationTitle(Self.title)
      .navigationBarTitleDisplayMode(.inline)
  }
  
}
