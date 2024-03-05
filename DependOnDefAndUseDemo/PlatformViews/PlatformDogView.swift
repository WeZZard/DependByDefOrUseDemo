//
//  PlatformDogView.swift
//  DependOnDefAndUseDemo
//
//  Created by WeZZard on 3/5/24.
//

import SwiftUI

protocol PlatformDogView: UIViewRepresentable, DogView where
  Coordinator == PlatformBodyCoordinator,
  UIViewType == PlatformBodyView
{
  
}

extension PlatformDogView {
  
  func makeUIView(context: Context) -> PlatformBodyView {
    let view = Bundle.main.loadNibNamed("PlatformDogView", owner: context.coordinator, options: nil)!.first as! PlatformBodyView
    view.coordinator = context.coordinator
    return view
  }
  
  func updateUIView(_ uiView: PlatformBodyView, context: Context) {
    uiView.updateUIViewCount += 1
    uiView.usesDogName = Self.usesName
    if Self.usesName {
      uiView.dogName = dog.name
    } else {
      uiView.dogName = nil
    }
    uiView.usesHappiness = Self.usesHappiness
    if Self.usesHappiness {
      uiView.happiness = dog.happiness
    } else {
      uiView.happiness = nil
    }
  }
  
  func makeCoordinator() -> PlatformBodyCoordinator {
    PlatformBodyCoordinator(reward: reward)
  }
  
}

class PlatformBodyCoordinator: NSObject {
  
  var reward: () -> Void
  
  init(reward: @escaping () -> Void) {
    self.reward = reward
  }
  
  @objc
  func touchUpInside(_ button: UIButton) {
    reward()
  }
  
}

class PlatformBodyView: UIView {
  
  weak var coordinator: PlatformBodyCoordinator?
  
  var environmentDogUsingView: UIView?
  
  var dogName: String? {
    didSet {
      if let dogName {
        dogNameLabel.text = dogName
      } else {
        dogNameLabel.text = "?"
      }
    }
  }
  
  var happiness: Int? {
    didSet {
      if let happiness {
        happinessLabel.text = "\(happiness)"
      } else {
        happinessLabel.text = "?"
      }
    }
  }
  
  var updateUIViewCount: Int = 0 {
    didSet {
      updateUIViewLabel.text = "x\(updateUIViewCount)"
    }
  }
  
  var usesDogName: Bool = true {
    didSet {
      if usesDogName {
        usesDogNameStateView.image = UIImage(systemName: "checkmark")
        usesDogNameStateView.tintColor = .systemGreen
      } else {
        usesDogNameStateView.image = UIImage(systemName: "xmark")
        usesDogNameStateView.tintColor = .systemRed
      }
    }
  }
  
  var usesHappiness: Bool = true {
    didSet {
      if usesHappiness {
        usesHappinessStateView.image = UIImage(systemName: "checkmark")
        usesHappinessStateView.tintColor = .systemGreen
      } else {
        usesHappinessStateView.image = UIImage(systemName: "xmark")
        usesHappinessStateView.tintColor = .systemRed
      }
    }
  }
  
  @IBOutlet
  weak var animalFaceView: UIImageView!
  
  @IBOutlet
  weak var usesDogNameStateView: UIImageView!
  
  @IBOutlet
  weak var usesHappinessStateView: UIImageView!
  
  @IBOutlet
  weak var rewardButton: UIButton!
  
  @IBOutlet
  weak var updateUIViewLabel: UILabel!
  
  @IBOutlet
  weak var dogNameLabel: UILabel!
  
  @IBOutlet
  weak var happinessLabel: UILabel!
  
  @IBAction
  func reward(_ sender: UIButton) {
    guard let coordinator else {
      return
    }
    coordinator.reward()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let digitFontDesc = happinessLabel.font.fontDescriptor.withSymbolicTraits(.traitMonoSpace)!
    let size = happinessLabel.font.pointSize
    happinessLabel.font = UIFont(descriptor: digitFontDesc, size: size)
    updateUIViewLabel.font = UIFont(descriptor: digitFontDesc, size: size)
    
    if let environmentDogUsingView, environmentDogUsingView.superview != nil {
      addSubview(environmentDogUsingView)
      sendSubviewToBack(environmentDogUsingView)
      environmentDogUsingView.frame = bounds
      environmentDogUsingView.setNeedsLayout()
    }
  }
  
}

private struct ExamplePlatformDogView: PlatformDogView {
  
  @State var dog: Dog
  
  var treat: Treat
  
  func reward() {
    dog.reward(treat)
  }
  
  static var usesDogName: Bool { true }
  
  static var usesHappiness: Bool { true }
  
}

#Preview {
  ExamplePlatformDogView(dog: Dog(), treat: .bone)
}
