//
//  BindingUpstreamView.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 3/2/24.
//

import SwiftUI

// MARK: BindingUpstreamView

// MARK: Implementations

struct StateUpstreamView<Content: View, Data>: BindingUpstreamView {
  
  @State
  private var data: Data
  
  let content: (_ data: Binding<Data>) -> Content
  
  var dataBinding: Binding<Data> {
    $data
  }
  
  init(data: Data, content: @escaping (_: Binding<Data>) -> Content) {
    self._data = State(wrappedValue: data)
    self.content = content
  }
  
}

struct StateObjectUpstreamView<Content: View, Data>: BindingUpstreamView {
  
  private class Store: ObservableObject {
    
    @Published
    var data: Data
    
    init(data: Data) {
      self.data = data
    }
    
  }
  
  @StateObject
  private var store: Store
  
  let content: (_ data: Binding<Data>) -> Content
  
  var dataBinding: Binding<Data> {
    $store.data
  }
  
  init(data: Data, content: @escaping (_: Binding<Data>) -> Content) {
    self._store = StateObject(wrappedValue: Store(data: data))
    self.content = content
  }
  
}

struct ObservedObjectUpstreamView<Content: View, Data>: BindingUpstreamView {
  
  private class Store: ObservableObject {
    
    @Published
    var data: Data
    
    init(data: Data) {
      self.data = data
    }
    
  }
  
  @ObservedObject
  private var store: Store
  
  let content: (_ data: Binding<Data>) -> Content
  
  var dataBinding: Binding<Data> {
    $store.data
  }
  
  init(data: Data, content: @escaping (_: Binding<Data>) -> Content) {
    self._store = ObservedObject(wrappedValue: Store(data: data))
    self.content = content
  }
  
}

struct BindableUpstreamView<Content: View, Data>: BindingUpstreamView {
  
  @Observable
  fileprivate class Store {
    
    var data: Data
    
    init(data: Data) {
      self.data = data
    }
    
  }
  
  @Bindable
  private var store: Store
  
  let content: (_ data: Binding<Data>) -> Content
  
  var dataBinding: Binding<Data> {
    $store.data
  }
  
  init(data: Data, content: @escaping (_: Binding<Data>) -> Content) {
    self._store = Bindable(Store(data: data))
    self.content = content
  }
  
}

struct BindableEnvironmentUpstreamView<Content: View, Data>: BindingUpstreamView {
  
  @Observable
  fileprivate class Store {
    
    var data: Data
    
    init(data: Data) {
      self.data = data
    }
    
  }
  
  @Bindable
  private var store: Store
  
  let content: (_ data: Binding<Data>) -> Content
  
  var dataBinding: Binding<Data> {
    $store.data
  }
  
  init(data: Data, content: @escaping (_: Binding<Data>) -> Content) {
    self._store = Bindable(Store(data: data))
    self.content = content
  }
  
}
