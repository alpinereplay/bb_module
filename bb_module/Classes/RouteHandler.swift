//
//  Route.swift
//  Pods
//
//  Created by Brian Bal on 8/13/17.
//
//

import Foundation

public class RouteHandler {
    
    private var _exact : Bool = true
    private var _path : String = ""
    private var _regex : NSRegularExpression
    private var _onRoute : ((Route) -> Bool)
    public var path : String {
        get {
            return _path
        }
        set {
            _path = newValue
            do {
                _regex = try NSRegularExpression(pattern: newValue, options: .caseInsensitive)
            } catch {
                print("regex error \(error)")
            }
        }
    }
    
    public init(path: String, exact: Bool, onRoute: @escaping ((Route) -> Bool)) {
        _path = path
        _onRoute = onRoute
        _exact = exact
        do {
            _regex = try NSRegularExpression(pattern: _path, options: .caseInsensitive)
        } catch {
            print("regext error \(error)")
            _regex = NSRegularExpression()
        }
    }
    
    public func canHandle(_ route : Route) -> Bool {
        var matched = false
        if _exact {
            matched = route.path == _path
        } else {
            let matches = _regex.matches(in: route.path, options: .init(rawValue: 0), range: NSRange(location: 0, length: route.path.characters.count))
            matched = matches.count > 0
        }
        return matched
    }
    
    public func handle(_ route: Route) -> Bool {
        return _onRoute(route)
    }
    
}
