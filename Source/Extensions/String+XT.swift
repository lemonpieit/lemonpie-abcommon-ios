//
//  String+XT.swift
//  CustomerArea
//
//  Created by Luigi Aiello on 20/02/2020.
//  Copyright © 2020 ABenergie S.p.A. All rights reserved.
//

import Foundation.NSString

/* date_format_you_want_in_string from
 * http://userguide.icu-project.org/formatparse/datetime
 */

public extension String {
    /// Capitalizes the first letter.
    func capitalizeFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    /// Capitalizes the first letter.
    mutating func capitalizeFirstLetter() {
        self = self.capitalizeFirstLetter()
    }
    
    /// Returns a localize string.
    /// - Parameters:
    ///   - tableName: The table name.
    ///   - bundle: The bundle.
    ///   - comment: The comment.
    func localized(withTableNamed tableName: String, bundle: Bundle = Bundle.main, comment: String = "") -> String {
        let translated = NSLocalizedString(self, tableName: tableName, comment: comment)
        return translated
    }
    
    /// Returns an instance of UIImage for the image named `self` and contained in the main bundle.
    var image: UIImage? {
        return UIImage(named: self)
    }
    
    /// Checks if the string is a valide phone number.
    var isValidPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    /// Checks if the string is a valide email.
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    /// Checks if the string is numeric.
    var isNumeric: Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }
    
    /// Calculates the width of the string.
    func widthForString(using font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width + 40
    }
    
    /// Indicates whether the string fits the given frame.
    func fits(frameOfSize size: CGSize, withFont font: UIFont) -> Bool {
        let boundsLimits = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let bounds = (self as NSString).boundingRect(with: boundsLimits, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return (bounds.size.width < size.width && bounds.size.height < size.height)
    }
    
    /// Indicates whether the string contains the given text.
    func contains(_ text: String, withOptions options: NSString.CompareOptions = .caseInsensitive) -> Bool {
        return (self as NSString).range(of: text, options: options).location != NSNotFound
    }
    
    /// Removes double spaces.
    func removingDoubleSpaces() -> String {
        var search = self
        while search.contains("  ") {
            search = (search as NSString).replacingOccurrences(of: "  ", with: " ")
        }
        return search
    }
    
    /// Checks whether the string contains the first and last name.
    /// - Parameters:
    ///   - firstName: The first name.
    ///   - lastName: The last name.
    func identifiesUserWith(firstName: String, lastName: String) -> Bool {
        let search = removingDoubleSpaces().trimmingCharacters(in: .whitespacesAndNewlines)
        let first = firstName.trimmingCharacters(in: .whitespacesAndNewlines)
        let last = lastName.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return "\(first) \(last)".contains(search) || "\(lastName) \(firstName)".contains(search)
    }
    
    /// Returns the height of the string.
    /// - Parameters:
    ///   - width: The constraint rectangle width.
    ///   - font: The text font to use.
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    /// Returns the width of the string.
    /// - Parameters:
    ///   - height: The constraint rectangle height.
    ///   - font: The text font to use.
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    /// Converts the string to bool.
    func toBool() -> Bool? {
        let newString = self.lowercased().trimmingCharacters(in: .whitespaces)
        
        switch newString {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    /// Converts a string to a date with a format.
    /// - Parameter formatted: The format of the date.
    func toDate(formatted: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatted
        
        let date = dateFormatter.date(from: self)
        
        return date
    }
    
    /// Converts the string to a `ISO8601` formatted `Date` object.
    /// - Returns: 2020-04-10 14:52:04 +0000
    func toISO8601Date() -> Date? {
           let dateFormatter = ISO8601DateFormatter()
           dateFormatter.formatOptions = [.withFullDate,
                                          .withTime,
                                          .withDashSeparatorInDate,
                                          .withColonSeparatorInTime]
           
           let date = dateFormatter.date(from: self)
           
           return date
    }
    
    /// Converts a string encoded in `Base64` to a normal string.
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    /// Converts a string to a `Base64` encoded string.
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
