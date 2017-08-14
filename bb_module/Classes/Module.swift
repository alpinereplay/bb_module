//
//  Module.swift
//  Pods
//
//  Created by Brian Bal on 8/13/17.
//
//

import Foundation



open class Module {
    
    public var name : String
    public var router : Router?
    
    public init() {
        self.name = "DefaultModuleName"
    }
    
    func wasRegistered(_ with: Router) {
        router = with
        setup()
    }
    
    open func setup() {
        print("Module.setup not overriden")
    }
    
    public func route(_ path : String, handle: @escaping ((Route) -> Bool)) {
        router?.add(RouteHandler(path: path, exact: true, onRoute: handle))
    }
    
    public func regexRoute(_ path : String, handle: @escaping ((Route) -> Bool)) {
        router?.add(RouteHandler(path: path, exact: false, onRoute: handle))
    }
    
    public func post(_ route: Route) {
        router?.post(route)
    }
    
    public func post(_ path: String, from: UIViewController? = nil) {
        router?.post(path, from: from)
    }
    
    public func present(to: UIViewController, from: UIViewController?, mode: PresentationMode) -> Bool {
        var complete = false
        switch mode {
        case .push:
            complete = performPushPresentation(to: to, from: from)
            if !complete {
                complete = present(to: to, from: from, mode: .modal)
            }
        case .tab:
            complete = performTabPresentation(to: to, from: from)
            if !complete {
                complete = present(to: to, from: from, mode: .modal)
            }
        case .modal:
            complete = performModalPresentation(to: to, from: from)
            if !complete {
                complete = present(to: to, from: from, mode: .root)
            }
        default:
            complete = performRootPresentation(to: to)
        }
        return complete
    }
    
    func performPushPresentation(to: UIViewController, from: UIViewController?) -> Bool {
        var completed = false
        if (from != nil) {
            var navigationController = from as? UINavigationController
            if navigationController == nil {
                navigationController = from?.navigationController
            }
            if navigationController != nil {
                navigationController?.pushViewController(to, animated: true)
                completed = true
            }
        }
        return completed
    }
    
    func performTabPresentation(to: UIViewController, from: UIViewController?) -> Bool {
        var completed = false
        if (from != nil) {
            var tabController = from as? UITabBarController
            if tabController == nil {
                tabController = from?.tabBarController
            }
            if tabController != nil {
                let navVC = UINavigationController(rootViewController: to)
                navVC.tabBarItem = to.tabBarItem
                var viewControllers = tabController!.viewControllers
                if viewControllers == nil {
                    viewControllers = [UIViewController]()
                }
                viewControllers?.append(navVC)
                tabController?.viewControllers = viewControllers
                completed = true
            }
        }
        return completed
    }
    
    func performModalPresentation(to: UIViewController, from: UIViewController?) -> Bool {
        var completed = false
        if (from != nil) {
            from?.present(to, animated: true, completion: nil)
            completed = true
        }
        return completed
    }
    
    func performRootPresentation(to: UIViewController) -> Bool {
        var completed = false
        if router != nil {
            router?.window.rootViewController = to
            completed = true
        }
        return completed
    }
    
}
