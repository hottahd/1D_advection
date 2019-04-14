# SC4RK4_advection

太陽光球計算コードとして有名なMURaMコード(Vögler+2005)などで使われている4次精度の中央差分と4段のRunge-Kuttaを用いて、移流方程式を解くコード。
人工粘性としてRempel, 2014で使われているものを使う。

## 解く方程式
1次元の移流方程式
$$\frac{\partial Q}{\partial t} = - v_x\frac{\partial Q}{\partial x}$$

$v_x=1$とする。初期条件は好きに定めてよいが、デフォルトでは、ガウス関数にしてある。
境界条件は周期境界である。
## 数値スキーム

### 4次精度中央差分

$$\left(\frac{\partial Q}{\partial x}\right)_{i}=
\frac{-Q_{i+2}+8Q_{i+1}-8Q_{i-1}+Q_{i-2}}{12\Delta x}$$

### 4段Runge-Kutta
