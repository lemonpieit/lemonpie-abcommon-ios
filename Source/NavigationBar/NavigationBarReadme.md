
# Appearance Navigation Bar

## Usage
1. Make your NavigationController a subclass of `AppearanceNavigationController`.
2. Conform the view controllers you want to customize to `NavigationControllerAppearanceContext`.
3. Use this methods to modify the navigation bar:

```swift
var shadowMode: ShadowMode
func title(for navigationController: UINavigationController) -> String?
func prefersLargeTitle(for navigationController: UINavigationController) -> Bool?
func largeTitleDisplayMode(for navigationController: UINavigationController) -> UINavigationItem.LargeTitleDisplayMode
func prefersNavigationbarHidden(for navigationController: UINavigationController) -> Bool
func prefersToolbarHidden(for navigationController: UINavigationController) -> Bool
func preferredAppearance(for navigationController: UINavigationController) -> Appearance?
```
