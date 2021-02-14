//
//  BannersModel.swift
//  JaddaButcher
//
//  Created by Elattar on 2/7/21.
//  Copyright © 2021 Elattar. All rights reserved.
//

import Foundation
struct WelcomeBanners: Codable {
    let status: Int?
    let data: [DataBanners]?
}

// MARK: - Datum
struct DataBanners: Codable {
    let id: Int?
    let title, image: String?
    let imagePath: String?
}
