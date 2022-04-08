import SwiftUI

// NOTE: code gen as follows:
//
//       import Foundation
//
//       let autoScopeCount = 256
//
//       print("// inside AutoScoping.AutoScopes")
//       print("static let count = \(autoScopeCount)")
//
//       for i in 0..<autoScopeCount {
//           print("struct _\(i) {}")
//       }
//
//       print("// inside switch statement inside makeBody()")
//       for i in 0..<autoScopeCount {
//         let index = (i + 1) % autoScopeCount
//         print(String(format: "%-12sreturn make(AS._\(index).self)", ((index == 0 ? "default:" : "case \(index):") as NSString).utf8String!))
//       }

internal struct AutoScoping {
  struct AutoScopes {
    // NOTE: refer to the code gen above
    static let count = 256
    struct _0 {}
    struct _1 {}
    struct _2 {}
    struct _3 {}
    struct _4 {}
    struct _5 {}
    struct _6 {}
    struct _7 {}
    struct _8 {}
    struct _9 {}
    struct _10 {}
    struct _11 {}
    struct _12 {}
    struct _13 {}
    struct _14 {}
    struct _15 {}
    struct _16 {}
    struct _17 {}
    struct _18 {}
    struct _19 {}
    struct _20 {}
    struct _21 {}
    struct _22 {}
    struct _23 {}
    struct _24 {}
    struct _25 {}
    struct _26 {}
    struct _27 {}
    struct _28 {}
    struct _29 {}
    struct _30 {}
    struct _31 {}
    struct _32 {}
    struct _33 {}
    struct _34 {}
    struct _35 {}
    struct _36 {}
    struct _37 {}
    struct _38 {}
    struct _39 {}
    struct _40 {}
    struct _41 {}
    struct _42 {}
    struct _43 {}
    struct _44 {}
    struct _45 {}
    struct _46 {}
    struct _47 {}
    struct _48 {}
    struct _49 {}
    struct _50 {}
    struct _51 {}
    struct _52 {}
    struct _53 {}
    struct _54 {}
    struct _55 {}
    struct _56 {}
    struct _57 {}
    struct _58 {}
    struct _59 {}
    struct _60 {}
    struct _61 {}
    struct _62 {}
    struct _63 {}
    struct _64 {}
    struct _65 {}
    struct _66 {}
    struct _67 {}
    struct _68 {}
    struct _69 {}
    struct _70 {}
    struct _71 {}
    struct _72 {}
    struct _73 {}
    struct _74 {}
    struct _75 {}
    struct _76 {}
    struct _77 {}
    struct _78 {}
    struct _79 {}
    struct _80 {}
    struct _81 {}
    struct _82 {}
    struct _83 {}
    struct _84 {}
    struct _85 {}
    struct _86 {}
    struct _87 {}
    struct _88 {}
    struct _89 {}
    struct _90 {}
    struct _91 {}
    struct _92 {}
    struct _93 {}
    struct _94 {}
    struct _95 {}
    struct _96 {}
    struct _97 {}
    struct _98 {}
    struct _99 {}
    struct _100 {}
    struct _101 {}
    struct _102 {}
    struct _103 {}
    struct _104 {}
    struct _105 {}
    struct _106 {}
    struct _107 {}
    struct _108 {}
    struct _109 {}
    struct _110 {}
    struct _111 {}
    struct _112 {}
    struct _113 {}
    struct _114 {}
    struct _115 {}
    struct _116 {}
    struct _117 {}
    struct _118 {}
    struct _119 {}
    struct _120 {}
    struct _121 {}
    struct _122 {}
    struct _123 {}
    struct _124 {}
    struct _125 {}
    struct _126 {}
    struct _127 {}
    struct _128 {}
    struct _129 {}
    struct _130 {}
    struct _131 {}
    struct _132 {}
    struct _133 {}
    struct _134 {}
    struct _135 {}
    struct _136 {}
    struct _137 {}
    struct _138 {}
    struct _139 {}
    struct _140 {}
    struct _141 {}
    struct _142 {}
    struct _143 {}
    struct _144 {}
    struct _145 {}
    struct _146 {}
    struct _147 {}
    struct _148 {}
    struct _149 {}
    struct _150 {}
    struct _151 {}
    struct _152 {}
    struct _153 {}
    struct _154 {}
    struct _155 {}
    struct _156 {}
    struct _157 {}
    struct _158 {}
    struct _159 {}
    struct _160 {}
    struct _161 {}
    struct _162 {}
    struct _163 {}
    struct _164 {}
    struct _165 {}
    struct _166 {}
    struct _167 {}
    struct _168 {}
    struct _169 {}
    struct _170 {}
    struct _171 {}
    struct _172 {}
    struct _173 {}
    struct _174 {}
    struct _175 {}
    struct _176 {}
    struct _177 {}
    struct _178 {}
    struct _179 {}
    struct _180 {}
    struct _181 {}
    struct _182 {}
    struct _183 {}
    struct _184 {}
    struct _185 {}
    struct _186 {}
    struct _187 {}
    struct _188 {}
    struct _189 {}
    struct _190 {}
    struct _191 {}
    struct _192 {}
    struct _193 {}
    struct _194 {}
    struct _195 {}
    struct _196 {}
    struct _197 {}
    struct _198 {}
    struct _199 {}
    struct _200 {}
    struct _201 {}
    struct _202 {}
    struct _203 {}
    struct _204 {}
    struct _205 {}
    struct _206 {}
    struct _207 {}
    struct _208 {}
    struct _209 {}
    struct _210 {}
    struct _211 {}
    struct _212 {}
    struct _213 {}
    struct _214 {}
    struct _215 {}
    struct _216 {}
    struct _217 {}
    struct _218 {}
    struct _219 {}
    struct _220 {}
    struct _221 {}
    struct _222 {}
    struct _223 {}
    struct _224 {}
    struct _225 {}
    struct _226 {}
    struct _227 {}
    struct _228 {}
    struct _229 {}
    struct _230 {}
    struct _231 {}
    struct _232 {}
    struct _233 {}
    struct _234 {}
    struct _235 {}
    struct _236 {}
    struct _237 {}
    struct _238 {}
    struct _239 {}
    struct _240 {}
    struct _241 {}
    struct _242 {}
    struct _243 {}
    struct _244 {}
    struct _245 {}
    struct _246 {}
    struct _247 {}
    struct _248 {}
    struct _249 {}
    struct _250 {}
    struct _251 {}
    struct _252 {}
    struct _253 {}
    struct _254 {}
    struct _255 {}
  }
}

