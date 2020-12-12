//
//  Sample.swift
//  SampleKit
//
//  Created by Zehua Chen on 12/12/20.
//

/// A Metal Sample
public protocol Sample: AnyObject {
  /// Name of the sample
  ///
  /// **Required**
  var name: String { get }

  /// Tag of a sample
  ///
  /// **Optional**; default value is `.all`
  var tag: SampleTag { get }

  /// Create a new sample
  init()
}

extension Sample {
  var tag: SampleTag {
    return .all
  }
}
