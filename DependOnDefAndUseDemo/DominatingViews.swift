//
//  BindingUpstreamView.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/27/24.
//

import SwiftUI

// MARK: BindingUpstreamView

protocol BindingUpstreamView: View {
  
  associatedtype Data
  
  associatedtype Content: View
  
  var dataBinding: Binding<Data> { get }
  
  var content: (_ data: Binding<Data>) -> Content { get }
  
  init(data: Data, content: @escaping (_: Binding<Data>) -> Content)
  
}

extension BindingUpstreamView {
  
  @ViewBuilder
  var body: some View {
    content(dataBinding)
  }
  
}

// MARK: Implementations

struct StateWrapperView<Content: View, Data>: BindingUpstreamView {
  
  @State
  var data: Data
  
  let content: (_ data: Binding<Data>) -> Content
  
  var dataBinding: Binding<Data> {
    $data
  }
  
}

struct StateObjectWrapperView<Content: View, Data>: BindingUpstreamView {
  
  private class Store: ObservableObject {
    
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

struct ObservedObjectWrapperView<Content: View, Data>: BindingUpstreamView {
  
  private class Store: ObservableObject {
    
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

struct BindableWrapperView<Content: View, Data>: BindingUpstreamView {
  
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
