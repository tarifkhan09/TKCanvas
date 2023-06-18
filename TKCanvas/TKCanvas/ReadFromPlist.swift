//
//  ReadFromPlist.swift
//  TKCanvas
//
//  Created by MD Tarif khan on 18/6/23.
//


import Foundation
import UIKit


func readFromPlistString(plistName:String)  -> [String]{
    let url = Bundle.main.url(forResource: plistName, withExtension: "plist")!
    let data = try! Data(contentsOf: url)
    let myPlist = try! PropertyListSerialization.propertyList(from: data,
                                                              options: .mutableContainers,
                                                              format: nil) as? [String]
    guard let myPlist = myPlist else{return [String]()}
    return myPlist

}
