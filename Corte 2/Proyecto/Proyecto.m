%% Interfaz Gráfica
function interfaz_Clima

    % Variables
    img = [];
    imgGray = []; % Imagen en escala de grises
    climaTexto = []; % Referencia al objeto de texto del clima

    % Variables para el formato del texto
    tamanoFuente = 10;
    colorTextoR = 0;
    colorTextoG = 0;
    colorTextoB = 0;

    %% Elementos Interfaz

    % INTERFAZ
    hFig = figure('Name', 'Cargar Imagen', 'NumberTitle', 'off', ...
                 'Position', [100 100 900 650]);
             
    % BOTÓN cargar imagen
    uicontrol('Style', 'pushbutton', 'String', 'Cargar Imagen', ...
              'FontSize', 10, 'Position', [35 560 100 20], ...
              'Callback', @cargarImagen);

    % BOTÓN equalizar histograma
    uicontrol('Style', 'pushbutton', 'String', 'Equalizar Histograma', ...
              'FontSize', 6, 'Position', [677 505 90 14], ...
              'Callback', @equalizarHistograma);

    % BOTÓN obtener info de la Api
    uicontrol('Style', 'pushbutton', 'String', 'Leer API', ...
              'FontSize', 10, 'Position', [760 190 100 20], ...
              'Callback', @actualizarClima);

    % TEXTBOX de Estación Metereológica
    estMetText = uicontrol('Style', 'text', 'String', 'Ruido: -, Radiación Solar: -, Índice UV: -, Temperatura: -, Vel. del Viento: -, Dir. del Viento: -', ...
                        'FontSize', 8, 'Position', [760 65 100 120]);

    % SLIDER umbral 1
    uicontrol('Style', 'text', 'String', 'Umbral 1', 'Position', [35 470 100 20]);
    umbral1Slider = uicontrol('Style', 'slider', 'Min', 0, 'Max', 255, 'Value', 0, ...
        'Position', [35 450 100 20], 'Callback', @actualizarUmbral1);
    umbral1Text = uicontrol('Style', 'text', 'String', '0', 'Position', [140 450 30 20]);

    % SLIDER umbral 2
    uicontrol('Style', 'text', 'String', 'Umbral 2', 'Position', [35 420 100 20]);
    umbral2Slider = uicontrol('Style', 'slider', 'Min', 0, 'Max', 255, 'Value', 255, ...
        'Position', [35 400 100 20], 'Callback', @actualizarUmbral2);
    umbral2Text = uicontrol('Style', 'text', 'String', '255', 'Position', [140 400 30 20]);

    % TEXTO de mensaje de validación
    mensajeText = uicontrol('Style', 'text', 'String', '', ...
        'FontSize', 9, 'ForegroundColor', 'red', ...
        'Position', [30 355 130 40], 'HorizontalAlignment', 'center');
    
    % MENÚ DESPLEGABLE
    uicontrol('Style', 'text', 'String', 'Seleccionar Operador:', 'Position', [35 310 100 25]);
    operadorMenu = uicontrol('Style', 'popupmenu', ...
        'String', {'Operador Umbral', 'Operador Int. Umbral', 'Operador Int. Umbral Gris', 'Operador Extensión'}, ...
        'Position', [35 270 100 30], ...
        'Callback', @cambioOperador);

    % Slider para tamaño de fuente
    uicontrol('Style', 'text', 'String', 'Tamaño de Fuente:', 'Position', [35 240 100 20]);
    tamanoFuenteSlider = uicontrol('Style', 'slider', 'Min', 8, 'Max', 100, 'Value', tamanoFuente, ...
        'Position', [35 220 100 20], 'Callback', @actualizarTamanoFuente);
    tamanoFuenteText = uicontrol('Style', 'text', 'String', num2str(tamanoFuente), 'Position', [140 220 30 20]);
    
    % Slider para color Rojo
    uicontrol('Style', 'text', 'String', 'R:', 'Position', [35 200 20 20]);
    colorRSlider = uicontrol('Style', 'slider', 'Min', 0, 'Max', 255, 'Value', colorTextoR, ...
        'Position', [55 200 80 20], 'Callback', @actualizarColorR);
    colorRText = uicontrol('Style', 'text', 'String', num2str(colorTextoR), 'Position', [140 200 30 20]);
    
    % Slider para color Verde
    uicontrol('Style', 'text', 'String', 'G:', 'Position', [35 180 20 20]);
    colorGSlider = uicontrol('Style', 'slider', 'Min', 0, 'Max', 255, 'Value', colorTextoG, ...
        'Position', [55 180 80 20], 'Callback', @actualizarColorG);
    colorGText = uicontrol('Style', 'text', 'String', num2str(colorTextoG), 'Position', [140 180 30 20]);
    
    % Slider para color Azul
    uicontrol('Style', 'text', 'String', 'B:', 'Position', [35 160 20 20]);
    colorBSlider = uicontrol('Style', 'slider', 'Min', 0, 'Max', 255, 'Value', colorTextoB, ...
        'Position', [55 160 80 20], 'Callback', @actualizarColorB);
    colorBText = uicontrol('Style', 'text', 'String', num2str(colorTextoB), 'Position', [140 160 30 20]);
    
    % Muestra de color resultante
    colorMuestra = uicontrol('Style', 'frame', 'BackgroundColor', [colorTextoR/255, colorTextoG/255, colorTextoB/255], ...
        'Position', [180 180 30 30]);

    %% Posición de Imágenes

    % POSICIÓN de las imágenes
    ax1 = axes('Parent', hFig, 'Position', [0.25 0.8 0.3 0.15]); % Imagen original (col 2-3, fila 1)
    title(ax1, 'Imagen Original');
    
    ax2 = axes('Parent', hFig, 'Position', [0.225 0.6 0.15 0.15]); % Imagen en escala de grises (col 2, fila 2)
    title(ax2, 'Escala de Grises');
    
    ax3 = axes('Parent', hFig, 'Position', [0.425 0.6 0.15 0.15]); % Canal Rojo (col 3, fila 2)
    title(ax3, 'Canal Rojo');
    
    ax4 = axes('Parent', hFig, 'Position', [0.625 0.6 0.15 0.15]); % Canal Verde (col 4, fila 2)
    title(ax4, 'Canal Verde');
    
    ax5 = axes('Parent', hFig, 'Position', [0.825 0.6 0.15 0.15]); % Canal Azul (col 5, fila 2)
    title(ax5, 'Canal Azul');
    
    ax6 = axes('Parent', hFig, 'Position', [0.225 0.4 0.15 0.15]); % Histograma Escala de Grises
    title(ax6, 'Histograma Escala de Grises');
    
    ax7 = axes('Parent', hFig, 'Position', [0.425 0.4 0.15 0.15]); % Histograma Rojo
    title(ax7, 'Histograma Rojo');
    
    ax8 = axes('Parent', hFig, 'Position', [0.625 0.4 0.15 0.15]); % Histograma Verde
    title(ax8, 'Histograma Verde');
    
    ax9 = axes('Parent', hFig, 'Position', [0.825 0.4 0.15 0.15]); % Histograma Azul
    title(ax9, 'Histograma Azul');
    
    ax10 = axes('Parent', hFig, 'Position', [0.65 0.8 0.3 0.15]); % Imagen Equalizada (col 4-5, fila 1)
    title(ax10, 'Imagen Equalizada');

    ax11 = axes('Parent', hFig, 'Position', [0.4 0.1 0.4 0.20]); % Imagen Procesada
    title(ax11, 'Imagen Procesada');

    cambioOperador(); % Forzar ejecución inicial de configuración del operador

    %% Funciones cargar Imágenes
    
    % FUNCIÓN para cargar la imagen
    function cargarImagen(~, ~)
        [file, path] = uigetfile({'*.jpg;*.png;*.bmp', 'Archivos de Imagen'});
        if isequal(file, 0)
            return;
        end
        img = imread(fullfile(path, file));
        
        % Mostrar la imagen original
        axes(ax1);
        imshow(img);
        title('Imagen Original');
        
        % Convertir a escala de grises y mostrar
        imgGray = rgb2gray(img);
        axes(ax2);
        imshow(imgGray);
        title('Escala de Grises');
        
        % Extraer los canales de color
        redChannel = img;
        redChannel(:, :, [2, 3]) = 0; % Mantener solo el rojo
        
        greenChannel = img;
        greenChannel(:, :, [1, 3]) = 0; % Mantener solo el verde
        
        blueChannel = img;
        blueChannel(:, :, [1, 2]) = 0; % Mantener solo el azul
        
        % Mostrar los canales en color
        axes(ax3);
        imshow(redChannel);
        title('Canal Rojo');
        
        axes(ax4);
        imshow(greenChannel);
        title('Canal Verde');
        
        axes(ax5);
        imshow(blueChannel);
        title('Canal Azul');
        
        % Mostrar histogramas con colores correspondientes
        axes(ax6);
        imhist(imgGray);
        title('Histograma Escala de Grises');
        
        axes(ax7);
        histogram(img(:, :, 1), 'FaceColor', 'r', 'EdgeColor', 'r');
        title('Histograma Rojo');
        
        axes(ax8);
        histogram(img(:, :, 2), 'FaceColor', 'g', 'EdgeColor', 'g');
        title('Histograma Verde');
        
        axes(ax9);
        histogram(img(:, :, 3), 'FaceColor', 'b', 'EdgeColor', 'b');
        title('Histograma Azul');

        % Si había datos de clima, actualizar el texto sobre la imagen
        if ~isempty(climaTexto) && ishandle(climaTexto)
            delete(climaTexto);
            actualizarClima();
        end

    end

    % FUNCIÓN para equalizar el histograma
    function equalizarHistograma(~, ~)
        if isempty(imgGray)
            return;
        end
        imgEq = histeq(imgGray);
        
        % Mostrar la imagen equalizada
        axes(ax10);
        imshow(imgEq);
        title('Imagen Equalizada');
    end

    %% Funciones API Clima
    function actualizarClima(~, ~)
        try
            % Verificar si la imagen está cargada
            if isempty(img)
                return;
            end
            
            url = 'https://apioac22.cali.gov.co/metrics/range_public?deviceId=0703060003';
            options = weboptions('ContentType', 'json', 'Timeout', 10);
            data = webread(url, 'deviceId', '0703060003', options);
            valores = data.values;
            
            noiseAvg = valores.noise.noiseAvg;
            solarRadiationAvg = valores.surth.solarRadiationAvg;
            uvIndexAvg = valores.surth.uvIndexAvg;
            temperatureAvg = valores.surth.temperatureAvg;
            windSpeedAvg = valores.wind.windSpeedAvg;
            windDirectionAvg = valores.wind.windDirectionAvg;

            % Mostrar info abajo en la interfaz
            set(estMetText, 'String', sprintf('Ruido: %.2f, Radiación Solar: %.2f, Índice UV: %.2f, Temperatura: %.2f, Vel. del Viento: %.2f, Dir. del Viento: %.2f', ...
                        noiseAvg, solarRadiationAvg, uvIndexAvg, temperatureAvg, windSpeedAvg, windDirectionAvg));
            
            % Formatear el texto a mostrar
            textoClima = sprintf('Ruido: %.2f\nRadiación Solar: %.2f\nÍndice UV: %.2f\nTemperatura: %.2f\nVel. del Viento: %.2f\nDir. del Viento: %.2f', ...
                noiseAvg, solarRadiationAvg, uvIndexAvg, temperatureAvg, windSpeedAvg, windDirectionAvg);
            
            % Eliminar el texto anterior si existe
            if ~isempty(climaTexto) && ishandle(climaTexto)
                delete(climaTexto);
            end
            
            % Mostrar el texto sobre la imagen original
            axes(ax1);
            hold on;
            % El parámetro x=5 e y=size(img,1)-5 coloca el texto en la esquina inferior izquierda
            % 'VerticalAlignment','bottom' alinea el texto desde abajo
            climaTexto = text(5, size(img,1)-5, textoClima, ...
                'FontSize', tamanoFuente, ...
                'Color', [colorTextoR/255, colorTextoG/255, colorTextoB/255], ...
                'VerticalAlignment', 'bottom', ...
                'BackgroundColor', 'none');  % Sin fondo
            hold off;
            
        catch
            if ~isempty(climaTexto) && ishandle(climaTexto)
                delete(climaTexto);
            end
            axes(ax1);
            hold on;
            climaTexto = text(5, size(img,1)-5, 'Error al leer la API', ...
                'FontSize', tamanoFuente, ...
                'Color', [colorTextoR/255, colorTextoG/255, colorTextoB/255], ...
                'VerticalAlignment', 'bottom', ...
                'BackgroundColor', 'none');
            hold off;
        end
    end

     %% Funciones para sliders de formato de texto
    
    function actualizarTamanoFuente(~, ~)
        tamanoFuente = round(get(tamanoFuenteSlider, 'Value'));
        set(tamanoFuenteText, 'String', num2str(tamanoFuente));
        actualizarFormatoTexto();
    end
    
    function actualizarColorR(~, ~)
        colorTextoR = round(get(colorRSlider, 'Value'));
        set(colorRText, 'String', num2str(colorTextoR));
        set(colorMuestra, 'BackgroundColor', [colorTextoR/255, colorTextoG/255, colorTextoB/255]);
        actualizarFormatoTexto();
    end
    
    function actualizarColorG(~, ~)
        colorTextoG = round(get(colorGSlider, 'Value'));
        set(colorGText, 'String', num2str(colorTextoG));
        set(colorMuestra, 'BackgroundColor', [colorTextoR/255, colorTextoG/255, colorTextoB/255]);
        actualizarFormatoTexto();
    end
    
    function actualizarColorB(~, ~)
        colorTextoB = round(get(colorBSlider, 'Value'));
        set(colorBText, 'String', num2str(colorTextoB));
        set(colorMuestra, 'BackgroundColor', [colorTextoR/255, colorTextoG/255, colorTextoB/255]);
        actualizarFormatoTexto();
    end
    
    function actualizarFormatoTexto()
        if ~isempty(climaTexto) && ishandle(climaTexto)
            set(climaTexto, 'FontSize', tamanoFuente, 'Color', [colorTextoR/255, colorTextoG/255, colorTextoB/255]);
        end
    end

    %% Funciones Operadores

    % FUNCIÓN para aplicar los operadores
    function aplicarOperador(~, ~)
        if isempty(imgGray)
            return;
        end
        umbral1 = round(get(umbral1Slider, 'Value'));
        umbral2 = round(get(umbral2Slider, 'Value'));
        operadorSeleccionado = get(operadorMenu, 'Value');
        
        switch operadorSeleccionado
            case 1 % Operador Umbral
                imgProcesada = imgGray > umbral1;
            case 2 % Operador Int. Umbral
                imgProcesada = (imgGray > umbral1) & (imgGray < umbral2);
            case 3 % Operador Int. Umbral Gris
                imgProcesada = imgGray;
                imgProcesada(imgProcesada < umbral1 | imgProcesada > umbral2) = 0;
            case 4 % Operador Extensión
                imgProcesada = imadjust(imgGray, [double(umbral1)/255 double(umbral2)/255], [0 1]);
        end
        axes(ax11); imshow(imgProcesada); title('Imagen Procesada');
    end
    
    % FUNCIÓN para actualizar el cambio de operador
    function cambioOperador(~, ~)
        operadorSeleccionado = get(operadorMenu, 'Value');
        
        if operadorSeleccionado == 1  % Operador Umbral
            set(umbral2Slider, 'Enable', 'off');
            set(umbral2Slider, 'Value', 255);
            set(umbral2Text, 'String', '255');
            set(mensajeText, 'String', '');
        else
            set(umbral2Slider, 'Enable', 'on');
        end
        
        aplicarOperador();  % Aplicar inmediatamente
    end
    
    % FUNCIÓN para el slider 1
    function actualizarUmbral1(~, ~)
        val1 = round(get(umbral1Slider, 'Value'));
        val2 = round(get(umbral2Slider, 'Value'));
        if val1 > val2
            val1 = val2;
            set(umbral1Slider, 'Value', val1);
            set(mensajeText, 'String', 'El umbral 1 debe ser menor al umbral 2');
        else
            set(mensajeText, 'String', '');
        end
        set(umbral1Text, 'String', num2str(val1));
        aplicarOperador();
    end

    % FUNCIÓN para el slider 2
    function actualizarUmbral2(~, ~)
        val1 = round(get(umbral1Slider, 'Value'));
        val2 = round(get(umbral2Slider, 'Value'));
        if val2 < val1
            val2 = val1;
            set(umbral2Slider, 'Value', val2);
            set(mensajeText, 'String', 'El umbral 2 debe ser mayor al umbral 1');
        else
            set(mensajeText, 'String', '');
        end
        set(umbral2Text, 'String', num2str(val2));
        aplicarOperador();
    end

end