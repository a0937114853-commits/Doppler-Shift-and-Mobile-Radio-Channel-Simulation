
# Wireless Communications - Doppler Shift Analysis & Simulation

本專案探討無線行動通訊系統中的通道效應（Propagation Effects），涵蓋行動台（MS）在不同移動速度與載波頻率下之都普勒頻移（Doppler Shift）理論推導、統計模擬，以及隨機速度分佈下的複合頻譜特性分析。

---

## 📋 作業規格與參數 (Homework Specifications)
- **課程作業**：Wireless Communications Homework II (Dr. Tsai, NTHU)
- **學生資訊**：112021117 詹朝陽 (Chao-Yang Zhan)
- **核心主題**：Doppler Shift 分佈、PDF 與 CDF 統計模擬、古典都普勒頻譜解析
- **模擬系統參數**：
  * **狀況 (a)**：v = 20 km/hr、fc = 2 GHz（最大都普勒頻率 fm ≈ 37 Hz）
  * **狀況 (b)**：v = 90 km/hr、fc = 26 GHz（最大都普勒頻率 fm ≈ 2167 Hz）
  * **狀況 (c)**：fc = 2 GHz，v 在 20 ~ 90 km/hr 之間呈均勻分佈 (Uniform)
  * **來波入射角 (θ)**：假設在 [-π, π] 之間均勻分佈

---

## 1. 都普勒頻移理論與模擬架構
- **核心公式**：
  * 都普勒頻移：f_D = f_m * cos(θ)
  * 最大都普勒頻率：f_m = v / λ_c = (v * f_c) / c
- **模擬方法**：採用蒙地卡羅模擬（Monte Carlo Simulation），透過 MATLAB 隨機生成大量的入射角 θ 與速度 v 樣本，代入公式計算觀測到的都普勒頻移數值，並利用統計直方圖與經驗累積函數繪製出 PDF 與 CDF。

| 狀況 | 速度 (v) | 載波頻率 (fc) | 最大都普勒頻率 (fm) | 預期分佈樣貌 |
| :---: | :---: | :---: | :---: | :---: |
| **(a)** | 20 km/hr | 2 GHz | ≈ 37 Hz | 經典 U 型頻譜 (U-shaped PDF) |
| **(b)** | 90 km/hr | 26 GHz | ≈ 2167 Hz | 經典 U 型頻譜 (U-shaped PDF) |
| **(c)** | 20 ~ 90 km/hr (均勻分佈) | 2 GHz | 變動範圍 (37 ~ 167 Hz) | 複合疊加 M 型雙峰分佈 |

---

## 2. 模擬結果與圖形分析

### 📊 模擬圖表
下圖為 MATLAB 執行後產生的 PDF 與 CDF 統計對比結果：

![Doppler Shift Simulation](image_8db135.png)

### 🔍 現象深度解析：
1. **固定速度之 U 型頻譜 (a) 與 (b)**：
   * 當速度與載波頻率固定時，PDF 呈現典型的 **U 型分佈（U-shaped spectrum）**。這是因為 cos(θ) 在 θ = 0 與 π 附近的斜率較平緩，導致都普勒頻移容易集中在極值邊界（±f_m），使兩端出現蝴蝶結式的尖峰。
   * 狀況 (b) 因頻率高達 26 GHz 且速度較快，其頻移範圍擴大至 ±2167 Hz，但整體分佈機率曲線的數學特徵與 (a) 完全一致。
2. **隨機速度之 M 型雙峰分佈 (c)**：
   * 在 (c) 小題中，速度 v 隨機分佈在 20 ~ 90 km/hr 之間。這使得整體的 PDF 實際上是**無數個不同寬度的 U 型分佈疊加**的結果。
   * **中間高、兩邊呈現雙峰（M 型）的原因**：所有不同速度的 U 型分佈在 0 Hz 附近都有重疊累積，因此中間機率密度最高；而隨著頻率向外擴展，只有高速群能夠到達，疊加後在次外側形成兩個凸起的次要尖峰，最終呈現山形雙峰特徵。

---

## 3. MATLAB 程式架構與實現
- 程式透過向量化運算（Vectorization），同時生成大量隨機樣本進行平行計算，大幅提升模擬效率。
- 使用 `histogram(..., 'Normalization', 'pdf')` 與 `ecdf(...)` 確保 PDF 總面積為 1 且 CDF 具備正確的累積機率遞增特性。