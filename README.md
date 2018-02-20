# LMPagerStrip
PagerStrip (Android-like) for iOS embedded in the navigation bar consisting of UICollectionView and UIPageViewController

## Installation
### Pod
Coming soon... 🕐

I recommend coping the three necessary files (LMPagerStripViewController, LMPagerStripView, LMPagerStripCell) into your project and use it as your own files. Then you are able to make changes on your own. Otherwise you can download the framework located in Source-Folder, build it yourself and add it to your project.

## Demo
PagerStrip can be used with a standard Navigation Bar or iOS 11 styled Navigation Bar with large titles enabled.

<img src="https://github.com/lmoedl/LMPagerStrip/blob/master/Design/normal-nav-bar.png" width="250") ![iOS 11 NavBar](https://github.com/lmoedl/LMPagerStrip/blob/master/Design/ios11-nav-bar.png)

You can add as many ViewControllers as you want but I recommend not more than 5 because of design

![Demo](https://github.com/lmoedl/LMPagerStrip/blob/master/Design/Demo.gif)

## Usage
If you need help, have a look at the [example](https://github.com/lmoedl/LMPagerStrip/tree/master/Example) (use the workspace to start the project)

First you need an UIViewController embedded into an UINavigationController. You can do it the easy way using the Storyboard (select the ViewController ➡️ Editor ➡️ Embed in ➡️ Navigation Controller) or programmatically (maybe as RootViewController inside AppDelegate):

'''
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
window = UIWindow(frame: UIScreen.main.bounds)
let navigationController = UINavigationController()
let vc = ViewController()    //Name of your VC
navigationController.viewControllers = [vc]
window!.rootViewController = navigationController
window!.makeKeyAndVisible()
return true
}
'''

After that you need to instantiate your content ViewControllers which should be switched through later inside viewDidLoad of your ContentViewController:

'''
let storyboard = UIStoryboard(name: "Main", bundle: nil)
let vc1 = storyboard.instantiateViewController(withIdentifier: "page")
'''

Then instantiate the LMPagerStripViewController and add the Content ViewControllers as well as the icons for the Strip:

'''
let pagerStripVC = LMPagerStripViewController(pages: [vc1, vc2, vc3, ...], icons: [img1, img2, im3, ...])
'''

Set the LMPagerStripViewController as ChildViewController of your current ContainerViewController:

'''
self.view.addSubview(pagerStripVC.view)
self.addChildViewController(pagerStripVC)
pagerStripVC.didMove(toParentViewController: self)
'''

Here you go 🚀

## Customizations
You can change the background color of the Strip as well as the tintColor for the selected and unselected state of the icons:

'''
pagerStripVC.pagerStripBackgroundColor = .orange
pagerStripVC.barItemSelectedColor = .white
pagerStripVC.barItemUnselectedColor = .gray
'''

## What's next

✅ Basic PagerStrip
☑️ Scrollable PagerStrip
☑️ Adding animated icons using [Lottie](https://github.com/airbnb/lottie-ios)

## License


This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.






