
import Foundation
import UIKit

public class AppearanceNavigationController: UINavigationController, UINavigationControllerDelegate {
  
  public required init?(coder decoder: NSCoder) {
    super.init(coder: decoder)
    
    delegate = self
  }
  
  override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    
    delegate = self
  }
  
  override public init(rootViewController: UIViewController) {
    super.init(rootViewController: rootViewController)
    
    delegate = self
  }
  
  public convenience init() {
    self.init(nibName: nil, bundle: nil)
  }
  
  // MARK: - UINavigationControllerDelegate
  
  public func navigationController(_ navigationController: UINavigationController,
                                   willShow viewController: UIViewController, animated: Bool) {
    guard let appearanceContext = viewController as? NavigationControllerAppearanceContext else { return }
    
    self.children.last?.title = appearanceContext.title(for: self)
    
    if let prefersLargeTitle = appearanceContext.prefersLargeTitle(for: self) {
      self.navigationBar.prefersLargeTitles = prefersLargeTitle
    }
    
    self.children.last?.navigationItem.largeTitleDisplayMode = appearanceContext.largeTitleDisplayMode(for: self)
    
    if appearanceContext.isShadowHidden(for: self) {
      hideShadow()
    }

    self.setNavigationBarHidden(appearanceContext.prefersNavigationbarHidden(for: self), animated: animated)
    self.setToolbarHidden(appearanceContext.prefersToolbarHidden(for: self), animated: animated)
    applyAppearance(appearance: appearanceContext.preferredAppearance(for: self), animated: animated)
    
    // interactive gesture requires more complex logic.
    guard let coordinator = viewController.transitionCoordinator, coordinator.isInteractive else { return }
    
    coordinator.animate(alongsideTransition: { _ in }) { context in
      if context.isCancelled,
         let appearanceContext = self.topViewController as? NavigationControllerAppearanceContext {
        // hiding navigation bar & toolbar within interaction completion will result into inconsistent UI state
        self.setNavigationBarHidden(appearanceContext.prefersNavigationbarHidden(for: self), animated: animated)
        self.setToolbarHidden(appearanceContext.prefersToolbarHidden(for: self), animated: animated)
      }
    }
    
    coordinator.notifyWhenInteractionChanges { context in
      if context.isCancelled,
         let from = context.viewController(forKey: .from) as? NavigationControllerAppearanceContext {
        // changing navigation bar & toolbar appearance within animate completion will result into UI glitch
        self.applyAppearance(appearance: from.preferredAppearance(for: self), animated: animated)
      }
    }
  }
  
  private func hideShadow() {
    if #available(iOS 13.0, *) {
      self.navigationBar.standardAppearance.shadowColor = .clear
      self.navigationBar.compactAppearance?.shadowColor = .clear
      self.navigationBar.scrollEdgeAppearance?.shadowColor = .clear
    } else {
      self.navigationBar.shadowImage = UIImage()
    }
  }

  // MARK: - Appearance Applying
  
  private var appliedAppearance: Appearance?
  
  public var appearanceApplyingStrategy = AppearanceApplyingStrategy() {
    didSet {
      applyAppearance(appearance: appliedAppearance, animated: false)
    }
  }

  private func applyAppearance(appearance: Appearance?, animated: Bool) {
    if appearance != nil && appliedAppearance != appearance {
      appliedAppearance = appearance
      
      appearanceApplyingStrategy.apply(appearance: appearance, toNavigationController: self, animated: animated)
      self.setNeedsStatusBarAppearanceUpdate()
    }
  }
    
  // MAKR: - Apperanace Update
  
  func updateAppearance(for viewController: UIViewController) {
    if let context = viewController as? NavigationControllerAppearanceContext,
       viewController == topViewController && transitionCoordinator == nil {
      self.children.last?.title = context.title(for: self)
      if let prefersLargeTitle = context.prefersLargeTitle(for: self) {
        self.navigationBar.prefersLargeTitles = prefersLargeTitle
      }
      self.children.last?.navigationItem.largeTitleDisplayMode = context.largeTitleDisplayMode(for: self)
      self.setNavigationBarHidden(context.prefersNavigationbarHidden(for: self), animated: true)
      self.setToolbarHidden(context.prefersToolbarHidden(for: self), animated: true)
      applyAppearance(appearance: context.preferredAppearance(for: self), animated: true)
    }
  }
  
  public func updateAppearance() {
    if let top = topViewController {
      updateAppearance(for: top)
    }
  }
  
  public override var preferredStatusBarStyle: UIStatusBarStyle {
    appliedAppearance?.statusBarStyle ?? super.preferredStatusBarStyle
  }
  
  public override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
    appliedAppearance != nil ? .fade : super.preferredStatusBarUpdateAnimation
  }
}