internal extension SafelyScopedMeasurementReader {
  func makeBody() -> AnyView {
    func make<Subscope>(_ subscopeType: Subscope.Type) -> AnyView {
      .init(
        ScopedMeasurementReader<ScopeChain<Subscope, Scope>, Tag>(
          version: version,
          reducer: reducer
        ) {
          content(.init($0))
        }
      )
    }
    
    typealias AS = AutoScoping.AutoScopes
    switch autoScopeState.autoScope % AS.count {
      // NOTE: refer to the code gen above
    case 1:     return make(AS._1.self)
    case 2:     return make(AS._2.self)
    case 3:     return make(AS._3.self)
    case 4:     return make(AS._4.self)
    case 5:     return make(AS._5.self)
    case 6:     return make(AS._6.self)
    case 7:     return make(AS._7.self)
    case 8:     return make(AS._8.self)
    case 9:     return make(AS._9.self)
    case 10:    return make(AS._10.self)
    case 11:    return make(AS._11.self)
    case 12:    return make(AS._12.self)
    case 13:    return make(AS._13.self)
    case 14:    return make(AS._14.self)
    case 15:    return make(AS._15.self)
    case 16:    return make(AS._16.self)
    case 17:    return make(AS._17.self)
    case 18:    return make(AS._18.self)
    case 19:    return make(AS._19.self)
    case 20:    return make(AS._20.self)
    case 21:    return make(AS._21.self)
    case 22:    return make(AS._22.self)
    case 23:    return make(AS._23.self)
    case 24:    return make(AS._24.self)
    case 25:    return make(AS._25.self)
    case 26:    return make(AS._26.self)
    case 27:    return make(AS._27.self)
    case 28:    return make(AS._28.self)
    case 29:    return make(AS._29.self)
    case 30:    return make(AS._30.self)
    case 31:    return make(AS._31.self)
    case 32:    return make(AS._32.self)
    case 33:    return make(AS._33.self)
    case 34:    return make(AS._34.self)
    case 35:    return make(AS._35.self)
    case 36:    return make(AS._36.self)
    case 37:    return make(AS._37.self)
    case 38:    return make(AS._38.self)
    case 39:    return make(AS._39.self)
    case 40:    return make(AS._40.self)
    case 41:    return make(AS._41.self)
    case 42:    return make(AS._42.self)
    case 43:    return make(AS._43.self)
    case 44:    return make(AS._44.self)
    case 45:    return make(AS._45.self)
    case 46:    return make(AS._46.self)
    case 47:    return make(AS._47.self)
    case 48:    return make(AS._48.self)
    case 49:    return make(AS._49.self)
    case 50:    return make(AS._50.self)
    case 51:    return make(AS._51.self)
    case 52:    return make(AS._52.self)
    case 53:    return make(AS._53.self)
    case 54:    return make(AS._54.self)
    case 55:    return make(AS._55.self)
    case 56:    return make(AS._56.self)
    case 57:    return make(AS._57.self)
    case 58:    return make(AS._58.self)
    case 59:    return make(AS._59.self)
    case 60:    return make(AS._60.self)
    case 61:    return make(AS._61.self)
    case 62:    return make(AS._62.self)
    case 63:    return make(AS._63.self)
    case 64:    return make(AS._64.self)
    case 65:    return make(AS._65.self)
    case 66:    return make(AS._66.self)
    case 67:    return make(AS._67.self)
    case 68:    return make(AS._68.self)
    case 69:    return make(AS._69.self)
    case 70:    return make(AS._70.self)
    case 71:    return make(AS._71.self)
    case 72:    return make(AS._72.self)
    case 73:    return make(AS._73.self)
    case 74:    return make(AS._74.self)
    case 75:    return make(AS._75.self)
    case 76:    return make(AS._76.self)
    case 77:    return make(AS._77.self)
    case 78:    return make(AS._78.self)
    case 79:    return make(AS._79.self)
    case 80:    return make(AS._80.self)
    case 81:    return make(AS._81.self)
    case 82:    return make(AS._82.self)
    case 83:    return make(AS._83.self)
    case 84:    return make(AS._84.self)
    case 85:    return make(AS._85.self)
    case 86:    return make(AS._86.self)
    case 87:    return make(AS._87.self)
    case 88:    return make(AS._88.self)
    case 89:    return make(AS._89.self)
    case 90:    return make(AS._90.self)
    case 91:    return make(AS._91.self)
    case 92:    return make(AS._92.self)
    case 93:    return make(AS._93.self)
    case 94:    return make(AS._94.self)
    case 95:    return make(AS._95.self)
    case 96:    return make(AS._96.self)
    case 97:    return make(AS._97.self)
    case 98:    return make(AS._98.self)
    case 99:    return make(AS._99.self)
    case 100:   return make(AS._100.self)
    case 101:   return make(AS._101.self)
    case 102:   return make(AS._102.self)
    case 103:   return make(AS._103.self)
    case 104:   return make(AS._104.self)
    case 105:   return make(AS._105.self)
    case 106:   return make(AS._106.self)
    case 107:   return make(AS._107.self)
    case 108:   return make(AS._108.self)
    case 109:   return make(AS._109.self)
    case 110:   return make(AS._110.self)
    case 111:   return make(AS._111.self)
    case 112:   return make(AS._112.self)
    case 113:   return make(AS._113.self)
    case 114:   return make(AS._114.self)
    case 115:   return make(AS._115.self)
    case 116:   return make(AS._116.self)
    case 117:   return make(AS._117.self)
    case 118:   return make(AS._118.self)
    case 119:   return make(AS._119.self)
    case 120:   return make(AS._120.self)
    case 121:   return make(AS._121.self)
    case 122:   return make(AS._122.self)
    case 123:   return make(AS._123.self)
    case 124:   return make(AS._124.self)
    case 125:   return make(AS._125.self)
    case 126:   return make(AS._126.self)
    case 127:   return make(AS._127.self)
    case 128:   return make(AS._128.self)
    case 129:   return make(AS._129.self)
    case 130:   return make(AS._130.self)
    case 131:   return make(AS._131.self)
    case 132:   return make(AS._132.self)
    case 133:   return make(AS._133.self)
    case 134:   return make(AS._134.self)
    case 135:   return make(AS._135.self)
    case 136:   return make(AS._136.self)
    case 137:   return make(AS._137.self)
    case 138:   return make(AS._138.self)
    case 139:   return make(AS._139.self)
    case 140:   return make(AS._140.self)
    case 141:   return make(AS._141.self)
    case 142:   return make(AS._142.self)
    case 143:   return make(AS._143.self)
    case 144:   return make(AS._144.self)
    case 145:   return make(AS._145.self)
    case 146:   return make(AS._146.self)
    case 147:   return make(AS._147.self)
    case 148:   return make(AS._148.self)
    case 149:   return make(AS._149.self)
    case 150:   return make(AS._150.self)
    case 151:   return make(AS._151.self)
    case 152:   return make(AS._152.self)
    case 153:   return make(AS._153.self)
    case 154:   return make(AS._154.self)
    case 155:   return make(AS._155.self)
    case 156:   return make(AS._156.self)
    case 157:   return make(AS._157.self)
    case 158:   return make(AS._158.self)
    case 159:   return make(AS._159.self)
    case 160:   return make(AS._160.self)
    case 161:   return make(AS._161.self)
    case 162:   return make(AS._162.self)
    case 163:   return make(AS._163.self)
    case 164:   return make(AS._164.self)
    case 165:   return make(AS._165.self)
    case 166:   return make(AS._166.self)
    case 167:   return make(AS._167.self)
    case 168:   return make(AS._168.self)
    case 169:   return make(AS._169.self)
    case 170:   return make(AS._170.self)
    case 171:   return make(AS._171.self)
    case 172:   return make(AS._172.self)
    case 173:   return make(AS._173.self)
    case 174:   return make(AS._174.self)
    case 175:   return make(AS._175.self)
    case 176:   return make(AS._176.self)
    case 177:   return make(AS._177.self)
    case 178:   return make(AS._178.self)
    case 179:   return make(AS._179.self)
    case 180:   return make(AS._180.self)
    case 181:   return make(AS._181.self)
    case 182:   return make(AS._182.self)
    case 183:   return make(AS._183.self)
    case 184:   return make(AS._184.self)
    case 185:   return make(AS._185.self)
    case 186:   return make(AS._186.self)
    case 187:   return make(AS._187.self)
    case 188:   return make(AS._188.self)
    case 189:   return make(AS._189.self)
    case 190:   return make(AS._190.self)
    case 191:   return make(AS._191.self)
    case 192:   return make(AS._192.self)
    case 193:   return make(AS._193.self)
    case 194:   return make(AS._194.self)
    case 195:   return make(AS._195.self)
    case 196:   return make(AS._196.self)
    case 197:   return make(AS._197.self)
    case 198:   return make(AS._198.self)
    case 199:   return make(AS._199.self)
    case 200:   return make(AS._200.self)
    case 201:   return make(AS._201.self)
    case 202:   return make(AS._202.self)
    case 203:   return make(AS._203.self)
    case 204:   return make(AS._204.self)
    case 205:   return make(AS._205.self)
    case 206:   return make(AS._206.self)
    case 207:   return make(AS._207.self)
    case 208:   return make(AS._208.self)
    case 209:   return make(AS._209.self)
    case 210:   return make(AS._210.self)
    case 211:   return make(AS._211.self)
    case 212:   return make(AS._212.self)
    case 213:   return make(AS._213.self)
    case 214:   return make(AS._214.self)
    case 215:   return make(AS._215.self)
    case 216:   return make(AS._216.self)
    case 217:   return make(AS._217.self)
    case 218:   return make(AS._218.self)
    case 219:   return make(AS._219.self)
    case 220:   return make(AS._220.self)
    case 221:   return make(AS._221.self)
    case 222:   return make(AS._222.self)
    case 223:   return make(AS._223.self)
    case 224:   return make(AS._224.self)
    case 225:   return make(AS._225.self)
    case 226:   return make(AS._226.self)
    case 227:   return make(AS._227.self)
    case 228:   return make(AS._228.self)
    case 229:   return make(AS._229.self)
    case 230:   return make(AS._230.self)
    case 231:   return make(AS._231.self)
    case 232:   return make(AS._232.self)
    case 233:   return make(AS._233.self)
    case 234:   return make(AS._234.self)
    case 235:   return make(AS._235.self)
    case 236:   return make(AS._236.self)
    case 237:   return make(AS._237.self)
    case 238:   return make(AS._238.self)
    case 239:   return make(AS._239.self)
    case 240:   return make(AS._240.self)
    case 241:   return make(AS._241.self)
    case 242:   return make(AS._242.self)
    case 243:   return make(AS._243.self)
    case 244:   return make(AS._244.self)
    case 245:   return make(AS._245.self)
    case 246:   return make(AS._246.self)
    case 247:   return make(AS._247.self)
    case 248:   return make(AS._248.self)
    case 249:   return make(AS._249.self)
    case 250:   return make(AS._250.self)
    case 251:   return make(AS._251.self)
    case 252:   return make(AS._252.self)
    case 253:   return make(AS._253.self)
    case 254:   return make(AS._254.self)
    case 255:   return make(AS._255.self)
    default:    return make(AS._0.self)
    }
  }
}
