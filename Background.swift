//
//  Backround.swift
//  Blur
//
//  Created by Andrew Robinson on 10/22/15.
//  Copyright © 2015 Andrew Robinson. All rights reserved.
//

import Foundation

class Background {
  
  private var done = false {
    didSet {
      if done {
        taskInterval = nil
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
          completion?()
        })
      }
    }
  }
  
  private var taskInterval: (() -> ())?
  private var completion: (() -> ())?
  
  init(task: () -> ()) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
      task()
      self.done = true
    }
  }
  
  func afterInterval(interval: NSTimeInterval, closure: () -> ()) -> Background {
    taskInterval = closure
    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(interval * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, dispatch_get_main_queue()) { [weak self] in
      self?.taskInterval?()
    }
    return self
  }
  
  func completion(closure: () -> ()) -> Background {
    completion = closure
    return self
  }
  
}
