# LightSwiftPager

A simple  Light framework for creating Slideing viewcontrollers for ios 

### Installing

via CocoaPods

```
platform :ios, '8.0'
pod 'LightSwiftPager'
use_frameworks!
```


## Usage

Subclass LightPagerViewContoller  and implement data source methods in the subclass.

```
class ViewController: LightPagerViewContoller {
    override func viewWillAppear(_ animated: Bool) {
        reloadTaps()
    }
}
```

## Data Source
```
func tapItems() ->[TapItem]
func viewContollers() ->[UIViewController]
@objc optional func titelColors() -> [UIColor]
```
## Delegate
```
@objc optional func didSelectTab(tab :LightPagerViewContoller , index:Int)
```

## Authors

* **Ahmed Nasser** - *Initial work* - [PurpleBooth](https://github.com/AvaVaas)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details



