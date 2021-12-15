//
//  Article.swift
//  GoodNewsApp
//
//  Created by 재영신 on 2021/12/07.
//

import Foundation

struct ArticleList: Decodable {
    let articles: [Article]
}

struct Article: Decodable{
    let title: String
    let description: String?
}
