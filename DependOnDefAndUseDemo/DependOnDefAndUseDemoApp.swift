//
//  DependOnDefAndUseDemoApp.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/12/24.
//

import SwiftUI

@main
struct DependOnDefAndUseDemoApp: App {
    var body: some Scene {
        WindowGroup {
          DogViewList()
        }
    }
}

struct DogViewList: View {
  
  var body: some View {
    NavigationView {
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
      }.navigationTitle("Depdendency change without use")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
  
}

extension NavigationLink {
  
  init<Content: View & DependencyExplaining>(_ dependencyExplainingView: Content) where Label == Text, Destination == AnyView {
    self.init("Dependency: \(Content.dependencyType)") {
      AnyView(
        dependencyExplainingView.clearViewBodyProduceCount()
      )
    }
  }
  
  init<Content: View & DependencyExplaining>(@ViewBuilder _ dependencyExplainingView: () -> Content) where Label == Text, Destination == AnyView {
    self.init("Dependency: \(Content.dependencyType)") {
      AnyView(
        dependencyExplainingView().clearViewBodyProduceCount()
      )
    }
  }
  
}
