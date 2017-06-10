//
//  Feapper.swift
//  Feapper
//
//  Created by mathieu lecoupeur on 06/06/2017.
//  Copyright © 2017 mathieu lecoupeur. All rights reserved.
//

import Foundation

public protocol FeapperDelegate: class {
    func featureEnabled(featureId:String)
    func featureDisabled(featureId:String)
}

public class Feapper {
    
    public static var shared = Feapper()
    
    private var features: [String: (enabled: Bool, delegates: NSHashTable<AnyObject>)]
    
    private init() {
        
        features = [String: (Bool, NSHashTable<AnyObject>)]()
    }
    
    /**
     *
     * Loads a configuration file in json format
     * to setup features statuses
     *
     */
    func setup(url: URL) {
        
        // TODO - get json from url and call setup(json: NSDictionary)
    }
    
    public func setup(json: NSDictionary) {
        
        guard let jsonFeatures = json["features"] as? [NSDictionary] else {
            return
        }
        
        for feature in jsonFeatures {
            
            guard let featureId = feature["id"] as? String else {
                continue
            }
            
            guard let featureStatus = feature["enabled"] as? Bool else {
                continue
            }
            
            features[featureId] = (featureStatus, NSHashTable<AnyObject>(options: NSPointerFunctions.Options.weakMemory))
        }
    }
    
    public func resetSetup() {
        
        features = [String: (Bool, NSHashTable<AnyObject>)]()
    }
    
    /**
     *
     * Adds a new feature if it doesn't exists
     *
     */
    public func addFeature(featureId: String) {
        
        features[featureId] = features[featureId] ?? (true, NSHashTable<AnyObject>(options: NSPointerFunctions.Options.weakMemory))
    }
    
    /**
     *
     * Returns true if the feature is know or false either
     *
     */
    public func hasFeature(featureId: String) -> Bool {
        
        return features[featureId] != nil
    }
    
    /**
     *
     * Removes a feature
     *
     */
    public func removeFeature(featureId: String) {
        
        features.removeValue(forKey: featureId)
    }
    
    public func isFeatureEnabled(featureId: String) -> Bool {
        
        return features[featureId]?.enabled == true
    }
    
    /**
     *
     * Call register in your viewDidLoad and implement the FeatureFlipperDelegate protocol
     * to get notified of the status of a feature
     * you will be notified immediately after registering,
     * and when the status changes
     *
     * This method will create a new entry for the feature,
     * and register the delegate for this precise feature
     *
     */
    public func register(delegate: FeapperDelegate, featureId: String) {
        
        addFeature(featureId: featureId)
        features[featureId]?.delegates.add(delegate)
        
        if isFeatureEnabled(featureId: featureId) {
            delegate.featureEnabled(featureId: featureId)
        } else {
            delegate.featureDisabled(featureId: featureId)
        }
    }
    
    /**
     *
     * Call this method to activate a feature
     *
     */
    public func flipOn(featureId: String) {
        
        features[featureId]?.enabled = true
        
        guard let delegates = features[featureId]?.delegates.allObjects else {
            return
        }
        
        for delegate in delegates {
            
            guard let delegate = delegate as? FeapperDelegate else {
                continue
            }
            
            delegate.featureEnabled(featureId: featureId)
        }
    }
    
    /**
     * 
     * Call this method to desactivate a feature
     *
     */
    public func flipOff(featureId: String) {
        
        features[featureId]?.enabled = false
        
        guard let delegates = features[featureId]?.delegates.allObjects else {
            return
        }
        
        for delegate in delegates {
            
            guard let delegate = delegate as? FeapperDelegate else {
                continue
            }
            
            delegate.featureDisabled(featureId: featureId)
        }
    }
}
