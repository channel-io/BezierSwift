//
//  GlobalToken.swift
//
//
//  Created by Tom on 3/20/24.
//

import Foundation

struct GlobalToken {
  var hex: String
  
  init(hex: String) {
    self.hex = hex
  }
}

// MARK: - Blue
extension GlobalToken {
  static var blue600: GlobalToken { GlobalToken(hex: "#4941BC") }
  static var blue500: GlobalToken { GlobalToken(hex: "#5950DC") }
  static var blue400: GlobalToken { GlobalToken(hex: "#6D6AFC") }
  static var blue400_30: GlobalToken { GlobalToken(hex: "#6D6AFC4D") }
  static var blue400_20: GlobalToken { GlobalToken(hex: "#6D6AFC33") }
  static var blue400_10: GlobalToken { GlobalToken(hex: "#6D6AFC1A") }
  static var blue300: GlobalToken { GlobalToken(hex: "#84A5FF") }
  static var blue300_45: GlobalToken { GlobalToken(hex: "#84A5FF73") }
  static var blue300_30: GlobalToken { GlobalToken(hex: "#84A5FF4D") }
  static var blue300_15: GlobalToken { GlobalToken(hex: "#84A5FF26") }
  static var blue200: GlobalToken { GlobalToken(hex: "#96B7FF") }
  static var blue100: GlobalToken { GlobalToken(hex: "#A9C6FF") }
}

// MARK: - Cobalt
extension GlobalToken {
  static var cobalt600: GlobalToken { GlobalToken(hex: "#2B59B5") }
  static var cobalt500: GlobalToken { GlobalToken(hex: "#3870D1") }
  static var cobalt400: GlobalToken { GlobalToken(hex: "#5093E5") }
  static var cobalt400_30: GlobalToken { GlobalToken(hex: "#5093E54D") }
  static var cobalt400_20: GlobalToken { GlobalToken(hex: "#5093E533") }
  static var cobalt400_10: GlobalToken { GlobalToken(hex: "#5093E51A") }
  static var cobalt300: GlobalToken { GlobalToken(hex: "#7DC2FA") }
  static var cobalt300_45: GlobalToken { GlobalToken(hex: "#77C0FB73") }
  static var cobalt300_30: GlobalToken { GlobalToken(hex: "#77C0FB4D") }
  static var cobalt300_15: GlobalToken { GlobalToken(hex: "#77C0FB26") }
  static var cobalt200: GlobalToken { GlobalToken(hex: "#9AD1FF") }
  static var cobalt100: GlobalToken { GlobalToken(hex: "#AFDAFF") }
}

// MARK: - Green
extension GlobalToken {
  static var green600: GlobalToken { GlobalToken(hex: "#327055") }
  static var green500: GlobalToken { GlobalToken(hex: "#358761") }
  static var green400: GlobalToken { GlobalToken(hex: "#40AD67") }
  static var green400_30: GlobalToken { GlobalToken(hex: "#40AD674D") }
  static var green400_20: GlobalToken { GlobalToken(hex: "#40AD6733") }
  static var green400_10: GlobalToken { GlobalToken(hex: "#40AD671A") }
  static var green300: GlobalToken { GlobalToken(hex: "#7AD890") }
  static var green300_45: GlobalToken { GlobalToken(hex: "#7AD89073") }
  static var green300_30: GlobalToken { GlobalToken(hex: "#7AD8904D") }
  static var green300_15: GlobalToken { GlobalToken(hex: "#7AD89026") }
  static var green200: GlobalToken { GlobalToken(hex: "#91E5A4") }
  static var green100: GlobalToken { GlobalToken(hex: "#A4ECB3") }
}

// MARK: - Red
extension GlobalToken {
  static var red600: GlobalToken { GlobalToken(hex: "#992C34") }
  static var red500: GlobalToken { GlobalToken(hex: "#BC3A42") }
  static var red400: GlobalToken { GlobalToken(hex: "#E55C5C") }
  static var red400_30: GlobalToken { GlobalToken(hex: "#E55C5C4D") }
  static var red400_20: GlobalToken { GlobalToken(hex: "#E55C5C33") }
  static var red400_10: GlobalToken { GlobalToken(hex: "#E55C5C1A") }
  static var red300: GlobalToken { GlobalToken(hex: "#FF8C8C") }
  static var red300_45: GlobalToken { GlobalToken(hex: "#FF8C8C73") }
  static var red300_30: GlobalToken { GlobalToken(hex: "#FF8C8C4D") }
  static var red300_15: GlobalToken { GlobalToken(hex: "#FF8C8C26") }
  static var red200: GlobalToken { GlobalToken(hex: "#FFA6A6") }
  static var red100: GlobalToken { GlobalToken(hex: "#FFB8B8") }
}

