# Bezier Color

## Namespace

- V3 구성요소부터는 Bezier Color의 앞글자를 따서 `BC` Prefix를 붙입니다
- V1에서 정의된 구성요소는 기존 이름을 유지합니다

## V3 Color Token의 위계

Bezier Color V3는 2단계 위계의 Token으로 나뉘어집니다

- Global Token(`BCGlobalToken`)
  - HEX값을 참조하는 색상 팔레트로, Semantic token의 값으로 레퍼런싱하는 목적으로만 사용하는 Token입니다
  - 하나의 Global token을 여러 Semantic token에서 레퍼런싱할 수 있습니다
- Semantic Token(`BCSemanticToken`)
  - Global Token을 참조하고 있으며, Light / Dark Theme에 따라 다른 값을 레퍼런스합니다

## Pressed Color

- Pressed 상태의 색상은 원본 색상을 기반으로 HSL 색상 공간에서 명도/채도/투명도를 조정하여 계산합니다
- BCSemanticToken 타입에서만 사용됩니다

### 구조

```
BCSemanticToken
    │
    ├── .pressedColor → BCSemanticToken.custom
            │
            ▼ (internal)
    ColorUtils.getPressedColor(originalColor:colorTheme:)
            │
            ├── rgbToHSL()  // RGB(0-255) → HSL(hue: 0-360, saturation: 0-1, lightness: 0-1)
            ├── 명도/채도/알파 조정
            └── hslToRGB()  // HSL → RGB(0-255)
            │
            ▼
    ColorComponentsWithAlpha (pressed)
```

### 알고리즘 개요

로직 기획 원본은 [노션](https://www.notion.so/channelio/Pressed-Hover-Color-11b74b55ec7c8020b6fcfe272da7138b)에 있습니다

*아래 설명에서 S(채도), L(명도)는 0-1 범위 값입니다*

#### Alpha 처리
| 조건 | 처리 |
|------|------|
| alpha == 0 | 0.10 고정 (무채색: 0.05), 명도/채도 조절 없음 |
| alpha <= 0.20 | 1.5배 증가 |
| alpha > 0.20 | 유지 |

#### 채도 처리
| 조건 | 처리 |
|------|------|
| S >= 0.90 또는 S <= 0.10 | 유지 |
| 0.10 < S < 0.90 | 테마별 로직 적용 |

#### Light Theme
| 조건 | 명도 | 채도 |
|------|------|------|
| Brighter (L <= 0.17 && alpha > 0.20) | (L + 0.07) * 1.1 | S + 0.05 |
| Darker (그 외) | L * 0.93 | S - 0.03 |

*무채색 Brighter: (L + 0.1) * 1.1*

#### Dark Theme
| 조건 | 명도 | 채도 |
|------|------|------|
| Brighter (L < 0.83 && alpha > 0.20) | (L + 0.04) * 1.005 | S + 0.05 |
| Darker (그 외) | (L - 0.2) * 0.98 | S - 0.03 |

*무채색 Darker: (L - 0.04) * 0.97*
