//
//  ImagesOfTheDayController.swift
//  MyFancyWeatherApp
//
//  Created by Sanad Barjawi on 28/11/2020.
//

import UIKit

class ImagesOfTheDayController: UITableViewController {
    // Create an instance
    var dispatchGroup = DispatchGroup()

    var downloadedImages: [UIImage] = []

    var imagesOfTheDayDataSource: [String] = [
        "https://upload.wikimedia.org/wikipedia/commons/7/74/Earth_poster_large.jpg",
        "http://kenrockwell.com/nikon/d600/sample-images/600_0985.JPG",
        "http://www.austal.com/sites/default/files/media-images/DSC06071.JPG",
        "http://www.marinelink.com/images/maritime/265a5884ef314b6aa70b00d28e986cabweb-33268.jpg"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addPulltoRefreshControl(controller: self, shouldIncludeSafeArea: false, doing: #selector(loadImages), with: NSAttributedString(string: "loading ..."), tintColor: .black)
        tableView.tableFooterView = UIView()
        loadImages()
        // We have to listen group, and that we update tableView or UI todo
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
            self.tableView.layoutIfNeeded()
            self.tableView.layoutSubviews()
            self.tableView.endRefreshing()
        }
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
    func loadImages() {
        tableView.beginRefreshing()
        // Every round of loop, we enter the group
        for img in imagesOfTheDayDataSource {

            // Join the group
            dispatchGroup.enter()
            let imgDownload = UIImageView()
            imgDownload.getImageNatively(using: img) {[weak self] downloadedImage in
                if let foundImage = downloadedImage {
                    self?.downloadedImages.append(foundImage)
                }

                // And leave group when task is done
                self?.dispatchGroup.leave()

            }
        }

    }


}
