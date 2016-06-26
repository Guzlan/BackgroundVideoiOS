# BackgroundVideo-iOS
#### *This is a class which lets you add a video background to iOS app views. This is seen at login views of famous apps like spotify, tumbler and Vimeo*

##### This is how they look like.. 

<img src="Screenshots/SpotifyGif.gif" width="30%" height="auto"> <img src="Screenshots/VimeoGif.gif"width="30%" height="auto"> <img src="Screenshots/TumblerGif.gif" width="30%" height="auto">

##### It does the following: 
-*Creates an AVPlayer object for you and plays a video from your app bundle*

-*Handles app going to background and coming back to foreground*

-*Handles seguing away and back again to the view that plays the video*

-*Mutes the video as well as does not allow it to interrupt other audio services. For example, it does not stop music playing from your music app*

##### Instructions:
1. Have an awesome video that you want to show as your background 
2. Drag and drop the video to your project and make sure to check "copy" as well as "Target" (This is because the object will look at your app's main bunddle)
3. Drag and drop **`BackgroundVideo.swift`** file to your Project navigator  
3. Go to the view controller where you want to display the video and declare an instance
```swift
var backgroundPlayer : BackgroundVideo? // Declare an instance of BackgroundVideo called backgroundPlayer
```
4. In your **`viewDidLoad()`** function, initialize your instance with the view controller you're using and the name of the `video file with it's extension` as parameters. In this case I'm passing the same view controller where I declared my instance, namely **`self`**. Then, just call the method **`setUpBackground()`** on your instance. 
```swift
 override func viewDidLoad() {
        super.viewDidLoad()
        // Initializing your instance 
        backgroundPlayer = BackgroundVideo(onViewController: self, withVideoURL: "test.mp4") // Passing self and video name with extension
        backgroundPlayer?.setUpBackground() 
    }

```
