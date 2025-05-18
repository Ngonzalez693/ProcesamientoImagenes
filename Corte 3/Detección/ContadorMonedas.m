clc; clear; close all;

% Leer imagen
rgb = imread('Monedas.png');
imshow(rgb);
title('Dibuja el diámetro de una moneda con el mouse');

% Dibuja línea sobre una moneda de referencia
linea = drawline;
pos = linea.Position;
diametro = sqrt((pos(1,1) - pos(2,1))^2 + (pos(1,2) - pos(2,2))^2);
radioReferencia = diametro / 2;

% Rango de búsqueda automático con tolerancia
rMin = round(radioReferencia * 0.6);
rMax = round(radioReferencia * 1.4);

% Preprocesamiento
gray = rgb2gray(rgb);
gray = imadjust(gray); % Mejora contraste
gray = medfilt2(gray, [3 3]); % Reducción de ruido

% Detección de monedas
[centers, radii] = imfindcircles(gray, [rMin rMax], ...
    'ObjectPolarity', 'dark', ...
    'Sensitivity', 0.96, ...
    'EdgeThreshold', 0.1);

% Mostrar resultados visuales
imshow(rgb); hold on;
viscircles(centers, radii, 'EdgeColor', 'g');
title(sprintf('Monedas detectadas: %d', length(centers)));

% === CLASIFICACIÓN Y RESUMEN (adaptado de quiz3.m) ===

% Definir tipologías de moneda según radio (en px)
coinTypes = [ ...
    struct('name','Maple Leaf','minR',30,'maxR',38,'value',50,'currency','CAD'), ...
    struct('name','Philharmoniker','minR',42,'maxR',50,'value',100,'currency','EUR'), ...
    struct('name','Silver Eagle','minR',25,'maxR',30,'value',1,'currency','USD'), ...
    struct('name','50 EUR Silver','minR',38,'maxR',46,'value',50,'currency','EUR') ...
];

for k = 1:numel(coinTypes)
    coinTypes(k).count = 0;
    coinTypes(k).totalValue = 0;
end

% Clasificar cada detección
for i = 1:numel(radii)
    r = radii(i);
    for k = 1:numel(coinTypes)
        if r >= coinTypes(k).minR && r <= coinTypes(k).maxR
            coinTypes(k).count = coinTypes(k).count + 1;
            coinTypes(k).totalValue = coinTypes(k).totalValue + coinTypes(k).value;
            break
        end
    end
end

% Imprimir resultados por consola
fprintf('\n=== Resultados de detección ===\n');
fprintf('Total monedas detectadas: %d\n\n', numel(radii));
for k = 1:numel(coinTypes)
    fprintf('%s: %2d unidades → Valor total: %d %s\n', ...
        coinTypes(k).name, ...
        coinTypes(k).count, ...
        coinTypes(k).totalValue, ...
        coinTypes(k).currency);
end
