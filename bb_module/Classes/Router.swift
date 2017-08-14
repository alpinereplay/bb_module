//
//  Router.swift
//  Pods
//
//  Created by Brian Bal on 8/13/17.
//
//

import UIKit

public class Router {
    
    var window : UIWindow
    private var _handlers = [RouteHandler]()
    private var _modules = [Module]()
    
    public init(window: UIWindow) {
        self.window = window
    }
    
    public func register(_ module: Module) {
        _modules.append(module)
        module.wasRegistered(self)
    }
    
    public func add(_ handler: RouteHandler) {
        _handlers.append(handler)
    }
    
    public func post(_ path : String, from: UIViewController? = nil) {
        let route = Route(path, from: from)
        self.post(route)
    }
    
    public func post(_ route : Route) {
        for handle in _handlers {
            if handle.canHandle(route) {
                let stop = handle.handle(route)
                if stop {
                    break
                }
            }
        }
    }
}
