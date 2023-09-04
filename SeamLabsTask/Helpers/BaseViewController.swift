//
//  BaseViewController.swift
//  SeamLabsTask
//
//  Created by Hamada Ragab on 04/09/2023.
//

import Foundation
import UIKit
class BaseViewController: UIViewController  {
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func showHud(showLoding: Bool){
        if showLoding {
            self.view.isUserInteractionEnabled = false
            Spinner().showAddedto(self.view)
        }else {
            self.view.isUserInteractionEnabled = true
            Spinner().hideFrom(self.view)
        }
    }
    func showAlert(message:String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
           print("Ok Tapped")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
