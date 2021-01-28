//
//  MainView.swift
//  Instagrid
//
//  Created by chaleroux on 07/01/2021.
//

import UIKit

class MainView: UIView {
    
    @IBOutlet private var dispositionOneButton: UIButton!
    @IBOutlet private var dispositionTwoButton: UIButton!
    @IBOutlet private var dispositionThreeButton: UIButton!
    

    dispositionOneButton = UIButton()
    dispositionOneButton.setImage(#imageLiteral(resourceName: "Layout 1"), for: .normal)
    dispositionOneButton.setImage(#imageLiteral(resourceName: "Selected-2"), for: .selected)
        
    }
}
