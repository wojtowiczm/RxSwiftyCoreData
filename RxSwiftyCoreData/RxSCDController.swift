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

// TODO: Add documentation for each api method
extension SCDController.Reactive {
    // MARK: - Read
    
    /// Fetches objects stored in DataBase
    ///
    /// - Parameters:
    ///   - withPredicate: `NSPredicate` - A definition of logical conditions used to constrain a search either for a fetch or for in-memory filtering.
    ///    - sortDescriptors: An immutable description of how to order a collection of objects based on a property common to all the objects.
    ///  returns
    public func fetchAll(
        withPredicate predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor]? = nil,
        fetchLimit: Int? = nil) -> Observable<[Object]> {
        return Observable.create { observer in
            self.base.fetchAll(
            withPredicate: predicate,
            sortDescriptors: sortDescriptors,
            fetchLimit: fetchLimit,
            failure: observer.onError,
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
                failure: observer.onError,
                completion: observer.onNext)
            return Disposables.create()
        }
        
    }
    
    public func save(objects: [Object]) -> Completable {
        return Completable.create { observer in
            self.base.save(
            objects: objects,
            failure: { error in
                observer(.error(error))
            },
            completion: {
                observer(.completed)
            })
            return Disposables.create()
        }
    }
    
    public func save(_ object: Object) -> Completable {
        return Completable.create { observer in
            self.base.save(
                object,
                failure: { error in
                    observer(.error(error))
            },
                completion: {
                    observer(.completed)
            })
            return Disposables.create()
        }
    }
    
    public func deleteAll(withPredicate predicate: NSPredicate? = nil) -> Completable {
        return Completable.create { observer in
            self.base.deleteAll(
                withPredicate: predicate,
                failure: { error in
                    observer(.error(error))
            },
                completion: {
                    observer(.completed)
            })
            return Disposables.create()
        }
    }
    
    public func delete(_ object: Object) -> Completable {
        return Completable.create { observer in
            self.base.delete(
                object,
                failure: { error in
                    observer(.error(error))
            },
                completion: {
                    observer(.completed)
            })
            return Disposables.create()
        }
    }
    
    public func update(_ object: Object) -> Completable {
        return Completable.zip([delete(object), save(object)])
    }

}
