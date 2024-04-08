//
//  DependencyExplainingView.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 3/2/24.
//

import SwiftUI

// MARK: - DependencyExplainingView

protocol DependencyExplainingView: View, DependencyExplaining {
  
  associatedtype View1: View
  associatedtype View2: View
  associatedtype View3: View
  associatedtype View4: View
  associatedtype ViewModifierType: ViewModifier = EmptyViewModifier
  
  @ViewBuilder
  func makeView1() -> View1
  
  @ViewBuilder
  func makeView2() -> View2
  
  @ViewBuilder
  func makeView3() -> View3
  
  @ViewBuilder
  func makeView4() -> View4
  
  func makeViewModifier() -> ViewModifierType
  
}

extension DependencyExplainingView {
  
  var body: some View {
    VStack(spacing: 32) {
      Text(verbatim: dependencyType)
        .font(.title)
      Grid {
        GridRow {
          makeView1().modifier(makeViewModifier()).padding()
          makeView2().modifier(makeViewModifier()).padding()
        }
        GridRow {
          makeView3().modifier(makeViewModifier()).padding()
          makeView4().modifier(makeViewModifier()).padding()
        }
      }
    }
  }
  
  func makeViewModifier() -> EmptyViewModifier {
    EmptyViewModifier()
  }
  
}

struct EmptyViewModifier: ViewModifier {
  
  func body(content: Content) -> some View {
    content
  }
  
}

extension DependencyExplainingView where Self.View1: DogViewEnvironmentInit {
  
  func makeView1() -> View1 {
    View1(treat: .bone)
  }
  
}

extension DependencyExplainingView where Self.View2: DogViewEnvironmentInit {
  
  func makeView2() -> View2 {
    View2(treat: .bone)
  }
  
}

extension DependencyExplainingView where Self.View3: DogViewEnvironmentInit {
  
  func makeView3() -> View3 {
    View3(treat: .bone)
  }
  
}

extension DependencyExplainingView where Self.View4: DogViewEnvironmentInit {
  
  func makeView4() -> View4 {
    View4(treat: .bone)
  }
  
}

// MARK: SimpleInitDependencyExplainingView

protocol SimpleInitDependencyExplainingView: DependencyExplainingView where
  View1: DogView,
  View2: DogView,
  View3: DogView,
  View4: DogView,
  View1.DogType == Data,
  View2.DogType == Data,
  View3.DogType == Data,
  View4.DogType == Data
{
  
  associatedtype Data: DogProtocol
  
  func makeData() -> Data
  
}

extension SimpleInitDependencyExplainingView where Self.View1: DogViewSimplInit {
  
  func makeView1() -> View1 {
    View1(dog: makeData(), treat: .bone)
  }
  
}

extension SimpleInitDependencyExplainingView where Self.View2: DogViewSimplInit {
  
  func makeView2() -> View2 {
    View2(dog: makeData(), treat: .bone)
  }
  
}

extension SimpleInitDependencyExplainingView where Self.View3: DogViewSimplInit {
  
  func makeView3() -> View3 {
    View3(dog: makeData(), treat: .bone)
  }
  
}

extension SimpleInitDependencyExplainingView where Self.View4: DogViewSimplInit {
  
  func makeView4() -> View4 {
    View4(dog: makeData(), treat: .bone)
  }
  
}

// MARK: EnvironmentObjectExplainingView

protocol EnvironmentObjectExplainingView: DependencyExplainingView where
  View1: DogView,
  View2: DogView,
  View3: DogView,
  View4: DogView,
  View1.DogType == EnvironmentObjectType,
  View2.DogType == EnvironmentObjectType,
  View3.DogType == EnvironmentObjectType,
  View4.DogType == EnvironmentObjectType
{
  
  associatedtype EnvironmentObjectType: DogProtocol & ObservableObject
  
  func makeEnvironmentObject() -> EnvironmentObjectType
  
}

struct EnvironmentObjectModifier<DogType: DogProtocol & ObservableObject>: ViewModifier {
  
  @StateObject
  var once: DogType
  
  func body(content: Content) -> some View {
    content
      .environmentObject(once)
  }
  
}

extension EnvironmentObjectExplainingView {
  
  func makeViewModifier() -> EnvironmentObjectModifier<EnvironmentObjectType> {
    EnvironmentObjectModifier(once: makeEnvironmentObject())
  }
  
}


// MARK: EnvironmentExplainingView

protocol EnvironmentExplainingView: DependencyExplainingView where
  View1: DogView,
  View2: DogView,
  View3: DogView,
  View4: DogView,
  View1.DogType == EnvironmentValueType,
  View2.DogType == EnvironmentValueType,
  View3.DogType == EnvironmentValueType,
  View4.DogType == EnvironmentValueType
{
  
  associatedtype EnvironmentValueType: DogProtocol & Equatable
  
}

struct EnvironmentValueReadingViewModifier<DogType: DogProtocol & Equatable>: ViewModifier {
  
  func body(content: Content) -> some View {
    DogValueKey<DogType>._delay { value in
      value._force { value in
        makeBody(content: content, value: value)
      }
    }
  }
  
  @ViewBuilder
  private func makeBody(content: Content, value: DogType?) -> some View {
    if let value {
      content
        .environment(DogType.keyPath, value)
    } else {
      content
    }
  }
  
}

extension EnvironmentExplainingView {
  
  func makeViewModifier() -> EnvironmentValueReadingViewModifier<EnvironmentValueType> {
    EnvironmentValueReadingViewModifier()
  }
  
}
