# LightSwiftPager

A   Light framework for creating Slideing viewcontrollers for ios 
<br />
![Alt Text](https://media.giphy.com/media/aM98ApTjIK5iprKXII/giphy.gif)
### Installing

via CocoaPods

```
platform :ios, '9.0'
pod 'LightSwiftPager'
use_frameworks!
```


## Usage

Subclass LightPagerViewContoller  and implement data source methods in the subclass.
<br />
See example project for more details .

```
class ViewController: LightPagerViewContoller {
    override func viewDidLoad() {
        super.viewDidLoad()
        taps.append(TapItem(title: "title"))
        taps.append(TapItem( image: UIImage(named: "one")))
        taps.append(TapItem( title: "title1",image: UIImage(named: "one")))
    }
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
## Customization
```
setTapBackgroundColor(_ color:UIColor)
setIndicatorBackGroundColor(_ color:UIColor)
```
## Authors

* **Ahmed Nasser** - [AvaVaas](https://github.com/AvaVaas)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details



