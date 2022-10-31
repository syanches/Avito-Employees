//
//  CachedURLResponse+ResponseWIth.swift
//  Avito-Employees
//
//  Created by Artem Martirosyan on 31.10.2022.
//

import Foundation

extension CachedURLResponse {
    func response(withExpirationDuration duration: Int) -> CachedURLResponse {
        var cachedResponse = self
        if let httpResponse = cachedResponse.response as? HTTPURLResponse, var headers = httpResponse.allHeaderFields as? [String: String], let url = httpResponse.url {

            headers["Cache-Control"] = "max-age=\(duration)"
            headers.removeValue(forKey: "Expires")
            headers.removeValue(forKey: "s-maxage")

            if let newResponse = HTTPURLResponse(url: url, statusCode: httpResponse.statusCode, httpVersion: "HTTP/1.1", headerFields: headers) {
            cachedResponse = CachedURLResponse(response: newResponse, data: cachedResponse.data, userInfo: headers, storagePolicy: cachedResponse.storagePolicy)
            }
        }
        return cachedResponse
    }
}
