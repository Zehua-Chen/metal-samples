//
//  WindowController.swift
//  MetalSamples
//
//  Created by Zehua Chen on 12/14/20.
//

import AppKit

extension NSToolbarItem.Identifier {
  static var secondThirdSectionSeparator: Self = .init("secondThirdSectionSeparator")
  static var search: Self = .init("search")
}

class WindowController: NSWindowController, NSToolbarDelegate {
  var secondThirdSectionSeparator: NSTrackingSeparatorToolbarItem!
  var search: NSSearchToolbarItem!
  let toolbarItemIdentifiers: [NSToolbarItem.Identifier] = [
    .toggleSidebar,
    .secondThirdSectionSeparator,
    .flexibleSpace,
    .search,
  ]

  override func windowDidLoad() {
    super.windowDidLoad()

    secondThirdSectionSeparator = NSTrackingSeparatorToolbarItem(
      identifier: .secondThirdSectionSeparator,
      splitView: window!.contentView!.subviews[0] as! NSSplitView,
      dividerIndex: 1)

    search = NSSearchToolbarItem(itemIdentifier: .search)

    let toolbar = NSToolbar(identifier: "MainToolbar")

    toolbar.sizeMode = .regular
    toolbar.displayMode = .iconOnly
    toolbar.delegate = self
    toolbar.allowsUserCustomization = false

    window!.toolbar = toolbar
    window!.toolbarStyle = .unified
  }

  func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
    return toolbarItemIdentifiers
  }

  func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
    return toolbarItemIdentifiers
  }

  func toolbar(
    _ toolbar: NSToolbar,
    itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
    willBeInsertedIntoToolbar flag: Bool
  ) -> NSToolbarItem? {
    switch itemIdentifier {
    case .secondThirdSectionSeparator:
      return secondThirdSectionSeparator
    case .search:
      return search
    default:
      return nil
    }
  }
}
