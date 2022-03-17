//
//  Cordinator.swift
//  AuthenticateYourself
//
//  Created by Ahmed Sadiq on 17/03/2022.
//

import Foundation

protocol ViewModel {}

protocol ViewModelHandler: AnyObject {
    init(viewModel: ViewModel)
}
