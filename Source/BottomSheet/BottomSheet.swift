//
//  BottomSheet.swift
//  CustomerArea
//
//  Created by Francesco Leoni on 07/01/21.
//  Copyright © 2021 ABenergie S.p.A. All rights reserved.
//

import UIKit

public class BottomSheet: UIViewController {
    
    private enum State {
        case partial
        case full
        case dismiss
        
        /// The y position (top-left corner) of the bottome sheet.
        var yPosition: CGFloat {
            let screenHeight = UIScreen.main.bounds.height
            
            switch self {
            case .full: return screenHeight - _maxHeight
            case .partial: return screenHeight - _minHeight
            case .dismiss: return screenHeight
            }
        }
    }
    
    private static var _minHeight: CGFloat = 130
    private static var _maxHeight: CGFloat = UIScreen.main.bounds.height - 100
    
    private let handle = UIView()
    
    /// Use this view only to add gestures.
    private var gesturesView = UIView()
    
    /// Use this view to display a custom view controller.
    private var contentViewController = UIViewController()
    
    // MARK: - Public properties
    
    /// The minimum height of the bottom sheet.
    public var minHeight: CGFloat? {
        didSet {
            guard let minHeight = minHeight else { return }
            BottomSheet._minHeight = minHeight
        }
    }
    
    /// The maximum height of the bottom sheet.
    public var maxHeight: CGFloat? {
        didSet {
            guard let maxHeight = maxHeight else { return }
            BottomSheet._maxHeight = maxHeight
        }
    }
    
    /// The corner radius of the bottom sheet.
    public var cornerRadius: CGFloat = 16
    
    /// The duration of the present and dismiss animation.
    public var animationDuration: TimeInterval = 0.25
    
    /// Use this property to display a custom `UIViewController`. This view will cover the entire bottom sheet.
    public var embeddedViewController: UIViewController? {
        didSet {
            guard let embeddedViewController = embeddedViewController else { return }
            
            add(embeddedViewController, in: contentViewController)
            embeddedViewController.view.frame = CGRect(origin: CGPoint(x: 0, y: contentViewController.view.frame.origin.y + 26), size: contentViewController.view.frame.size)
        }
    }
    
    // MARK: - Overrides
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissSheet))
        
        self.view.addSubview(gesturesView)
        gesturesView.frame = self.view.frame
        gesturesView.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan))
        
        contentViewController.view.layer.cornerRadius = cornerRadius
        contentViewController.view.backgroundColor = Color.white
        contentViewController.view.addGestureRecognizer(panGesture)
        
        configureHandle()
    }
    
    /// Present the bottom sheet inside the provided view controller.
    /// - Parameter viewController: The `UIViewController` in which to present the bottom sheet.
    public func present(in viewController: UIViewController) {
        add(self, in: viewController)
        add(contentViewController, childFrame: CGRect(origin: CGPoint(x: 0, y: view.frame.maxY), size: viewController.view.frame.size), in: self)
        
        UIView.animate(withDuration: animationDuration) {
            self.moveView(state: .partial)
            self.gesturesView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
    }
    
    /// Dismisses the bottom sheet that was presented inside the view controller.
    @objc public func dismissSheet() {
        UIView.animate(withDuration: animationDuration) {
            self.moveView(state: .dismiss)
        } completion: { _ in
            self.contentViewController.dismiss(animated: false) {
                self.removeFromParent()
                self.view.removeFromSuperview()
                self.didMove(toParent: nil)
            }
        }
    }
    
    private func configureHandle() {
        contentViewController.view.addSubview(handle)
        handle.layer.cornerRadius = 3
        handle.backgroundColor = Color.gray
        handle.frame = CGRect(x: (contentViewController.view.frame.width / 2) - 25, y: contentViewController.view.frame.origin.y + 15, width: 50, height: 6)
    }
    
    private func add(_ child: UIViewController, childFrame: CGRect? = nil, in parent: UIViewController) {
        parent.addChild(child)
        parent.view.addSubview(child.view)
        child.didMove(toParent: parent)
        child.view.frame = childFrame ?? parent.view.frame
    }
    
    // MARK: - Animations
    
    private func moveView(state: State) {
        contentViewController.view.frame.origin = CGPoint(x: 0, y: state.yPosition)
        
        if state == .dismiss {
            self.gesturesView.backgroundColor = UIColor.black.withAlphaComponent(0)
        }
    }
    
    private func moveView(panGestureRecognizer recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        let minY = contentViewController.view.frame.minY
        let yPosition = minY + translation.y
        
        if (yPosition >= State.full.yPosition) && (yPosition <= State.partial.yPosition) {
            contentViewController.view.frame = CGRect(origin: CGPoint(x: 0, y: yPosition), size: contentViewController.view.frame.size)
            recognizer.setTranslation(.zero, in: contentViewController.view)
        }
    }
    
    @objc private func didPan(_ recognizer: UIPanGestureRecognizer) {
        moveView(panGestureRecognizer: recognizer)
        
        if recognizer.state == .ended {
            let velocityY = recognizer.velocity(in: view).y
            let translation = recognizer.translation(in: view)
            let state: State = velocityY >= 0 ? .partial : .full
            
            if translation.y > 0 {
                self.dismissSheet()
                return
            }
            
            UIView.animate(withDuration: animationDuration, delay: 0, options: [.allowUserInteraction]) {
                self.moveView(state: state)
            }
        }
    }
}
