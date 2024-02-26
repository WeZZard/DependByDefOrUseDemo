//
//  WrapperViews.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/27/24.
//

import SwiftUI

struct StateWrapperView<Content: View & DependencyExplaining, Data>: View, DependencyExplaining {
  
  static var dependencyType: String {
    "@State wrapped \(Content.dependencyType)"
  }
  
  @State
  var data: Data
  
  let content: (_ data: Binding<Data>) -> Content
  
  var body: some View {
    content($data)
  }
  
}

struct StateObjectWrapperView<Content: View & DependencyExplaining, Data>: View, DependencyExplaining {
  
  static var dependencyType: String {
    "@StateObject wrapped \(Content.dependencyType)"
  }
  
  class Store: ObservableObject {
    
    var data: Data
    
    init(data: Data) {
      self.data = data
    }
    
  }
  
  @StateObject
  var store: Store
  
  let content: (_ data: Binding<Data>) -> Content
  
  init(data: Data, content: @escaping (_: Binding<Data>) -> Content) {
    self._store = StateObject(wrappedValue: Store(data: data))
    self.content = content
  }
  
  var body: some View {
    content($store.data)
  }
  
}

struct ObservedObjectWrapperView<Content: View & DependencyExplaining, Data>: View, DependencyExplaining {
  
  static var dependencyType: String {
    "@ObservedObject wrapped \(Content.dependencyType)"
  }
  
  class Store: ObservableObject {
    
    var data: Data
    
    init(data: Data) {
      self.data = data
    }
    
  }
  
  @ObservedObject
  var store: Store
  
  let content: (_ data: Binding<Data>) -> Content
  
  init(data: Data, content: @escaping (_: Binding<Data>) -> Content) {
    self._store = ObservedObject(wrappedValue: Store(data: data))
    self.content = content
  }
  
  var body: some View {
    content($store.data)
  }
  
}

struct BindableWrapperView<Content: View & DependencyExplaining, Data>: View, DependencyExplaining {
  
  static var dependencyType: String {
    "@Observable instance wrapped \(Content.dependencyType)"
  }
  
  @Observable
  class Store {
    
    var data: Data
    
    init(data: Data) {
      self.data = data
    }
    
  }
  
  @Bindable
  var store: Store
  
  let content: (_ data: Binding<Data>) -> Content
  
  init(data: Data, content: @escaping (_: Binding<Data>) -> Content) {
    self._store = Bindable(Store(data: data))
    self.content = content
  }
  
  var body: some View {
    content($store.data)
  }
  
}
