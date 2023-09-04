//
//  String.swift
//  SeamLabsTask
//
//  Created by Hamada Ragab on 04/09/2023.
//

import Foundation
extension String {
    func converStringDateFromFormatToAnotherFormat(fromFormat: String,toFormat: String, locale: String = "en") -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        guard let date = dateFormatter.date(from: self)  else {
                fatalError("Invalid date format")
            }
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = toFormat
        outputDateFormatter.locale = Locale(identifier: locale)
        return outputDateFormatter.string(from: date)
    }

}
