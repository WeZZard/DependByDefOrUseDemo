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
  
  @ViewBuilder
  func makeView1() -> View1
  
  @ViewBuilder
  func makeView2() -> View2
  
  @ViewBuilder
  func makeView3() -> View3
  
  @ViewBuilder
  func makeView4() -> View4
  
}

extension DependencyExplainingView {
  
  var body: some View {
    VStack(spacing: 32) {
      Text(verbatim: dependencyType)
        .font(.title)
      Grid {
        GridRow {
          makeView1().padding()
          makeView2().padding()
        }
        GridRow {
          makeView3().padding()
          makeView4().padding()
        }
      }
    }
  }
  
}
