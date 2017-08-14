//
//  Route.swift
//  Pods
//
//  Created by Brian Bal on 8/13/17.
//
//

import UIKit

public enum PresentationMode {
    case push
    case tab
    case root
    case modal
}

open class Route {
    public let path : String
    public let from : UIViewController?
    public let presentationMode: PresentationMode
    
    public init(_ path: String, from: UIViewController? = nil, mode: PresentationMode = .push) {
        self.path = path
        self.from = from
        self.presentationMode = mode
    }
}
