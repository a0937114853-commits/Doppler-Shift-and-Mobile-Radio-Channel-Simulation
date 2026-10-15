



%%



%% (a): v = 20 km/hr, fc = 2 GHz
clear;clc;format long g;

N = 1111111;          			% Number of sampling points (samples)
c = 3e8;            			% Speed of light (m/s)
v = 20 * (1000/3600);           % Velocity (m/s)
fc = 2e9;                       % Carrier frequency (Hz)
fm = v * fc / c;                % Maximum Doppler frequency

theta = -pi + 2*pi*rand(N, 1);  % Incidence angle
f_D = fm * cos(theta);          % Doppler shift

% Plot PDF
figure;
histogram(f_D, 50, 'Normalization', 'pdf');
title('(a) PDF: v=20 km/h, fc=2 GHz');
xlabel('Doppler Shift (Hz)'); ylabel('Density');

% Plot CDF
figure;
ecdf(f_D);
title('(a) CDF: v=20 km/h, fc=2 GHz');
xlabel('Doppler Shift (Hz)'); ylabel('Cumulative Probability');






%% (b): v = 90 km/hr, fc = 26 GHz
clear;clc;format long g;

N = 1111111;          			% Number of sampling points (samples)
c = 3e8;            			% Speed of light (m/s)
v = 90 * (1000/3600);   		% Velocity (m/s)
fc = 26e9;              		% Carrier frequency (Hz)
fm = v * fc / c;        		% Maximum Doppler frequency

theta = -pi + 2*pi*rand(N, 1);  % Incidence angle
f_D = fm * cos(theta);          % Doppler shift

% Plot PDF independently
figure;
histogram(f_D, 50, 'Normalization', 'pdf');
title('(b) PDF: v=90 km/h, fc=26 GHz');
xlabel('Doppler Shift (Hz)'); ylabel('Density');

% Plot CDF independently
figure;
ecdf(f_D);
title('(b) CDF: v=90 km/h, fc=26 GHz');
xlabel('Doppler Shift (Hz)'); ylabel('Cumulative Probability');






%% (c): fc = 2 GHz, v ~ Uniform(20, 90) km/hr
clear;clc;format long g;

N = 1111111;          					% Number of sampling points (samples)
c = 3e8;            					% Speed of light (m/s)
fc = 2e9;                               % Carrier frequency (Hz)
v_kmh = 20 + (90 - 20) * rand(N, 1);    % Random velocity (km/hr)
v = v_kmh * (1000/3600);                % Convert to (m/s)
fm = v * fc / c;                        % Maximum Doppler frequency per sample

theta = -pi + 2*pi*rand(N, 1);          % Incidence angle
f_D = fm .* cos(theta);                 % Doppler shift

% Plot PDF
figure;
histogram(f_D, 50, 'Normalization', 'pdf');
title('(c) PDF: v~U(20,90) km/h, fc=2 GHz');
xlabel('Doppler Shift (Hz)'); ylabel('Density');

% Plot CDF
figure;
ecdf(f_D);
title('(c) CDF: v~U(20,90) km/h, fc=2 GHz');
xlabel('Doppler Shift (Hz)'); ylabel('Cumulative Probability');













%% (d) Theoretical vs. Simulation Comparison (PDF & CDF)
clear; clc; format long g;

N = 1111111;
c = 3e8;
v = 20 * (1000/3600);
fc = 2e9;
fm = v * fc / c;

theta = -pi + 2*pi*rand(N, 1);
f_D = fm * cos(theta);

% --- 1. PDF Comparison ---
figure;
% 使用與您截圖相同的直方圖顏色與外觀
histogram(f_D, 60, 'Normalization', 'pdf', ...
    'FaceColor', [0.2, 0.45, 0.7], ...
    'EdgeColor', [0.4, 0.6, 0.8]);
hold on;

% 為了避免理論曲線在兩端發散無限高把圖面撐爆，取樣時稍微避開極端邊界
y = linspace(-fm + 0.01, fm - 0.01, 1000);
pdf_theory = 1 ./ (pi * fm * sqrt(1 - (y./fm).^2));
plot(y, pdf_theory, 'r-', 'LineWidth', 2);

% 自動取得直方圖高度並設定 Y 軸範圍，確保中間的分佈細節清晰可見
h = findobj(gca, 'Type', 'histogram');
max_y = max(h.Values);
ylim([0, max_y * 1.2]);

title('(d) PDF Comparison: Simulation vs. Theory');
xlabel('Doppler Shift (Hz)');
ylabel('Probability Density');
legend('Simulation', 'Theoretical', 'Location', 'north');
grid on;
hold off;
saveas(gcf, 'fig_d_pdf_compare.png');

% --- 2. CDF Comparison ---
figure;
[f_ecdf, x_ecdf] = ecdf(f_D);
plot(x_ecdf, f_ecdf, 'LineWidth', 1.5);
hold on;

y_cdf = linspace(-fm, fm, 1000);
cdf_theory = 0.5 + (1/pi) * asin(y_cdf ./ fm);
plot(y_cdf, cdf_theory, 'r--', 'LineWidth', 2);

title('(d) CDF Comparison: Simulation vs. Theory');
xlabel('Doppler Shift (Hz)');
ylabel('Cumulative Probability');
legend('Simulation', 'Theoretical', 'Location', 'northwest');
grid on;
hold off;
saveas(gcf, 'fig_d_cdf_compare.png');







