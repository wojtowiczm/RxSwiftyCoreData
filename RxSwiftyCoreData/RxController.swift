//
//  RxController.swift
//  RxSwiftyCoreData
//
//  Created by Michał Wójtowicz on 07/07/2019.
//  Copyright © 2019 Michał Wójtowicz. All rights reserved.
//

import RxSwift
import RxCocoa
import CoreData
import SwiftyCoreData

var CompletionSignal: Void { return () }

// TODO: Add documentation for each api method
extension SCDController.Reactive {
    
    public func fetchAll(
        withPredicate predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor]? = nil,
        fetchLimit: Int? = nil) -> Observable<[Object]> {
        return Observable.create { observer in
            self.base.fetchAll(
            withPredicate: predicate,
            sortDescriptors: sortDescriptors,
            fetchLimit: fetchLimit,
            completion: observer.onNext)
            return Disposables.create()
        }
    }
    
    public func fetchFirst(withPredicate predicate: NSPredicate? = nil) -> Observable<[Object]> {
        return fetchAll(withPredicate: predicate, fetchLimit: 1)
    }

    public func countAll(withPredicate predicate: NSPredicate? = nil) -> Observable<Int> {
        return Observable.create { observer in
            self.base.countAll(
                withPredicate: predicate,
                completion: observer.onNext)
            return Disposables.create()
        }
        
    }
    
    public func save(objects: [Object]) -> Observable<Void> {
        return Observable.create { observer in
            self.base.save(objects: objects) {
                observer.onNext(CompletionSignal)
            }
            return Disposables.create()
        }
    }
    
    public func save(_ object: Object) -> Observable<Void> {
        return Observable.create { observer in
            self.base.save(object) {
                observer.onNext(CompletionSignal)
            }
            return Disposables.create()
        }
    }
    
    public func deleteAll(withPredicate predicate: NSPredicate? = nil) -> Observable<Void> {
        return Observable.create { observer in
            self.base.deleteAll(
            withPredicate: predicate) {
                observer.onNext(CompletionSignal)
            }
            return Disposables.create()
        }
    }
    
    public func delete(_ object: Object) -> Observable<Void> {
        return Observable.create { observer in
            self.base.delete(object) {
                observer.onNext(())
            }
            return Disposables.create()
        }
    }
    
    public func update(_ object: Object) -> Observable<Void> {
        return Observable.merge([delete(object), save(object)])
    }

}
