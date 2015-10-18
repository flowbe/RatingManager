# Rating Manager
A simple Swift class to prompt user to rate app at launch.
## Usage
Simply drag the `RatingManager.swift` file into your Xcode project and put that code in your App Delegate:

    let ratingManager = RatingManager(controller: self.window!.rootViewController, link: "https://itunes.apple.com/fr/app/your-app-link")
    window!.makeKeyAndVisible()
    ratingManager.promptAlert()

### Customization
The `RatingManager` class is fully documented.

If you want to change the prompt period, edit the `period` method in your App Delegate.

### Localization

At this time, strings are in french but if someone wants to translate into english or other language you can create a Pull Request, so I will add it to my repo.