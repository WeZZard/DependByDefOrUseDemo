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
          NavigationView {
              List {
                NavigationLink(
                  destination: {
                    DogView(dog: Dog(), treat: .bone)
                  },
                  label: {
                    Text("Dog1")
                  })
                NavigationLink(
                  destination: {
                    DogView2(dog: DogObject(), treat: .bone)
                  },
                  label: {
                    Text("Dog2")
                  })
                NavigationLink(
                  destination: {
                    DogView3(dog: DogObject2(), treat: .bone)
                  },
                  label: {
                    Text("Dog3")
                  })
                NavigationLink(
                  destination: {
                    DogView4(dog: Dog4(), treat: .bone)
                  },
                  label: {
                    Text("Dog4")
                  })
              }
          }
        }
    }
}
