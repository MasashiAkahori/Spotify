//
//  AuthResponse.swift
//  Spotify
//
//  Created by 赤堀雅司 on 21/6/21.
//

import Foundation

struct AuthResponse: Codable {
  let access_token: String
  let expires_in: Int
  let refresh_token: String?
  let scope: String
  let token_type: String
}
