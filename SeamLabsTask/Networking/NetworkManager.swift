//
//  NetworkManager.swift
//  SeamLabsTask
//
//  Created by Hamada Ragab on 04/09/2023.
//

import Foundation
import RxSwift
class NetworkManager {
    let disposeBag = DisposeBag()
    class func makeRequest<T: Decodable>(withURL url: String, responseType: T.Type,method: HttpMethod, parameters: [String:Any?]?) -> Observable<T> {
        if !NetworkConfiguration.isInternetAvailable() {
            return Observable.error(ErrorStatus.NoInternet)
        }
        guard let url = URL(string: url) else {
            return Observable.error(ErrorStatus.InvalidUrl)
        }
        let headers: [String:String] = [:]
        var request = URLRequest(url:  url)
        request.timeoutInterval = 20
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let parameters = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                print(error)
            }
        }
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    observer.onError(ErrorStatus.UnexpectedError)
                    return
                }
                guard let data = data else {
                    observer.onError(ErrorStatus.UnexpectedError)
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: data)
                    observer.onNext(result)
                    observer.onCompleted()
                } catch(let error) {
                    print(error)
                    observer.onError(ErrorStatus.ParsingError)
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
