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
        NavigationLink(PlatformDogViewWithState(dog: Dog(), treat: .bone))
        NavigationLink(PlatformDogViewWithStateObject(dog: DogObject(), treat: .bone))
        NavigationLink(PlatformDogViewWithObservedObject(dog: DogObject(), treat: .bone))
        NavigationLink(PlatformDogViewWithObservableInstance(dog: DogObject2(), treat: .bone))
        NavigationLink(PlatformDogViewWithEnvironment(dog: Dog(), treat: .bone))
        /*
        NavigationLink {
          StateWrapperView(data: Dog()) { data in
            PlatformDogViewWithBinding(dog: data, treat: .bone)
          }
        }
        NavigationLink {
          StateObjectWrapperView(data: Dog()) { data in
            PlatformDogViewWithBinding(dog: data, treat: .bone)
          }
        }
        NavigationLink {
          ObservedObjectWrapperView(data: Dog()) { data in
            PlatformDogViewWithBinding(dog: data, treat: .bone)
          }
        }
        NavigationLink {
          BindableWrapperView(data: Dog()) { data in
            PlatformDogViewWithBinding(dog: data, treat: .bone)
          }
        }
         */
      }.navigationTitle(Self.title)
      .navigationBarTitleDisplayMode(.inline)
  }
  
}

