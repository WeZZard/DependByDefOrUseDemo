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
        NavigationLink(ListOfViews.title) {
          ListOfViews()
        }
        NavigationLink(ListOfPlatformViews.title) {
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
  
  init(_ dependencyExplainingView: Destination) where Label == Text, Destination: View & DependencyExplaining {
    self.init(dependencyExplainingView.dependencyType) {
      dependencyExplainingView
    }
  }
  
  init(@ViewBuilder _ dependencyExplainingView: () -> Destination) where Label == Text, Destination: View & DependencyExplaining {
    self.init(dependencyExplainingView())
  }
  
}
