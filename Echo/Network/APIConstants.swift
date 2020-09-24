//
//  APIConstants.swift
//  Echo
//
//  Created by Kasito on 22.09.2020.
//

import Foundation

typealias ResponseResult<T: Codable> = (ResponseObject<T>?, Error?) -> (Void)
typealias VoidBlock = () -> (Void)

enum SignType {
    
    case register
    case login
}

enum Locale: String, CaseIterable {
    case bg_BG, da_DK, el_GR, en_NG, en_ZA, fi_FI, he_IL, ka_GE, me_ME, nl_NL, pt_PT, sr_Cyrl_RS, tr_TR, zh_TW, ar_JO, en_AU, en_NZ, es_AR, hr_HR, kk_KZ, ro_MD, sr_Latn_RS, uk_UA, ar_SA, bn_BD, de_AT, en_CA, en_PH, es_ES, fr_BE, is_IS, ko_KR, mn_MN, ro_RO, sr_RS, at_AT, de_CH, en_GB, en_SG, es_PE, fr_CA, hu_HU, it_CH, nb_NO, ru_RU, sv_SE, de_DE, en_HK, en_UG, es_VE, fr_CH, hy_AM, it_IT, lt_LT, ne_NP, pl_PL, sk_SK, vi_VN, cs_CZ, el_CY, en_IN, en_US, fa_IR, fr_FR, id_ID, ja_JP, lv_LV, nl_BE, pt_BR, sl_SI, th_TH, zh_CN
}

enum HTTPMethod: String {
    
    case post = "POST"
    case get = "GET"
}

struct AccessToken {
    
    static let token = "token"
}

struct BodyKey {
    
    static let name = "name"
    static let email = "email"
    static let password = "password"
}


