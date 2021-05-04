//
//  SceneCoordinatorMock.swift
//  
//
//  Created by Sebastian Maschinski on 03.05.21.
//

import UIKit
import PromiseKit

public class SceneCoordinatorMock: SceneCoordinator {

    public init() {}

    public var didSetAsRoot: ((SceneFactory) -> Void)?
    public func asRoot(_ factory: SceneFactory) {
        didSetAsRoot?(factory)
    }

    public var didPush: ((SceneFactory) -> Void)?
    public func push(_ factory: SceneFactory, animated: Bool) {
        didPush?(factory)
    }

    public var didPresent: ((SceneFactory) -> Void)?
    public func present(_ factory: SceneFactory, animated: Bool) {
        didPresent?(factory)
    }

    public var didPresentResolvable: ((Any) -> Void)?
    public var result: Any?
    public var error: Error?

    public func present<Scene: ResolvableSceneFactory>(_ factory: Scene, animated: Bool) -> Promise<Scene.Result> {
        didPresentResolvable?(factory)

        if let someError = error {
            return .init(error: someError)
        } else if let someResult = result as? Scene.Result {
            return .value(someResult)
        }
        return .init(error: ScenePresentationError.notPresentable)
    }
}
