//
//  DogViewWithBinding.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/26/24.
//

import SwiftUI

struct DogViewWithBinding: DependencyExplainingView {
  
  enum Upstream {
    case state
    case stateObject
    case observedObject
    case bindable
    
    var name: String {
      switch self {
      case .state:
        "@State"
      case .stateObject:
        "@StateObject"
      case .observedObject:
        "@ObservedObject"
      case .bindable:
        "@Bindable"
      }
    }
  }
  
  var dependencyType: String {
    "@Binding with \(upstream.name) Upstream"
  }
  
  typealias Data = Dog
  
  let upstream: Upstream
  
  func makeView1() -> some View {
    switch upstream {
    case .state:
      StateUpstreamView(data: Dog()) { data in
        _View1(dog: data, treat: .bone)
      }
    case .stateObject:
      StateObjectUpstreamView(data: Dog()) { data in
        _View1(dog: data, treat: .bone)
      }
    case .observedObject:
      ObservedObjectUpstreamView(data: Dog()) { data in
        _View1(dog: data, treat: .bone)
      }
    case .bindable:
      BindableUpstreamView(data: Dog()) { data in
        _View1(dog: data, treat: .bone)
      }
    }
  }
  
  func makeView2() -> some View {
    switch upstream {
    case .state:
      StateUpstreamView(data: Dog()) { data in
        _View2(dog: data, treat: .bone)
      }
    case .stateObject:
      StateObjectUpstreamView(data: Dog()) { data in
        _View2(dog: data, treat: .bone)
      }
    case .observedObject:
      ObservedObjectUpstreamView(data: Dog()) { data in
        _View2(dog: data, treat: .bone)
      }
    case .bindable:
      BindableUpstreamView(data: Dog()) { data in
        _View2(dog: data, treat: .bone)
      }
    }
  }
  
  func makeView3() -> some View {
    switch upstream {
    case .state:
      StateUpstreamView(data: Dog()) { data in
        _View3(dog: data, treat: .bone)
      }
    case .stateObject:
      StateObjectUpstreamView(data: Dog()) { data in
        _View3(dog: data, treat: .bone)
      }
    case .observedObject:
      ObservedObjectUpstreamView(data: Dog()) { data in
        _View3(dog: data, treat: .bone)
      }
    case .bindable:
      BindableUpstreamView(data: Dog()) { data in
        _View3(dog: data, treat: .bone)
      }
    }
  }
  
  func makeView4() -> some View {
    switch upstream {
    case .state:
      StateUpstreamView(data: Dog()) { data in
        _View4(dog: data, treat: .bone)
      }
    case .stateObject:
      StateObjectUpstreamView(data: Dog()) { data in
        _View4(dog: data, treat: .bone)
      }
    case .observedObject:
      ObservedObjectUpstreamView(data: Dog()) { data in
        _View4(dog: data, treat: .bone)
      }
    case .bindable:
      BindableUpstreamView(data: Dog()) { data in
        _View4(dog: data, treat: .bone)
      }
    }
  }
  
  struct _View1: DogView {
    
    @Binding
    var dog: Dog
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct _View2: DogView, UseName {
    
    @Binding
    var dog: Dog
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct _View3: DogView, UseHappiness {
    
    @Binding
    var dog: Dog
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }

  struct _View4: DogView, UseName, UseHappiness {
    
    @Binding
    var dog: Dog
    
    var treat: Treat
    
    func reward() {
      dog.reward(treat)
    }
    
  }
  
}

#Preview {
  DogViewWithBinding(upstream: .state)
}
