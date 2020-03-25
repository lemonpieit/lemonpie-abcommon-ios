//
//  Contacts.swift
//  BikeApp
//
//  Created by Francesco Colleoni on 10/02/17.
//  Copyright © 2017 Mindtek srl. All rights reserved.
//

import Foundation
import Contacts

public extension CNContact {
    /// Return a list of contacts.
    /// - Parameter completionHandler: Returns `Access granted`, `Contacts` and eventual `Errors`.
    class func fetchAll(completionHandler: ((_ accessGranted: Bool, _ contacts: [CNContact]?, _ error: Error?) -> Void)?) {
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { (success, error) in
            guard success, error == nil else {
                completionHandler?(false, nil, error)
                return
            }
            let keys = [CNContactIdentifierKey, CNContactFamilyNameKey, CNContactGivenNameKey, CNContactMiddleNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey];
            
            //let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)]
            let fetchRequest = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
            var contacts: [CNContact] = []
            
            do {
                try store.enumerateContacts(with: fetchRequest) { (contact, object) in
                    contacts.append(contact)
                }
            } catch let error {
                completionHandler?(true, nil, error)
            }
            
            completionHandler?(true, contacts, error)
        }
    }
}
