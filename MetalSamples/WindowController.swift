//
//  WindowController.swift
//  MetalSamples
//
//  Created by Zehua Chen on 12/14/20.
//

import AppKit

extension NSToolbarItem.Identifier {
  static var secondThirdSectionSeparator: Self = .init("secondThirdSectionSeparator")
}

class WindowController: NSWindowController, NSToolbarDelegate {
  var secondThirdSectionSeparator: NSTrackingSeparatorToolbarItem!

  override func windowDidLoad() {
    super.windowDidLoad()

    secondThirdSectionSeparator = NSTrackingSeparatorToolbarItem(
      identifier: .secondThirdSectionSeparator,
      splitView: window!.contentView!.subviews[0] as! NSSplitView,
      dividerIndex: 1)

    let toolbar = NSToolbar(identifier: "MainToolbar")
    toolbar.sizeMode = .regular
    toolbar.displayMode = .iconOnly
    toolbar.delegate = self
    toolbar.allowsUserCustomization = false

    window!.toolbar = toolbar
    window!.toolbarStyle = .unified
  }

  func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
    return [
      .toggleSidebar,
      .secondThirdSectionSeparator
    ]
  }

  func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
    return [
      .toggleSidebar,
      .secondThirdSectionSeparator
    ]
  }

  func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
    print(#function)
    switch itemIdentifier {
    case .secondThirdSectionSeparator:
      return secondThirdSectionSeparator
    default:
      return nil
    }
  }
}
