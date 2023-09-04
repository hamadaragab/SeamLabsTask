//
//  Date.swift
//  SeamLabsTask
//
//  Created by Hamada Ragab on 04/09/2023.
//

import Foundation
extension Date
{
    func toString( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en")
        return dateFormatter.string(from: self)
    }

}
