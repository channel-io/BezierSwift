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
