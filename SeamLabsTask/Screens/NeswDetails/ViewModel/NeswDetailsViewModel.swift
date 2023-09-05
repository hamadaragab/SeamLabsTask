//
//  NeswDetailsViewModel.swift
//  SeamLabsTask
//
//  Created by Hamada Ragab on 04/09/2023.
//

import Foundation
import RxCocoa
import RxSwift
class NeswDetailsViewModel {
    private let disposeBag = DisposeBag()
    let selectedArticle = BehaviorRelay<Articles?>(value: nil)
    let rateValue = BehaviorRelay<Double?>(value: nil)
    let rateText = BehaviorRelay<String?>(value: nil)
    let validationMessage  = PublishRelay<String>()
    let didRateArticle = PublishRelay<Void>()
    init(selectedArticle: Articles?) {
        self.selectedArticle.accept(selectedArticle)
    }
    func rateArticle() {
        guard let rateText = rateText.value, !rateText.isEmpty else {
            validationMessage.accept("rate text does not found")
            return
        }
        guard let rateValue = rateValue.value, rateValue != 0 else {
            validationMessage.accept("rate value does not found")
            return
        }
        didRateArticle.accept(())
    }
}
