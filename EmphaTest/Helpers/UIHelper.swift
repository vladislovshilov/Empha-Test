//
//  UIHelper.swift
//  EmphaTest
//
//  Created by macbook pro max on 31/05/2023.
//

import UIKit

final class UIHelper {
    static func createErrorAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Ooops", message: "Something went wrong. Try again", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        
        return alert
    }
}
