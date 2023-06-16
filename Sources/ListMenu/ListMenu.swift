import UIKit

public protocol ListMenuEvents: AnyObject {
    func didSelect(item: ListMenuItem)
}

public struct ListMenuItem {
    public let title: String
    public let image: UIImage?
    public let value: Any?

    public init(title: String, image: UIImage? = nil, value: Any? = nil) {
        self.title = title
        self.image = image
        self.value = value
    }
}

public class ListMenu {

    private var presentButton: UIButton?
    private var presentBarButton: UIBarButtonItem?
    private var barButtonViewController: UIViewController?
    private let title: String
    private let items: [ListMenuItem]
    private weak var eventsHandler: ListMenuEvents?

    private var alertController: UIAlertController?
    private var cancelString: String { NSLocalizedString("cancel", comment: "Cancel").capitalized }

    public init(presentButton: UIButton,
         title: String? = nil,
         items: [ListMenuItem],
         eventsHandler: ListMenuEvents) {

        self.presentButton = presentButton
        self.title = title ?? ""
        self.items = items
        self.eventsHandler = eventsHandler

        if #available(iOS 14.0, *) {
            setupUIMenu()
        } else {
            setupUIAlertController()
        }
    }

    public init(presentBarButton: UIBarButtonItem,
         rootViewController: UIViewController,
         title: String? = nil,
         items: [ListMenuItem],
         eventsHandler: ListMenuEvents) {

        self.presentBarButton = presentBarButton
        self.barButtonViewController = rootViewController
        self.title = title ?? ""
        self.items = items
        self.eventsHandler = eventsHandler

        if #available(iOS 14.0, *) {
            setupUIMenu()
        } else {
            setupUIAlertController()
        }
    }

    @available(iOS 14.0, *)
    private func setupUIMenu() {
        let menuItems = items.map { item in UIAction(title: item.title,
                                                     image: item.image,
                                                     handler: { _ in self.selected(item: item) }) }

        let menu = UIMenu(title: title, children: menuItems)

        if presentButton != nil {
            presentButton?.showsMenuAsPrimaryAction = true
            presentButton?.menu = menu
        } else if presentBarButton != nil {
            presentBarButton?.menu = menu
        } else {
            print("WARNING: ListMenu doesn't have a present Button, the menu wasn't set up properly.")
        }
    }

    private func setupUIAlertController() {
        alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertController?.view.tintColor = UIColor.black

        items.forEach { item in
            let alertAction = UIAlertAction(title: item.title, style: .default, handler: { _ in self.selected(item: item) })
            alertAction.setValue(item.image, forKey: "image")
            alertController?.addAction(alertAction)
        }

        alertController?.addAction(UIAlertAction(title: cancelString, style: .cancel))

        if presentButton != nil {
            presentButton?.addTarget(self, action: #selector(action), for: .touchUpInside)
        } else if presentBarButton != nil {
            presentBarButton?.target = self
            presentBarButton?.action = #selector(action)
        } else {
            print("WARNING: ListMenu doesn't have a present Button, the menu wasn't set up properly.")
        }
    }

    @objc private func action() {
        guard let superViewController = presentButton?.getOwningViewController() ?? barButtonViewController else { return }
        guard let alertController = alertController else { return }
        superViewController.present(alertController, animated: true)
    }

    private func selected(item: ListMenuItem) {
        eventsHandler?.didSelect(item: item)
    }
}

private extension UIResponder {

    func getOwningViewController() -> UIViewController? {
        var nextResponser = self
        while let next = nextResponser.next {
            nextResponser = next
            if let viewController = nextResponser as? UIViewController { return viewController }
        }
        return nil
    }
}
