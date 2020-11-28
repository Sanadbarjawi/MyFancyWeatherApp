//
//  WeatherTodayController.swift
//  MyFancyWeatherApp
//
//  Created by Sanad Barjawi on 28/11/2020.
//

import UIKit

struct TableSection: Hashable {
    var title: String
    var items: [TableItem]
}

struct TableItem: Hashable {
    var id: Int
    var image: UIImage
    var title: String
    var color: UIColor
}

enum Data {
    static var sections: [TableSection] = []
//        [.init(title: "section1",
//               items: [.init(id: 0, image: UIImage(named: "o1")!, title: "item1", color: .systemRed)]),
//         .init(title: "section1",
//               items: [.init(id: 1, image: UIImage(named: "o2")!, title: "item2", color: .systemBlue)]),
//         .init(title: "section1",
//               items: [.init(id: 2, image: UIImage(named: "o3")!, title: "item3", color: .systemPink)]),
//         .init(title: "section1",
//               items: [.init(id: 3, image: UIImage(named: "o4")!, title: "item4", color: .systemTeal)]),
//         .init(title: "section1",
//               items: [.init(id: 4, image: UIImage(named: "o5")!, title: "item5", color: .systemGray)])]
}


class WeatherTodayController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        return tableView
    }()

    private var dataSource: UITableViewDiffableDataSource<TableSection, TableItem>?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        configureDataSource()
        loadData()

    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<TableSection, TableItem>(
            tableView: tableView,
            cellProvider: { (_, _, item) -> UITableViewCell? in
                let cell = UITableViewCell(style: .default, reuseIdentifier: "")
//                cell.configure(item)
                return cell
            }
        )
        tableView.dataSource = dataSource
    }

    private func loadData() {

        var snapShot = NSDiffableDataSourceSnapshot<TableSection, TableItem>()
        snapShot.appendSections(Data.sections)

        for section in Data.sections {
            snapShot.appendItems(section.items, toSection: section)
        }
        dataSource?.apply(snapShot, animatingDifferences: true, completion: nil)
    }


}