// MARK: - Orange
extension GlobalToken {
  static var orange600: GlobalToken { GlobalToken(hex: "#A1540C") }
  static var orange500: GlobalToken { GlobalToken(hex: "#C1630D") }
  static var orange400: GlobalToken { GlobalToken(hex: "#E67F2B") }
  static var orange400_30: GlobalToken { GlobalToken(hex: "#E67F2B4D") }
  static var orange400_20: GlobalToken { GlobalToken(hex: "#E67F2B33") }
  static var orange400_10: GlobalToken { GlobalToken(hex: "#E67F2B1A") }
  static var orange300: GlobalToken { GlobalToken(hex: "#FFA15E") }
  static var orange300_45: GlobalToken { GlobalToken(hex: "#FFA15E73") }
  static var orange300_30: GlobalToken { GlobalToken(hex: "#FFA15E4D") }
  static var orange300_15: GlobalToken { GlobalToken(hex: "#FFA15E26") }
  static var orange200: GlobalToken { GlobalToken(hex: "#FFB77D") }
  static var orange100: GlobalToken { GlobalToken(hex: "#FFC38F") }
}

// MARK: - Yellow
extension GlobalToken {
  static var yellow600: GlobalToken { GlobalToken(hex: "#9E7504") }
  static var yellow500: GlobalToken { GlobalToken(hex: "#C38F00") }
  static var yellow400: GlobalToken { GlobalToken(hex: "#EDAE0D") }
  static var yellow400_30: GlobalToken { GlobalToken(hex: "#EDAE0D4D") }
  static var yellow400_20: GlobalToken { GlobalToken(hex: "#EDAE0D33") }
  static var yellow400_10: GlobalToken { GlobalToken(hex: "#EDAE0D1A") }
  static var yellow300: GlobalToken { GlobalToken(hex: "#F9C835") }
  static var yellow300_45: GlobalToken { GlobalToken(hex: "#F9C83573") }
  static var yellow300_30: GlobalToken { GlobalToken(hex: "#F9C8354D") }
  static var yellow300_15: GlobalToken { GlobalToken(hex: "#F9C83526") }
  static var yellow200: GlobalToken { GlobalToken(hex: "#FED968") }
  static var yellow100: GlobalToken { GlobalToken(hex: "#FFE38F") }
}

// MARK: - Olive
extension GlobalToken {
  static var olive600: GlobalToken { GlobalToken(hex: "#65691C") }
  static var olive500: GlobalToken { GlobalToken(hex: "#7B801C") }
  static var olive400: GlobalToken { GlobalToken(hex: "#A9B110") }
  static var olive400_30: GlobalToken { GlobalToken(hex: "#A9B1104D") }
  static var olive400_20: GlobalToken { GlobalToken(hex: "#A9B11033") }
  static var olive400_10: GlobalToken { GlobalToken(hex: "#A9B1101A") }
  static var olive300: GlobalToken { GlobalToken(hex: "#C8D630") }
  static var olive300_45: GlobalToken { GlobalToken(hex: "#C8D63073") }
  static var olive300_30: GlobalToken { GlobalToken(hex: "#C8D6304D") }
  static var olive300_15: GlobalToken { GlobalToken(hex: "#C8D63026") }
  static var olive200: GlobalToken { GlobalToken(hex: "#DBE56E") }
  static var olive100: GlobalToken { GlobalToken(hex: "#E7F17C") }
}

// MARK: - Teal
extension GlobalToken {
  static var teal600: GlobalToken { GlobalToken(hex: "#06687D") }
  static var teal500: GlobalToken { GlobalToken(hex: "#068E95") }
  static var teal400: GlobalToken { GlobalToken(hex: "#09B2AC") }
  static var teal400_30: GlobalToken { GlobalToken(hex: "#09B2AC4D") }
  static var teal400_20: GlobalToken { GlobalToken(hex: "#09B2AC33") }
  static var teal400_10: GlobalToken { GlobalToken(hex: "#09B2AC1A") }
  static var teal300: GlobalToken { GlobalToken(hex: "#40D3C5") }
  static var teal300_45: GlobalToken { GlobalToken(hex: "#40D3C573") }
  static var teal300_30: GlobalToken { GlobalToken(hex: "#40D3C54D") }
  static var teal300_15: GlobalToken { GlobalToken(hex: "#40D3C526") }
  static var teal200: GlobalToken { GlobalToken(hex: "#72E0D5") }
  static var teal100: GlobalToken { GlobalToken(hex: "#9BEEE6") }
}

