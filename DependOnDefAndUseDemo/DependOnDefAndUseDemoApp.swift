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
        NavigationLink("View Examples") {
          ListOfViews()
        }
        NavigationLink("UIViewRepresentable Examples") {
          ListOfPlatformViews()
        }
        NavigationLink("@State v.s. Observation") {
          StateVSObservationView()
        }
        NavigationLink("UIViewRepresentable and Environment System") {
          UIViewRepresentableAndEnvironment()
        }
      }.navigationTitle("Depdendency build patterns")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
  
}

extension NavigationLink {
  
  init<Content: View & DependencyExplaining>(_ dependencyExplainingView: Content) where Label == Text, Destination == AnyView {
    self.init("\(Content.dependencyType)") {
      AnyView(
        dependencyExplainingView.clearViewBodyProduceCount()
      )
    }
  }
  
  init<Content: View & DependencyExplaining>(@ViewBuilder _ dependencyExplainingView: () -> Content) where Label == Text, Destination == AnyView {
    self.init(dependencyExplainingView())
  }
  
}
