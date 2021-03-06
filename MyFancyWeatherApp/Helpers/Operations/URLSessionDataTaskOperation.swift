//
//  URLSessionDataTaskOperation.swift
//  MyFancyWeatherApp
//
//  Created by Sanad Barjawi on 01/12/2020.
//

import Foundation

class URLSessionDataTaskOperation: Operation {

    private var task : URLSessionDataTask!

    enum OperationState : Int {
        case ready
        case executing
        case finished
    }

    // default state is ready (when the operation is created)
    private var state : OperationState = .ready {
        willSet {
            self.willChangeValue(forKey: "isExecuting")
            self.willChangeValue(forKey: "isFinished")
        }

        didSet {
            self.didChangeValue(forKey: "isExecuting")
            self.didChangeValue(forKey: "isFinished")
        }
    }

    override var isReady: Bool { return state == .ready }
    override var isExecuting: Bool { return state == .executing }
    override var isFinished: Bool { return state == .finished }

    init(session: URLSession, downloadTaskURL: URL, completionHandler: ((Data?, URLResponse?, Error?) -> Void)?) {
        super.init()

        // use weak self to prevent retain cycle
        task = session.dataTask(with: downloadTaskURL, completionHandler: { [weak self] (localURL, response, error) in

            /*
            if there is a custom completionHandler defined,
            pass the result gotten in downloadTask's completionHandler to the
            custom completionHandler
            */
            if let completionHandler = completionHandler {
                // localURL is the temporary URL the downloaded file is located
                completionHandler(localURL, response, error)
            }

           /*
             set the operation state to finished once
             the download task is completed or have error
           */
            self?.state = .finished
        })
    }

    override func start() {
      /*
      if the operation or queue got cancelled even
      before the operation has started, set the
      operation state to finished and return
      */
      if(self.isCancelled) {
          state = .finished
          return
      }

      // set the state to executing
      state = .executing

      // start the downloading
      self.task.resume()
  }

  override func cancel() {
      super.cancel()

      // cancel the downloading
      self.task.cancel()
  }
}
