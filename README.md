# SwiftyThreads
Basic Pure Swift expressive background thread execution

## Usage
```Swift
Background { () -> () in
        // Code to perform in a background thread
      }.afterInterval(3) { () -> () in
        // Still running? Code here is evaluated on the main thread, if the task is not complete
        // Optional
      }.completion { () -> () in
        // Done! Code here is evaluated on the main thread, when the task completes
        // Optional
      }
```

### Alternate Usage
```Swift

// Just do this in the background, I don't care about anything else.
Background { () -> () in
        // Code to perform in a background thread
      }
  
// Do this in the background, then tell me when you're done
Background { () -> () in
        // Code to perform in a background thread
      }.completion { () -> () in
        // Done! Code here is evaluated on the main thread, when the task completes
      }
      
// Do this in the background, and tell me only if you're taking a long time
Background { () -> () in
        // Code to perform in a background thread
      }.afterInterval(3) { () -> () in
        // Still running? Code here is evaluated on the main thread, if the task is not complete
      }
```


#### Use Case
```Swift
let data = ...
var image: UIImage

Background { () -> () in
        self.loadingMessage = "Loading image..."
        image = UIImage(data: data)
      }.afterInterval(3) { () -> () in
        self.loadingMessage = "It's taking longer than normal..."
      }.completion { () -> () in
        self.loadedImage = image
      }
```
