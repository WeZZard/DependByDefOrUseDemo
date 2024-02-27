//
//  PlatformDependencyExplainingView.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 2/27/24.
//

import SwiftUI

protocol PlatformDependencyExplainingView: UIViewRepresentable, DependencyExplaining where
  Coordinator == PlatformBodyCoordinator,
  UIViewType == PlatformBodyView
{
  
  func action()
  
}

extension PlatformDependencyExplainingView {
  
  func makeUIView(context: Context) -> PlatformBodyView {
    let view = PlatformBodyView()
    view.coordinator = context.coordinator
    return view
  }
  
  func updateUIView(_ uiView: PlatformBodyView, context: Context) {
    uiView.updateUIViewCount += 1
  }
  
  func makeCoordinator() -> PlatformBodyCoordinator {
    PlatformBodyCoordinator(dependencyType: Self.dependencyType) {
      action()
    }
  }
  
}

class PlatformBodyCoordinator: NSObject {
  
  let dependencyType: String
  
  var action: () -> Void
  
  init(dependencyType: String, action: @escaping () -> Void) {
    self.dependencyType = dependencyType
    self.action = action
  }
  
  @objc
  func touchUpInside(_ button: UIButton) {
    action()
  }
  
}

class PlatformBodyView: UIView {
  
  weak var coordinator: PlatformBodyCoordinator?
  
  private var wasInit: Bool = false
  
  private var rootStackView: UIStackView!
  
  private var updateUIViewLabel: UILabel!
  
  var updateUIViewCount: Int = 0 {
    didSet {
      guard let updateUIViewLabel else {
        return
      }
      updateUIViewLabel.text = "x \(updateUIViewCount)"
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    if let rootStackView {
      rootStackView.frame = bounds
    } else {
      setupRootStackView()
    }
  }
  
  func setupRootStackView() {
    guard let coordinator else {
      return
    }
    
    let titleLabel = UILabel()
    titleLabel.text = "View Dependency: \(coordinator.dependencyType)"
    
    let footernoteLabel = UILabel()
    footernoteLabel.text = "Change a dependency but not used."
    
    let button = UIButton(type: .custom)
    button.setImage(UIImage(systemName: "pawprint.fill"), for: .normal)
    button.addTarget(coordinator, action: #selector(PlatformBodyCoordinator.touchUpInside(_:)), for: .touchUpInside)
    
    let updateUIVIewLabel = UILabel()
    self.updateUIViewLabel = updateUIVIewLabel
    let count = self.updateUIViewCount
    self.updateUIViewCount = count
    
    let innerStack = UIStackView(arrangedSubviews: [
      button,
      updateUIVIewLabel,
    ])
    innerStack.axis = .vertical
    innerStack.distribution = .fillEqually
    innerStack.alignment = .center
    innerStack.translatesAutoresizingMaskIntoConstraints = false
    
    let rootStack = UIStackView(arrangedSubviews: [
      titleLabel,
      innerStack,
      footernoteLabel,
    ])
    rootStack.axis = .vertical
    rootStack.distribution = .fillEqually
    rootStack.alignment = .center
    rootStack.spacing = 8
    rootStack.translatesAutoresizingMaskIntoConstraints = false
    
    self.rootStackView = rootStack
    
    addSubview(rootStackView)
    
    let constraints = [
      rootStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      rootStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
    ]
    
    addConstraints(constraints)
  }
  
}
