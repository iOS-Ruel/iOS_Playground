//
//  LocationBasedListModel.swift
//  CamPlace
//
//  Created by Chung Wussup on 6/15/24.
//

import Foundation

struct LocationBasedListModel: BasedItem {
    var imageUrl: String?
    var title: String?
    var subTitle: String?
    var mapX: String?
    var mapY: String?
    
    
    let wtrplCo: String
    let brazierCl: String
    let featureNm: String
    let induty: String
    let caravAcmpnyAt: String
    let toiletCo: String
    let swrmCo: String
    let intro: String
    let allar: String
    let insrncAt: String
    let trsagntNo: String
    let bizrno: String
    let facltDivNm: String
    let mangeDivNm: String
    let exprnProgrmAt: String
    let exprnProgrm: String
    let extshrCo: String
    let frprvtWrppCo: String
    let frprvtSandCo: String
    let caravInnerFclty: String
    let prmisnDe: String
    let operPdCl: String
    let operDeCl: String
    let trlerAcmpnyAt: String
    let mgcDiv: String
    let manageSttus: String
    let hvofBgnde: String
    let hvofEnddle: String
    let siteMg1Width: String
    let siteMg2Width: String
    let siteMg3Width: String
    let siteMg1Vrticl: String
    let siteMg2Vrticl: String
    let siteMg3Vrticl: String
    let siteMg1Co: String
    let siteMg2Co: String
    let siteMg3Co: String
    let siteBottomCl1: String
    let siteBottomCl2: String
    let fireSensorCo: String
    let themaEnvrnCl: String
    let eqpmnLendCl: String
    let animalCmgCl: String
    let tourEraCl: String
    let createdtime: String
    let modifiedtime: String
    let doNm: String
    let sigunguNm: String
    let zipcode: String
    let addr2: String
    let direction: String
    let tel: String
    let homepage: String
    let resveUrl: String
    let resveCl: String
    let manageNmpr: String
    let gnrlSiteCo: String
    let autoSiteCo: String
    let glampSiteCo: String
    let caravSiteCo: String
    let indvdlCaravSiteCo: String
    let sitedStnc: String
    let sbrsEtc: String
    let posblFcltyCl: String
    let posblFcltyEtc: String
    let clturEventAt: String
    let clturEvent: String
    let siteBottomCl3: String
    let siteBottomCl4: String
    let siteBottomCl5: String
    let tooltip: String
    let glampInnerFclty: String
    let contentId: String
    let lineIntro: String
    let sbrsCl: String
    let lctCl: String
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "firstImageUrl"
        case title = "facltNm"
        case subTitle = "addr1"
        case mapX = "mapX"
        case mapY = "mapY"
        case wtrplCo, brazierCl, featureNm, induty, caravAcmpnyAt, toiletCo, swrmCo, intro, allar, insrncAt, trsagntNo, bizrno, facltDivNm, mangeDivNm, exprnProgrmAt, exprnProgrm, extshrCo, frprvtWrppCo, frprvtSandCo, caravInnerFclty, prmisnDe, operPdCl, operDeCl, trlerAcmpnyAt, mgcDiv, manageSttus, hvofBgnde, hvofEnddle, siteMg1Width, siteMg2Width, siteMg3Width, siteMg1Vrticl, siteMg2Vrticl, siteMg3Vrticl, siteMg1Co, siteMg2Co, siteMg3Co, siteBottomCl1, siteBottomCl2, fireSensorCo, themaEnvrnCl, eqpmnLendCl, animalCmgCl, tourEraCl, createdtime, modifiedtime, doNm, sigunguNm, zipcode, addr2, direction, tel, homepage, resveUrl, resveCl, manageNmpr, gnrlSiteCo, autoSiteCo, glampSiteCo, caravSiteCo, indvdlCaravSiteCo, sitedStnc, sbrsEtc, posblFcltyCl, posblFcltyEtc, clturEventAt, clturEvent, siteBottomCl3, siteBottomCl4, siteBottomCl5, tooltip, glampInnerFclty, contentId, lineIntro, sbrsCl, lctCl
    }
}
