//
//  Sample.swift
//  SampleKit
//
//  Created by Zehua Chen on 12/12/20.
//
import SwiftUI

/// A Metal Sample
open class Sample: NSObject {
  static var _bundle: Bundle = Bundle(for: Sample.self)

  /// Name of the sample
  ///
  /// **Optional**
  open var name: String { return "?" }

  /// Tag of a sample
  ///
  /// **Optional**; default value is `.all`
  open var tag: SampleTag { return .all }

  /// Body of the sample
  ///
  /// **Optional**
  open var body: AnyView { return AnyView(Text("Not Implemented")) }

  /// Create a new sample
  public required override init() {
    super.init()
  }

  public override var hash: Int {
    return name.hashValue
  }

  open override func isEqual(to object: Any?) -> Bool {
    if let anotherSample = object as? Sample {
      return anotherSample.name == name
    }

    return false
  }
}
