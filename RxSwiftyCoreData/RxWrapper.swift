//
//  RxWrapper.swift
//  RxSwiftyCoreData
//
//  Created by Michał Wójtowicz on 07/07/2019.
//  Copyright © 2019 Michał Wójtowicz. All rights reserved.
//

import SwiftyCoreData

// Cannot use `ReactiveCompatible` since SCDController is generic
// Se https://github.com/ReactiveCocoa/ReactiveSwift/issues/238

extension SCDController {
    
    struct Reactive<O, MO> where Object: SCDManagedObjectConvertible, ManagedObject: SCDObjectConvertible & NSManagedObject {
        
        let base: SCDController<Object, ManagedObject>
        
        fileprivate init(_ base: SCDController<Object, ManagedObject>) {
            self.base = base
        }
    }
    
    var rx: Reactive<Object, ManagedObject> {
        return Reactive(self)
    }
    
}
