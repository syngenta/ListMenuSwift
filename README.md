# ListMenuSwift
Adds back compatibility to UIMenu by replacing it with UIAlertController for iOS SDK versions prior to 14.0

*(iOS SDK >=14.0 and <14.0 has different representation for the menu)*

<p float="left">
 	<img src='/ListMenuExample/ListMenu_iOS_after_14.jpg' width='300'>
	<img src='/ListMenuExample/ListMenu_iOS_before_14.jpg' width='300'>
</p>

## Example

To play with usage example navigate to ListMenuExample folder and look at ListMenuExample.xcodeproj 

### Swift Package Manager

- File > Swift Packages > Add Package Dependency
- Add `https://github.com/syngenta/ListMenuSwift.git`

## Usage 


In a place where you are going to implement the functionality you need to import the library:
```swift
import ListMenu
```


Add a menu variable and set up a list of menu items
```swift
private var menu: ListMenu?

private var menuItems: [ListMenuItem] {
        [ListMenuItem(title: "Kyiv"),
         ListMenuItem(title: "Kharkiv", image: UIImage(systemName: "atom")),
         ListMenuItem(title: "Odesa", image: UIImage(systemName: "ferry.fill"), value: 1004)]
    }

```


Set up the menu 
```swift
override func viewDidLoad() {
        super.viewDidLoad()

        menu = ListMenu(presentButton: menuButton,
                        title: "Cities",
                        items: menuItems,
                        eventsHandler: self)
    }

```

And handle selected items
```swift
extension YourController: ListMenuEvents {

    func didSelect(item: ListMenuItem) {
        print("Did select item - \(String(describing: item.value))")
    }
}

```

## Author

Dmytro Romanov, dimkahr@gmail.com

## License

MapLauncher is available under the MIT license. See the LICENSE file for more info.

