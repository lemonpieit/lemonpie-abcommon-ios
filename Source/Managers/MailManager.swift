//
//  MailManager.swift
//  Musician Finder
//
//  Created by Francesco Leoni on 09/05/2020.
//  Copyright © 2020 Francesco Leoni. All rights reserved.
//

import MessageUI

protocol MailManagerDelegate: class {
  func errorOccurred(_ error: Error)
}

class MailManager: NSObject, MFMailComposeViewControllerDelegate {
  // MARK: - Properties

  /// The view controller in which to present the mail view controller.
  private var viewController: UIViewController?

  // MARK: - Delegate

  weak var delegate: MailManagerDelegate?

  // MARK: - Init

  init(viewController: UIViewController) {
    self.viewController = viewController
  }

  // MARK: - Actions

  /// Presents a new `MailViewController` with prefilled fields.
  /// - Parameters:
  ///   - emails: The email address of the recipients.
  ///   - subject: The subject of the email.
  ///   - body: The body of the email.
  func sendEmail(to emails: [String], with subject: String = "", and body: String = "") {
    guard MFMailComposeViewController.canSendMail() else { return }

    let composer = MFMailComposeViewController()
    composer.mailComposeDelegate = self
    composer.setToRecipients(emails)
    composer.setSubject(subject)
    composer.setMessageBody(body, isHTML: false)

    viewController?.present(composer, animated: true)
  }

  // MARK: - MFMailComposeViewControllerDelegate

  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    if let error = error {
      controller.dismiss(animated: true)
      delegate?.errorOccurred(error)
      return
    }

    switch result {
    case .cancelled:
      print("Email cancelled")
    case .failed:
      print("Email failed")
    case .saved:
      print("Email saved")
    case .sent:
      print("Email sent")
    @unknown default:
      print("Email fatal error")
    }

    controller.dismiss(animated: true)
  }
}