//
//  CanvasCollectionViewCell.swift
//  TKCanvas
//
//  Created by MD Tarif khan on 18/6/23.
//

import UIKit

class CanvasCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var canvasText: UILabel!
    
    override var isSelected: Bool{
        didSet{

            if isSelected{
                canvasText.layer.borderColor = UIColor.cyan.cgColor
                canvasText.layer.cornerRadius = 10.0
                canvasText.layer.borderWidth = 2.0
            } else {
                canvasText.layer.borderColor = UIColor.white.cgColor
                canvasText.layer.cornerRadius = 0.0
                canvasText.layer.borderWidth = 1.0
            }
        }
    }
}
