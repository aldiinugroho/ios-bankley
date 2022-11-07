//
//  AccountSummaryHeaderView.swift
//  bankley
//
//  Created by aldinugroho on 07/11/22.
//

import UIKit

class AccountSummaryHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AccountSummaryHeaderView {
    func style() {
        self.backgroundColor = appColor
    }
    
    func layout() {
        
    }
}
