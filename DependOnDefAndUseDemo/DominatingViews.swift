//
//  DominatingView.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/27/24.
//

import SwiftUI

// MARK: DominatingView

protocol DominatingView: View, DependencyExplaining {
  
  associatedtype Data
  
  associatedtype Content: View & DependencyExplaining
  
  var dataBinding: Binding<Data> { get }
  
  var content: (_ data: Binding<Data>) -> Content { get }
  
  init(data: Data, content: @escaping (_: Binding<Data>) -> Content)
  
}

extension DominatingView {
  
  @ViewBuilder
  var body: some View {
    Text("\(Self.dependencyType)")
    content(dataBinding)
  }
  
}

// MARK: Implementations

struct StateWrapperView<Content: View & DependencyExplaining, Data>: DominatingView {
  
  static var dependencyType: String {
    "@State dominated \(Content.dependencyType)"
  }
  
  @State
  var data: Data
  
  let content: (_ data: Binding<Data>) -> Content
  
  var dataBinding: Binding<Data> {
    $data
  }
  
}

struct StateObjectWrapperView<Content: View & DependencyExplaining, Data>: DominatingView {
  
  static var dependencyType: String {
    "@StateObject dominated \(Content.dependencyType)"
  }
  
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

struct ObservedObjectWrapperView<Content: View & DependencyExplaining, Data>: DominatingView {
  
  static var dependencyType: String {
    "@ObservedObject dominated \(Content.dependencyType)"
  }
  
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

struct BindableWrapperView<Content: View & DependencyExplaining, Data>: DominatingView {
  
  static var dependencyType: String {
    "@Bindable dominated \(Content.dependencyType)"
  }
  
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
