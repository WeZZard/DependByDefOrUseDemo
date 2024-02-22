//
//  ContentView.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/12/24.
//

import SwiftUI
import Observation

@Observable
private class Model {
  
  var activeCounter: ActiveCounter = .counter1
  
  var counter1 = 0
  
  var counter2 = 1
  
}

private var bodyAccessCount: Int = 0

struct ContentView: View {
  
  var body: some View {
    VStack {
      Text("State")
      StateView()
    }
    VStack {
      Text("Observation")
      ObservationView()
    }
  }
  
}

#Preview {
  ContentView()
}

struct StateView: View {
  
  @State
  var activeCounter: ActiveCounter = .counter1
  
  @State
  var counter1 = 0
  
  @State
  var counter2 = 1
  
  var body: some View {
    let _ = (bodyAccessCount += 1)
    Text("Body access count: ") + Text(verbatim: bodyAccessCount.description)
    VStack {
      Text("Active counter: ") + Text(verbatim: activeCounter.name)
      switch activeCounter {
      case .counter1:
        Text("Counter value: ") + Text(verbatim: counter1.description)
      case .counter2:
        Text("Counter value: ") + Text(verbatim: counter2.description)
      }
      Button("Activate counter 1") {
        activeCounter = .counter1
      }
      Button("Activate counter 2") {
        activeCounter = .counter2
      }
      Button("Increase counter 1") {
        counter1 += 1
      }
      Button("Increase counter 2") {
        counter2 += 1
      }
    }
    .padding()
    .border(.secondary, width: 0.5)
  }
  
}

struct ObservationView: View {
  
  private var model = Model()
  
  var body: some View {
    let _ = (bodyAccessCount += 1)
    Text("Body access count: ") + Text(verbatim: bodyAccessCount.description)
    VStack {
      Text("Active counter: ") + Text(verbatim: model.activeCounter.name)
      switch model.activeCounter {
      case .counter1:
        Text("Counter value: ") + Text(verbatim: model.counter1.description)
      case .counter2:
        Text("Counter value: ") + Text(verbatim: model.counter2.description)
      }
      Button("Activate counter 1") {
        model.activeCounter = .counter1
      }
      Button("Activate counter 2") {
        model.activeCounter = .counter2
      }
      Button("Increase counter 1") {
        model.counter1 += 1
      }
      Button("Increase counter 2") {
        model.counter2 += 1
      }
    }
    .padding()
    .border(.secondary, width: 0.5)
  }
  
}
