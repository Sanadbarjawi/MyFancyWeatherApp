//
//  BaseMVP.swift
//  MyFancyWeatherApp
//
//  Created by Sanad Barjawi on 28/11/2020.
//

import UIKit

protocol BaseView: class {
       func didSucceed()
       func startLoading()
       func stopLoading()
       func didFail(with error: NSError)
}

extension BaseView {
    func didSucceed() { }
    func startLoading() { }
    func stopLoading() { }
    func didFail(with error: NSError) { }
}

protocol BasePresenter {

    associatedtype View
    var view: View? { get set }
    var isAttached: Bool { get }

    func attachView(_ view: View)
    func detachView()

}

/// Default implementation for the `isAttached()` method just checks if the `view` is non nil.
extension BasePresenter {
    var isAttached: Bool { return view != nil }
}

class BaseMvpController<V, P: BasePresenter>: UIViewController {
    typealias View = V
    private(set) var presenter: P!


    // MARK: - Initializers

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        presenter = createPresenter()
    }

    override public init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        presenter = createPresenter()
    }

    deinit {
        guard let _ = self as? P.View else {return}
        if let presenter = presenter {
            presenter.detachView()
        }
    }

    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        guard let view = self as? P.View else {
            preconditionFailure("MVP ViewController must implement the view protocol `\(View.self)`!")
        }
        super.viewWillAppear(animated)

        if !presenter.isAttached {
            presenter.attachView(view)
        }
    }

    // MARK: - MVP

    /// Override and return a presenter in a subclass.
    func createPresenter() -> P {
        preconditionFailure("MVP method `createPresenter()` must be override in a subclass and do not call `super.createPresenter()`!")
    }

}
