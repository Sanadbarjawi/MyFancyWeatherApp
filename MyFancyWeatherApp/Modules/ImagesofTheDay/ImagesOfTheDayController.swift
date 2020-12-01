//
//  ImagesOfTheDayController.swift
//  MyFancyWeatherApp
//
//  Created by Sanad Barjawi on 28/11/2020.
//

import UIKit

final class ImagesOfTheDayController: UITableViewController {

    let queue = OperationQueue()

    private var downloadedImages: [UIImage] = []

    private var imagesOfTheDayDataSource: [URL] = [
        URL(string: "https://upload.wikimedia.org/wikipedia/commons/7/74/Earth_poster_large.jpg")!,
        URL(string: "http://kenrockwell.com/nikon/d600/sample-images/600_0985.JPG")!,
        URL(string: "http://www.austal.com/sites/default/files/media-images/DSC06071.JPG")!,
        URL(string: "http://www.marinelink.com/images/maritime/265a5884ef314b6aa70b00d28e986cabweb-33268.jpg")!,
    ]

    fileprivate func configureTableView() {
        tableView.addPulltoRefreshControl(controller: self, shouldIncludeSafeArea: false, doing: #selector(loadImages), with: NSAttributedString(string: "loading ..."), tintColor: .black)
        tableView.tableFooterView = UIView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        queue.maxConcurrentOperationCount = 1
        configureTableView()
        loadImages()

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ImageofTheDayCell.self)", for: indexPath) as? ImageofTheDayCell else {return UITableViewCell()}


        cell.imageofTheDayImageView.image = downloadedImages[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return downloadedImages.count
    }

@objc
    private func loadImages() {
        tableView.beginRefreshing()

        for imageURL in imagesOfTheDayDataSource {

            let operation = URLSessionDataTaskOperation(
                session: URLSession.shared,
                downloadTaskURL: imageURL,
                completionHandler: {[weak self] (data, _, _) in

                    DispatchQueue.main.async {// on each successful image response
                        if let data = data, let image = UIImage(data: data) {
                            self?.downloadedImages.append(image)
                            self?.tableView.reloadData()
                        }
                    }

                })

            queue.addOperation(operation)
        }

        queue.addBarrierBlock { [weak self] in // on queue completion
            DispatchQueue.main.async{
                self?.tableView.endRefreshing()
            }
        }
    }
}
