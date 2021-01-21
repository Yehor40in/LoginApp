//
//  Config.swift
//  LoginApp
//
//  Created by Yehor Sorokin on 20.01.2021.
//

import UIKit
import Foundation


public enum Config {
    
    static var fieldColor: UIColor {
        UIColor(red: 0, green: 100/255, blue: 100/255, alpha: 0.05)
    }
    
    static var fieldLabelFont: UIFont {
        UIFont.boldSystemFont(ofSize: 15)
    }
    
    static var prefferedCornerRadius: CGFloat {
        10
    }
    
    static var primaryLayoutMargins: UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    static var titleFont: UIFont {
        UIFont.boldSystemFont(ofSize: 25)
    }
    
    static var buttonFont: UIFont {
        UIFont.boldSystemFont(ofSize: 18)
    }
    
    static var titleHeight: CGFloat {
        UIScreen.main.bounds.height * 0.2
    }
    
    static var primaryStackHeight: CGFloat {
        UIScreen.main.bounds.height * 0.6
    }
    
    static var animationDuration: TimeInterval {
        0.3
    }
    
    static var loginURL: URL {
        URL(string: "https://api-qa.mvpnow.io/v1/sessions")!
    }
    
    static var project_id: String {
        "58b3193b-9f15-4715-a1e3-2e88e375f62b"
    }
    
    static var tokenKey: String {
        "ACCESS_TOKEN_KEY"
    }
    
}
