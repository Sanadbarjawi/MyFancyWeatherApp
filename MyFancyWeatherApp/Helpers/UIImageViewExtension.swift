//
//  UIImageViewExtension.swift
//  MyFancyWeatherApp
//
//  Created by Sanad Barjawi on 29/11/2020.
//

import UIKit
import Kingfisher

extension UIImageView {



    /// Sets the *UIImageView* an image
    ///
    /// - important: converting back to string to encode it (urlQueryAllowed characters).
    ///
    ///   and converting the encoded **string url** it back to URL to pass it to **Alamofire**
    ///
    /// - Author: Sanad Barjawi
    ///
    /// - Parameters:
    ///   - url: image path returned from the API
    ///
    ///   - placeholderImage: The image to be set initially until the image request finished. If nil, the image view will not change its image until the image request finishes. Defaults to nil.
    ///

    ///   - completion: completion handler passing an returning the image if found

    func setImage(using url: String,
                  placeholderImage: UIImage? = #imageLiteral(resourceName: "ic_placeholder"),
                  completion: ((UIImage?) -> Void)? = nil) {


        self.kf.setImage(with: URL(string: url),
                         placeholder: placeholderImage, completionHandler:  { (result) in
                            switch result {

                            case .success(let imageVals):
                                completion?(imageVals.image)
                            case .failure(_): break
                            }
                         })
    }
}
