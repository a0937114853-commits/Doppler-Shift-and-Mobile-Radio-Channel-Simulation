# 無線通訊：都普勒頻移統計模擬與理論推導報告

本專案探討無線行動通訊系統中的通道傳播效應（Propagation Effects），涵蓋行動台在不同移動速度與載波頻率下之都普勒頻移（Doppler Shift）理論推導、蒙地卡羅統計模擬，以及隨機速度分佈下的複合頻譜特性分析。

---

## 📋 系統規格與模擬參數 (System Specifications & Parameters)
* **課程作業**：Wireless Communications Homework II (Dr. Tsai, NTHU)
* **學生資訊**：112021117 詹朝陽 (Chao-Yang Zhan)
* **核心主題**：都普勒頻移分佈、PDF 與 CDF 統計模擬、古典都普勒頻譜解析與理論驗證
* **模擬樣本數**：N = 1,111,111 點
* **系統設定狀況**：
  * **狀況 (a)**：v = 20 km/hr、fc = 2 GHz（最大都普勒頻率 fm ≈ 37.04 Hz）
  * **狀況 (b)**：v = 90 km/hr、fc = 26 GHz（最大都普勒頻率 fm ≈ 2166.67 Hz）
  * **狀況 (c)**：fc = 2 GHz，v 在 20 ~ 90 km/hr 之間呈均勻分佈 (v ~ Uniform(20, 90))
  * **來波入射角 (θ)**：假設在 [-π, π] 之間均勻分佈 (θ(t) ~ Uniform(-π, π))

---

## 1. 都普勒頻移理論與模擬架構

在無線行動通訊系統中，當行動台以速度 v 移動並接收未調製的載波頻率 fc 時，所觀察到的都普勒頻移為：
`f_D(t) = f_m * cos(θ(t))`
其中最大都普勒頻率定義為 `f_m = (v * fc) / c`，θ(t) 為來波入射角。

---

## 2. 狀況 (a)：固定速度 v = 20 km/hr 與 fc = 2 GHz 之模擬與解析

* **系統參數**：v ≈ 5.556 m/s、fc = 2 GHz、fm ≈ 37.04 Hz。
* **現象觀察**：模擬結果呈現經典的「浴缸型（Bathtub-shaped）」或 U 型頻譜（U-shaped spectrum），機率密度在極值 ±fm 附近顯著飆升，而在中間頻段相對平緩。

| 狀況 (a) 機率密度函數 (PDF) (圖 1) | 狀況 (a) 累積分佈函數 (CDF) (圖 2) |
| :---: | :---: |
| ![PDF a](doppler_a_pdf.png)<br>*圖 1：v = 20 km/hr、fc = 2 GHz 之模擬 PDF* | ![CDF a](doppler_a_cdf.png)<br>*圖 2：v = 20 km/hr、fc = 2 GHz 之模擬 CDF* |

---

## 3. 狀況 (b)：高速與高頻 v = 90 km/hr 與 fc = 26 GHz 之模擬與解析

* **系統參數**：v = 25 m/s、fc = 26 GHz、fm ≈ 2166.67 Hz。
* **現象觀察**：由於載波頻率大幅提升至毫米波頻段（26 GHz）且車速更快，最大都普勒頻率擴展至 ±2167 Hz 左右。儘管頻率軸範圍放大，其 U 型分佈的統計幾何特徵仍與狀況 (a) 完全一致。

| 狀況 (b) 機率密度函數 (PDF) (圖 3) | 狀況 (b) 累積分佈函數 (CDF) (圖 4) |
| :---: | :---: |
| ![PDF b](doppler_b_pdf.png)<br>*圖 3：v = 90 km/hr、fc = 26 GHz 之模擬 PDF* | ![CDF b](doppler_b_cdf.png)<br>*圖 4：v = 90 km/hr、fc = 26 GHz 之模擬 CDF* |

---

## 4. 狀況 (c)：隨機速度 v ~ Uniform(20, 90) km/hr 之複合分佈解析

* **系統參數**：fc = 2 GHz，v 在 20 ~ 90 km/hr 之間均勻隨機變動。
* **現象觀察**：此情形下的 PDF 實際上是無數個不同最大頻移 fm 的 U 型分佈疊加結果。所有速度的 U 型分佈在 0 Hz 附近皆有重疊，形成中央較高的基底；而隨著頻率向外擴展，僅有高速群能夠到達，因而疊加出**雙峰 M 型（M-shaped）分佈**。

| 狀況 (c) 機率密度函數 (PDF) (圖 5) | 狀況 (c) 累積分佈函數 (CDF) (圖 6) |
| :---: | :---: |
| ![PDF c](doppler_c_pdf.png)<br>*圖 5：v ~ Uniform(20, 90) km/hr 之模擬 PDF* | ![CDF c](doppler_c_cdf.png)<br>*圖 6：v ~ Uniform(20, 90) km/hr 之模擬 CDF* |

---

## 5. (d) 都普勒頻移之理論推導與模擬對比

### 理論推導 (Theoretical Derivation)
給定固定速度 v 與載波頻率 fc，觀察到的都普勒頻移可視為隨機變數 `Y = f_D = f_m * cos(Θ)`，其中入射角 `Θ ~ Uniform(-π, π)`，其 PDF 為：
`p_Θ(θ) = 1 / (2 * π)`, `-π ≤ θ ≤ π`

1. **推導機率密度函數 (PDF)**：
   對於任意 `y ∈ (-f_m, f_m)`，轉換函數 `y = f_m * cos(θ)` 在 `[-π, π]` 內有兩個根：
   `θ_1 = arccos(y / f_m)`, `θ_2 = -arccos(y / f_m)`
   其導數絕對值為 `|dy/dθ| = f_m * |sin(θ)|`。運用隨機變數轉換公式加總兩根貢獻：
   `p_Y(y) = 1 / (π * f_m * sqrt(1 - (y / f_m)^2))`, `-f_m < y < f_m`

2. **推導累積分佈函數 (CDF)**：
   透過對理論 PDF 從下限 `-f_m` 積分至 `y`：
   `F_Y(y) = P(Y ≤ y) = ∫_{-f_m}^{y} 1 / (π * f_m * sqrt(1 - (u / f_m)^2)) du`
   經變數代換 `u = f_m * sin(ϕ)`，可得理論 CDF 表達式：
   `F_Y(y) = 1/2 + 1/π * arcsin(y / f_m)`, `-f_m ≤ y ≤ f_m`

### 模擬與理論對比驗證
將 N = 1,111,111 筆蒙地卡羅模擬數據與上述理論公式進行對比：

| PDF 理論與模擬對比 (圖 7) | CDF 理論與模擬對比 (圖 8) |
| :---: | :---: |
| ![PDF Theory vs Sim](doppler_theory_pdf.png)<br>*圖 7：PDF 模擬結果與理論曲線對比* | ![CDF Theory vs Sim](doppler_theory_cdf.png)<br>*圖 8：CDF 模擬結果與理論曲線對比* |

* **結論**：圖 7 顯示蒙地卡羅模擬產生的 PDF 完美吻合 Jakes 頻譜的經典浴缸形理論曲線（在 ±fm 處劇烈飆升）；圖 8 的經驗累積分佈函數亦與理論 CDF 完全重疊，證明本專案之理論推導與電腦模擬結果高度正確。