//
//  SettingsModels.swift
//  Spotify
//
//  Created by 赤堀雅司 on 24/6/21.
//

import Foundation

struct Sections {
  let title: String
  let options: [Option]
}

struct Option {
  let title: String
  let handler: () -> Void
}
