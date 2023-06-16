//
//  ViewController.swift
//  ListMenuExample
//
//  Created by Dmytro Romanov on 16.06.2023.
//

import UIKit
import ListMenu

class ViewController: UIViewController {

    @IBOutlet private weak var menuButton: UIButton!

    private var menu: ListMenu?
    private var menuItems: [ListMenuItem] {
        [ListMenuItem(title: "Kyiv", image: UIImage(systemName: "hryvniasign.circle.fill"), value: 1002),
         ListMenuItem(title: "Kharkiv", image: UIImage(systemName: "atom"), value: 1003),
         ListMenuItem(title: "Odesa", image: UIImage(systemName: "ferry.fill"), value: 1004),
         ListMenuItem(title: "Dnipro", image: UIImage(systemName: "sailboat.fill"), value: 1005),
         ListMenuItem(title: "Donetsk", image: UIImage(systemName: "soccerball"), value: 1006),
         ListMenuItem(title: "Zaporizhzhia", image: UIImage(systemName: "sparkles"), value: 1007),
         ListMenuItem(title: "Lviv", image: UIImage(systemName: "theatermasks.fill"), value: 1008)]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        menu = ListMenu(presentButton: menuButton,
                        title: "Cities",
                        items: menuItems,
                        eventsHandler: self)
    }
}

extension ViewController: ListMenuEvents {

    func didSelect(item: ListMenuItem) {
        print("Did select item - \(String(describing: item.value))")
    }
}
