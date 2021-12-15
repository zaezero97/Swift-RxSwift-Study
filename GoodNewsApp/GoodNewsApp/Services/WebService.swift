//
//  WebService.swift
//  GoodNewsApp
//
//  Created by 재영신 on 2021/12/07.
//

import Foundation

class WebService{
    
    func getArticles(url: URL,compltion: @escaping ([Article]?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                compltion(nil)
            } else if let data = data {
                
                let articleList = try? JSONDecoder().decode(ArticleList.self, from: data)
                
                if let articleList = articleList {
                    compltion(articleList.articles)
                }
                print(articleList?.articles)
            }
        }.resume()
    }
}
