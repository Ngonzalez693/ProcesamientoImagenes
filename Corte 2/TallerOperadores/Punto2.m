function imageInterface()

    % Crear la UI
    fig = uifigure('Name', 'Procesamiento de Imágenes', 'Position', [100 100 800 600]);
    btnLoad = uibutton(fig, 'Text', 'Cargar Imagen', 'Position', [50, 550, 100, 30], 'ButtonPushedFcn', @loadImage);
    ax1 = uiaxes(fig, 'Position', [50, 300, 300, 200]);
    ax2 = uiaxes(fig, 'Position', [450, 300, 300, 200]);

    % Cargar la imagen
    function loadImage(~, ~)
        [file, path] = uigetfile({'*.jpg;*.png;*.bmp', 'Imagenes (*.jpg,*.png,*.bmp)'});
        if isequal(file, 0)
            return;
        end
        imagen = imread(fullfile(path, file));
        imGris = rgb2gray(imagen);
        
        % Mostrar imagen original
        imshow(imGris, 'Parent', ax1);
        title(ax1, 'Imagen en Escala de Grises');
        
        % Aplicar la transformación
        umbral1 = 100;
        umbral2 = 180;
        imgOp = transformImage(imGris, umbral1, umbral2);
        imshow(imgOp, 'Parent', ax2);
        title(ax2, 'Imagen Transformada');
    end
end

% Aplicar transformación con el operador
function imgOp = transformImage(imGris, umbral1, umbral2)
    [m, n] = size(imGris);
    imgOp = imGris;
    for i = 1:m
        for j = 1:n
            if (imGris(i, j) < umbral1)
                imgOp(i, j) = 0;

            elseif (imGris(i, j) >= umbral1) && (imGris(i, j) <= umbral2)
                imgOp(i, j) = round(-245 * (double(imGris(i, j)) - umbral1) / (umbral2 - umbral1) + 255);
            
            else
                imgOp(i, j) = 255;
            end
        end
    end
    imgOp = uint8(imgOp);
end
