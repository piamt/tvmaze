//
//  APIServiceResult.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import UIKit

typealias JSONObject = [String: Any]
typealias JSONArray = [[String: Any]]

typealias APIServiceResult = Result<JSONArray, ErrorModel>
typealias APIServiceResultBlock = (Result<Data, ErrorModel>) -> Void // TODO: remove the rest, remove file

typealias APIServiceObjectResult = (Result<JSONObject, ErrorModel>)
typealias APIServiceObjectResultBlock = (Result<JSONObject, ErrorModel>) -> Void
