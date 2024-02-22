//
//  UIViewRepresentable.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/13/24.
//

import SwiftUI

struct UIViewRepresentableExample: View {
  
  @State
  var activeCounter: ActiveCounter = .counter1
  
  @State
  var counter1: Int = 0
  
  @State
  var counter2: Int = 0
  
  
  var body: some View {
    VStack {
      VStack {
        Text("Original Info:")
        Text("Active counter: ") + Text(verbatim: activeCounter.name)
        Text("Counter 1 value: ") + Text(verbatim: counter1.description)
        Text("Counter 2 value: ") + Text(verbatim: counter2.description)
      }.border(.secondary, width: 0.5)
      VStack {
        Text("Depend-by-use, changed-def-and-sue")
        DependByUseChangedDefAndUse(activeCounter: activeCounter)
          .environment(\.counter1, counter1)
          .environment(\.counter2, counter2)
          .border(.secondary, width: 0.5)
      }
      VStack {
        Text("Depend-by-use, changed-use")
        DependByUseChangedUse()
          .environment(\.counter1, counter1)
          .environment(\.counter2, counter2)
          .environment(\.activeCounter, activeCounter)
          .border(.secondary, width: 0.5)
      }
      VStack {
        Text("Depend-by-def, changed-def")
        DependByDefChangedDef(activeCounter: activeCounter)
          .environment(\.counter1, counter1)
          .environment(\.counter2, counter2)
          .border(.secondary, width: 0.5)
      }
      VStack {
        Text("Depend-by-def, changed-def-2")
        DependByDefChangedDef2()
          .environment(\.counter1, counter1)
          .environment(\.counter2, counter2)
          .environment(\.activeCounter, activeCounter)
          .border(.secondary, width: 0.5)
      }
    }.padding()
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
}

private struct CounterView: View {
  
  var activeCounter: ActiveCounter
  
  var counter: Int
  
  var updateCount: Int
  
  var counterText: String {
    counter.description
  }
  
  var updateCountText: String {
    updateCount.description
  }
  
  var body: some View {
    VStack {
      HStack {
        Text("Active counter: \(activeCounter.name)")
      }
      Spacer()
      HStack {
        Text("Counter value: ")
        Text(verbatim: counterText)
          .monospacedDigit()
      }
      Spacer()
      VStack(alignment: .trailing) {
        HStack {
          Spacer()
          Text("Update count: ")
          Text(verbatim: updateCountText)
            .monospacedDigit()
        }
      }
    }
    .padding()
  }
  
}

extension _UIHostingView where Content == CounterView {
  
  fileprivate convenience init(activeCounter: ActiveCounter, counter: Int, updateCount: Int) {
    self.init(rootView: CounterView(activeCounter: activeCounter, counter: counter, updateCount: updateCount))
  }
  
}

private class PlatformCoordinator {
  
  var updateCount: Int = 0
  
}

private protocol PlatformCounterView: UIViewRepresentable where Self.Coordinator == PlatformCoordinator {
  
  func activeCounter(for context: Context) -> ActiveCounter
  
  func counter(for context: Context) -> Int
  
}

extension PlatformCounterView {
  
  func makeUIView(context: Context) -> _UIHostingView<CounterView> {
    _UIHostingView<CounterView>(activeCounter: .counter1, counter: 0, updateCount: 0)
  }
  
  func updateUIView(_ uiView: _UIHostingView<CounterView>, context: Context) {
    context.coordinator.updateCount += 1
    uiView.rootView.activeCounter = activeCounter(for: context)
    uiView.rootView.counter = counter(for: context)
    uiView.rootView.updateCount = context.coordinator.updateCount
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator()
  }
  
}

private struct DependByUseChangedDefAndUse: PlatformCounterView {
  
  var activeCounter: ActiveCounter
  
  func counter(for context: Context) -> Int {
    switch activeCounter {
    case .counter1:
      context.environment.counter1
    case .counter2:
      context.environment.counter2
    }
  }
  
  func activeCounter(for context: Context) -> ActiveCounter {
    activeCounter
  }
}

private struct DependByUseChangedUse: PlatformCounterView {
  
  func counter(for context: Context) -> Int {
    switch context.environment.activeCounter {
    case .counter1:
      context.environment.counter1
    case .counter2:
      context.environment.counter2
    }
  }
  
  func activeCounter(for context: Context) -> ActiveCounter {
    context.environment.activeCounter
  }
  
}

private struct DependByDefChangedDef: PlatformCounterView {
  
  @Environment(\.counter1)
  var counter1
  
  @Environment(\.counter2)
  var counter2
  
  var activeCounter: ActiveCounter
  
  func counter(for context: Context) -> Int {
    switch activeCounter {
    case .counter1:
      counter1
    case .counter2:
      counter2
    }
  }
  
  func activeCounter(for context: Context) -> ActiveCounter {
    activeCounter
  }
  
}

private struct DependByDefChangedDef2: PlatformCounterView {
  
  @Environment(\.counter1)
  var counter1
  
  @Environment(\.counter2)
  var counter2
  
  @Environment(\.activeCounter)
  var activeCounter
  
  func counter(for context: Context) -> Int {
    switch activeCounter {
    case .counter1:
      counter1
    case .counter2:
      counter2
    }
  }
  
  func activeCounter(for context: Context) -> ActiveCounter {
    activeCounter
  }
  
}

#Preview {
  UIViewRepresentableExample()
}
