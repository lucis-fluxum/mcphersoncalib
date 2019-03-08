clc; clf; clear;

center = 115;
scale = 0.114;
data = double(readSPE(['300_groove_neon_spectra/', num2str(center), '.spe']));
plot(scale*(1:512), data);
xlim([scale, scale*512]);

known_peaks = [650.652, 653.288, 659.895, 667.828, 671.704, 692.947, 703.2410];

[peaks, locs] = findpeaks(data, 'MinPeakHeight', 1200);
hold on
plot(scale*locs, peaks, 'rx');

locs = locs(end-length(known_peaks)+1:end);
peaks = peaks(end-length(known_peaks)+1:end);

fit_coeffs = polyfit(locs, known_peaks, 1)
fit = @(pixels) polyval(fit_coeffs, pixels);
percent_error = (known_peaks - fit(locs))./known_peaks * 100

hold off
plot(fit(1:512), data);
xlim([fit(1), fit(512)]);
hold on
plot(fit(locs), peaks, 'rx');