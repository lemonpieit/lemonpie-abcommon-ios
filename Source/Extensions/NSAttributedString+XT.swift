//
//  NSAttributedString+XT.swift
//  ABcommon
//
//  Created by Francesco Leoni on 18/03/2020.
//

import Foundation

public extension NSAttributedString {
    /// Create an attribute string combining an array of strings and attributes.
    /// Both arrays must have the same number of elements.
    /// - Parameters:
    ///   - strings: The attributed text strings.
    ///   - attributes: The attributed text attributes.
    @available(*, deprecated, message: "Use static method 'configureAttributedText(with:)' instead.")
    func configureAttributedText(withStrings strings: [String], attributes: [[NSAttributedString.Key: Any]]) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: strings[0], attributes: attributes[0])
        
        for index in 1 ..< strings.count {
            attributedText.append(NSAttributedString(string: strings[index], attributes: attributes[index]))
        }
        
        return attributedText
    }
    
    /// Create an attribute string combining an array of strings and attributes.
    /// Both arrays must have the same number of elements.
    /// - Parameters:
    ///   - models: An array of tuples containing strings and attributes to configure.
    static func configureAttributedText(with models: [(String, [NSAttributedString.Key: Any])]) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: models[0].0, attributes: models[0].1)
        
        for (string, attributes) in models.dropFirst() {
            attributedText.append(NSAttributedString(string: string, attributes: attributes))
        }
        
        return attributedText
    }
}
