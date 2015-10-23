# SwiftyThreads
Basic Pure Swift expressive background thread execution

## Usage
```Swift
STBackground { () -> () in
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
STBackground { () -> () in
        // Code to perform in a background thread
      }
  
// Do this in the background, then tell me when you're done
STBackground { () -> () in
        // Code to perform in a background thread
      }.completion { () -> () in
        // Done! Code here is evaluated on the main thread, when the task completes
      }
      
// Do this in the background, and tell me only if you're taking a long time
STBackground { () -> () in
        // Code to perform in a background thread
      }.afterInterval(3) { () -> () in
        // Still running? Code here is evaluated on the main thread, if the task is not complete
      }
```
