//
//  UserAgreementLabel.swift
//  E-Mistri
//
//  Created by gurzu on 10/01/2023.
//

import Foundation

extension NSAttributedString {
    
    static func hyperlinks(for path: String,
                           in string: String,
                           as subString: String,
                           and secSubString: String) -> NSAttributedString {
        let nsString = NSString(string: string)
        let substringRange = nsString.range(of: subString)
        let secSubStringRange = nsString.range(of: secSubString)
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(.link, value: path, range: substringRange)
        attributedString.addAttribute(.link, value: path, range: secSubStringRange)
        return attributedString
    }
}
