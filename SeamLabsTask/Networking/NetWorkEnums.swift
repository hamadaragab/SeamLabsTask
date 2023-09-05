//
//  NetWorkEnums.swift
//  SeamLabsTask
//
//  Created by Hamada Ragab on 04/09/2023.
//

import Foundation
enum ErrorStatus: String, Error {
    case NoInternet = "No Internet Connection"
    case InvalidUrl = "The Requested Url Is Invalid"
    case UnexpectedError = "We are sorry, unexpected error occured our team will solve this problem as soon as possible"
    case ParsingError = "We are sorry, there is a problem our team will solve this problem as soon as possible"
    case NoAritcles = "No articles found please select another Date"
}
enum HttpMethod: String {
    case POST = "Post"
    case GET = "Get"
    case DELETE = "Delete"
    case PUT = "Put"
    
}
