
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
                                   willShow viewController: UIViewController,
                                   animated: Bool) {
    guard let appearanceContext = viewController as? NavigationControllerAppearanceContext else { return }
    
    updateAppearance(with: appearanceContext, animated: animated)
    
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
  
  func updateAppearance(with context: NavigationControllerAppearanceContext,
                        animated: Bool) {
    self.children.last?.title = context.title(for: self)
    
    if let prefersLargeTitle = context.prefersLargeTitle(for: self) {
      self.navigationBar.prefersLargeTitles = prefersLargeTitle
    }
    
    self.children.last?.navigationItem.largeTitleDisplayMode = context.largeTitleDisplayMode(for: self)
    
    if let lastVc = children.last, context.shadowMode.isHidden(for: lastVc) {
      hideShadow()
    } else {
      showShadow()
    }
        
    self.setNavigationBarHidden(context.prefersNavigationbarHidden(for: self), animated: true)
    self.setToolbarHidden(context.prefersToolbarHidden(for: self), animated: true)
    applyAppearance(appearance: context.preferredAppearance(for: self), animated: true)
  }
  
  func updateAppearance(for viewController: UIViewController) {
    if let context = viewController as? NavigationControllerAppearanceContext,
       viewController == topViewController && transitionCoordinator == nil {
      updateAppearance(with: context, animated: true)
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
  
  private func hideShadow() {
    if #available(iOS 13.0, *) {
      editAppearances(for: navigationBar) { appearance in
        appearance?.shadowColor = nil
      }
    } else {
      self.navigationBar.shadowImage = UIImage()
    }
  }
  
  private func showShadow() {
    if #available(iOS 13.0, *) {
      editAppearances(for: navigationBar) { appearance in
        appearance?.shadowColor = .systemGray
      }
    } else {
      self.navigationBar.shadowImage = nil
    }
  }
}

extension UIViewController {
  @available(iOS 13.0, *)
  func editAppearances(for navigationBar: UINavigationBar, _ edits: (UINavigationBarAppearance?) -> Void) {
    [navigationBar.standardAppearance,
     navigationBar.compactAppearance,
     navigationBar.scrollEdgeAppearance].forEach { appearance in
      edits(appearance)
     }
  }
}