// MARK: - Navy
extension GlobalToken {
  static var navy600: GlobalToken { GlobalToken(hex: "#22245B") }
  static var navy500: GlobalToken { GlobalToken(hex: "#353888") }
  static var navy400: GlobalToken { GlobalToken(hex: "#424FAB") }
  static var navy400_30: GlobalToken { GlobalToken(hex: "#424FAB4D") }
  static var navy400_20: GlobalToken { GlobalToken(hex: "#424FAB33") }
  static var navy400_10: GlobalToken { GlobalToken(hex: "#424FAB1A") }
  static var navy300: GlobalToken { GlobalToken(hex: "#7683D3") }
  static var navy300_45: GlobalToken { GlobalToken(hex: "#7683D373") }
  static var navy300_30: GlobalToken { GlobalToken(hex: "#7683D34D") }
  static var navy300_15: GlobalToken { GlobalToken(hex: "#7683D326") }
  static var navy200: GlobalToken { GlobalToken(hex: "#8B99D9") }
  static var navy100: GlobalToken { GlobalToken(hex: "#A5B2EE") }
}

// MARK: - Purple
extension GlobalToken {
  static var purple600: GlobalToken { GlobalToken(hex: "#54278F") }
  static var purple500: GlobalToken { GlobalToken(hex: "#6735B6") }
  static var purple400: GlobalToken { GlobalToken(hex: "#8E57E7") }
  static var purple400_30: GlobalToken { GlobalToken(hex: "#8E57E74D") }
  static var purple400_20: GlobalToken { GlobalToken(hex: "#8E57E733") }
  static var purple400_10: GlobalToken { GlobalToken(hex: "#8E57E71A") }
  static var purple300: GlobalToken { GlobalToken(hex: "#B184FF") }
  static var purple300_45: GlobalToken { GlobalToken(hex: "#B184FF73") }
  static var purple300_30: GlobalToken { GlobalToken(hex: "#B184FF4D") }
  static var purple300_15: GlobalToken { GlobalToken(hex: "#B184FF26") }
  static var purple200: GlobalToken { GlobalToken(hex: "#C19AFF") }
  static var purple100: GlobalToken { GlobalToken(hex: "#D1B5FF") }
}

// MARK: - Pink
extension GlobalToken {
  static var pink600: GlobalToken { GlobalToken(hex: "#962C86") }
  static var pink500: GlobalToken { GlobalToken(hex: "#B0369E") }
  static var pink400: GlobalToken { GlobalToken(hex: "#D64BB5") }
  static var pink400_30: GlobalToken { GlobalToken(hex: "#D64BB54D") }
  static var pink400_20: GlobalToken { GlobalToken(hex: "#D64BB533") }
  static var pink400_10: GlobalToken { GlobalToken(hex: "#D64BB51A") }
  static var pink300: GlobalToken { GlobalToken(hex: "#EC6FD3") }
  static var pink300_45: GlobalToken { GlobalToken(hex: "#EC6FD373") }
  static var pink300_30: GlobalToken { GlobalToken(hex: "#EC6FD34D") }
  static var pink300_15: GlobalToken { GlobalToken(hex: "#EC6FD326") }
  static var pink200: GlobalToken { GlobalToken(hex: "#F896E5") }
  static var pink100: GlobalToken { GlobalToken(hex: "#FFAFEF") }
}

// MARK: - Shadeblue
extension GlobalToken {
  
}

// MARK: - Shadecobalt
extension GlobalToken {
  
}

// MARK: - Shadegreen
extension GlobalToken {
  
}

// MARK: - Shadered
extension GlobalToken {
  
}

// MARK: - Shadeorange
extension GlobalToken {
  
}

// MARK: - Shadeyellow
extension GlobalToken {
  
}

// MARK: - Shadeolive
extension GlobalToken {
  
}

// MARK: - Shadeteal
extension GlobalToken {
  
}

// MARK: - Shadenavy
extension GlobalToken {
  
}

// MARK: - Shadepurple
extension GlobalToken {
  
}

// MARK: - Shadepink
extension GlobalToken {
  
}

// MARK: - White
extension GlobalToken {
  
}

// MARK: - Black
extension GlobalToken {
  
}

// MARK: - Grey(Solid)
extension GlobalToken {
  
}

// MARK: - Grey(Alpha)
extension GlobalToken {
  
}
