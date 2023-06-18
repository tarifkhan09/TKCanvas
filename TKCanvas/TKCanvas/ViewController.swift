//
//  ViewController.swift
//  TKCanvas
//
//  Created by MD Tarif khan on 18/6/23.
//

import UIKit
import AVKit
import CoreImage

class ViewController: UIViewController {
    
    @IBOutlet weak var canvasCollectionView: UICollectionView!
    @IBOutlet weak var bgView: UIView!
    
    var containerLayer = CALayer()
    var subContainerLayer = CALayer()
    var imgLayer = CALayer()
    var isFirstBuild = true
    
    var canvasSizeDataSource = [String]()
    let image = UIImage(named: "image")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAllLayer()
    }
    
    
    func setupAllLayer(){
        
        ///read data from plist
        let bgPlistName = "CanvasSizeDataSource"
        canvasSizeDataSource = readFromPlistString(plistName: bgPlistName)

        let bgViewH = bgView.bounds.size.height
        let bgViewW = bgView.bounds.size.width
        
        var bounds = CGRect(x: 0, y: 0, width: bgViewW, height: bgViewH)
        
        containerLayer.frame = bounds
        
        bounds = CGRect(origin: .zero,
                        size: AVMakeRect(aspectRatio: image!.size,
                                         insideRect: self.bgView.bounds).size)
        
        let containerFrame = CGRectMake((bgViewW-bounds.size.width)/2.0,
                                        (bgViewH-bounds.size.height)/2.0,
                                        bounds.size.width,bounds.size.height)
        
        subContainerLayer.frame = containerFrame
        
        guard let image = image else{return}
        
        imgLayer.frame = subContainerLayer.bounds
        imgLayer.contents = image.cgImage
        imgLayer.contentsGravity = .resizeAspect
        
        subContainerLayer.backgroundColor = UIColor.white.cgColor
        subContainerLayer.masksToBounds = true
        
        bgView.layer.addSublayer(containerLayer)
        containerLayer.addSublayer(subContainerLayer)
        subContainerLayer.addSublayer(imgLayer)
    }
    
}


//MARK: - collectionView Delegate And Datasource
extension ViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return canvasSizeDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = canvasCollectionView.dequeueReusableCell(withReuseIdentifier: "CanvasCollectionViewCell",
                                                                  for: indexPath) as? CanvasCollectionViewCell
        else{return UICollectionViewCell()}
        cell.canvasText.layer.borderColor = UIColor.white.cgColor
        cell.canvasText.layer.borderWidth = 1.0
        cell.canvasText.text = "\(canvasSizeDataSource[indexPath.row])"
        cell.isSelected = true
        return cell
    }
    
}


extension ViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: canvasCollectionView.bounds.width / 5.0,
                      height: canvasCollectionView.bounds.height / 1.8)
    }
}

extension ViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        self.canvasCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        self.canvasChange(index: indexPath.row)
    }
}



//MARK: - CHANGED CANVAS SIZE.
extension ViewController{
    func canvasChange(index: Int){
        
        let bgViewH = bgView.bounds.size.height
        let bgViewW = bgView.bounds.size.width
        
        switch(index){
        case 1: ///4:5 ----> 4(Width) <--> 5(Height)
            let height = (bgViewW / 4) * 5
            let yOffset = (bgViewH - height) / 2
            
            subContainerLayer.frame = CGRect(x: 0, y: yOffset,width: bgViewW,height: height)
            imgLayer.frame = subContainerLayer.bounds
            
            
        case 2: //1:1
            let yOffset = (bgViewH - bgViewW) / 2
            subContainerLayer.frame = CGRect(x: 0, y: yOffset,width: bgViewW, height: bgViewW)
            imgLayer.frame = subContainerLayer.bounds
            
            
        case 3: //5:4
            let height = (bgViewW / 5) * 4
            let yOffset = (bgViewH - height) / 2
            
            subContainerLayer.frame = CGRect(x: 0, y: yOffset,width: bgViewW, height: height)
            imgLayer.frame = subContainerLayer.bounds
            
            
        case 4: //3:4
            let height = (bgViewW / 3) * 4
            let yOffset = (bgViewH - height) / 2
            
            subContainerLayer.frame = CGRect(x: 0, y: yOffset,width: bgViewW, height: height)
            imgLayer.frame = subContainerLayer.bounds
            
            
        case 5: //9:16
            let width = (bgViewH / 16) * 9
            let xOffset = (bgViewW - width) / 2
            
            self.subContainerLayer.frame = CGRect(x: xOffset, y: 0,width: width,height: bgViewH)
            self.imgLayer.frame = self.subContainerLayer.bounds
          
            
        case 6: //16:9
            let height = (bgViewW / 16) * 9
            let yOffset = (bgViewH - height) / 2
            
            self.subContainerLayer.frame = CGRect(x: 0, y: yOffset,width: bgViewW, height: height)
            self.imgLayer.frame = self.subContainerLayer.bounds
            
            
        case 7: //4:3
            let height = (bgViewW / 4) * 3
            let yOffset = (bgViewH - height) / 2
            
            subContainerLayer.frame = CGRect(x: 0, y: yOffset,width: bgViewW, height: height)
            imgLayer.frame = subContainerLayer.bounds
            
            
        case 8: //1:2
            let width = (bgViewH / 2)
            let xOffset = (bgViewW - width) / 2
            
            self.subContainerLayer.frame = CGRect(x: xOffset, y: 0,width: width, height: bgViewH)
            self.imgLayer.frame = self.subContainerLayer.bounds
            
            
        case 9: //2:1
            let height = (bgViewW / 2)
            let yOffset = (bgViewH - height) / 2
            
            self.subContainerLayer.frame = CGRect(x: 0, y: yOffset, width: bgViewW, height: height)
            self.imgLayer.frame = self.subContainerLayer.bounds
            
            
        default: //orginal
            var bounds = CGRect(x: 0, y: 0, width: bgViewW,height: bgViewH)
            bounds = CGRect(origin: .zero,
                            size: AVMakeRect(aspectRatio: image!.size,
                                             insideRect: self.bgView.bounds).size)
            
            let containerFrame = CGRectMake((bgViewW - bounds.size.width) / 2.0,
                                            (bgViewH - bounds.size.height) / 2.0,
                                            bounds.size.width,
                                            bounds.size.height)
            
            subContainerLayer.frame = containerFrame
            imgLayer.frame = subContainerLayer.bounds
        }
        
    }
}
