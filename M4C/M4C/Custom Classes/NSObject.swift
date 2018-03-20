//
//  NSObject.swift
//  Pleez
//
//  Created by Jaydeep on 31/10/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import Foundation

extension NSObject {
    class var className: String {
        if let className = String(describing: self).components(separatedBy: ".").last {
            return className
        } else {
            fatalError("There's something wrong with your code, please check it before trying again!")
        }
    }
}


extension NSObject {
    var toJSON: String? {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
            return String(data: data, encoding: String.Encoding.utf8)
        } catch {
            return nil
        }
    }
}
