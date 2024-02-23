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
        NavigationLink(
          destination: DogView(dog: Dog(), treat: .bone).onDisappear {
            CountView.clear()
          },
          label: {
            Text("Dependency: ") + Text(verbatim: DogView.dependencyType)
          })
        NavigationLink(
          destination: DogView2(dog: DogObject(), treat: .bone).onDisappear {
            CountView.clear()
          },
          label: {
            Text("Dependency: ") + Text(verbatim: DogView2.dependencyType)
          })
        NavigationLink(
          destination: DogView3(dog: DogObject2(), treat: .bone).onDisappear {
            CountView.clear()
          },
          label: {
            Text("Dependency: ") + Text(verbatim: DogView3.dependencyType)
          })
        NavigationLink(
          destination: DogView4(dog: Dog4(), treat: .bone).onDisappear {
            CountView.clear()
          },
          label: {
            Text("Dependency: ") + Text(verbatim: DogView4.dependencyType)
          })
      }.navigationTitle("Depdendency change without use")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
  
}
