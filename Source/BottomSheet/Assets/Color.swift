//
//  Color.swift
//  ABcommon
//
//  Created by Francesco Leoni on 09/04/21.
//

import UIKit

public class Color {
    
    private static var bundle: Bundle {
        Bundle(for: self)
    }

    public static var white = UIColor(named: "white", in: bundle, compatibleWith: nil)!
        
    public static var gray = UIColor(named: "gray", in: bundle, compatibleWith: nil)!

}
