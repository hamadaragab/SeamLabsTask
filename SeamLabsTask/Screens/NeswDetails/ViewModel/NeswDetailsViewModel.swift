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
    init(selectedArticle: Articles?) {
        self.selectedArticle.accept(selectedArticle)
    }
}
