//
//  ListOfViews.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/27/24.
//

import SwiftUI

struct ListOfViews: View {
  
  var body: some View {
      List {
        NavigationLink(DogViewWithState(dog: Dog(), treat: .bone))
        NavigationLink(DogViewWithStateObject(dog: DogObject(), treat: .bone))
        NavigationLink(DogViewWithObservableInstance(dog: DogObject2(), treat: .bone))
        NavigationLink(DogViewWithEnvironment(dog: Dog(), treat: .bone))
        NavigationLink {
          StateWrapperView(data: Dog()) { data in
            DogViewWithBinding(dog: data, treat: .bone)
          }
        }
        NavigationLink {
          StateObjectWrapperView(data: Dog()) { data in
            DogViewWithBinding(dog: data, treat: .bone)
          }
        }
        NavigationLink {
          ObservedObjectWrapperView(data: Dog()) { data in
            DogViewWithBinding(dog: data, treat: .bone)
          }
        }
        NavigationLink {
          BindableWrapperView(data: Dog()) { data in
            DogViewWithBinding(dog: data, treat: .bone)
          }
        }
      }.navigationTitle("View Examples")
      .navigationBarTitleDisplayMode(.inline)
  }
  
}
