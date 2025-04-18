function interfaz
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

     % FUNCIÓN para leer la API del clima de la USB
     function actualizarClima(~, ~)
         try
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
                
             set(estMetText, 'String', sprintf('Ruido: %.2f, Radiación Solar: %.2f, Índice UV: %.2f, Temperatura: %.2f, Vel. del Viento: %.2f, Dir. del Viento: %.2f', ...
                        noiseAvg, solarRadiationAvg, uvIndexAvg, temperatureAvg, windSpeedAvg, windDirectionAvg));
                
         catch
            set(estMetText, 'String', 'Error al leer la API');
         end
     end


    % % BOTÓN obtener info de la ISS
    % uicontrol('Style', 'pushbutton', 'String', 'Leer API', ...
    %           'FontSize', 10, 'Position', [760 190 100 20], ...
    %           'Callback', @actualizarUbicacionISS);
    % 
    % % TEXTBOX de latitud y longitud
    % issText = uicontrol('Style', 'text', 'String', 'Lat: -, Lon: -', ...
    %                     'FontSize', 10, 'Position', [760 140 100 40]);
    
    % % FUNCIÓN para leer API de ISS
    % function actualizarUbicacionISS(~, ~)
    %     try
    %         data = webread('http://api.open-notify.org/iss-now.json');
    %         lat = str2double(data.iss_position.latitude);
    %         lon = str2double(data.iss_position.longitude);
    %         set(issText, 'String', sprintf('Lat: %.2f, Lon: %.2f', lat, lon));
    % 
    %         % --- Ajustar umbrales solo si está sobre América del Norte o del Sur ---
    %         if (lat >= -60 && lat <= 70) && (lon >= -170 && lon <= -30)
    %             set(umbral1Slider, 'Value', 50);
    %             set(umbral1Text, 'String', '50');
    %             set(umbral2Slider, 'Value', 150);
    %             set(umbral2Text, 'String', '150');
    %             aplicarOperador();  % aplicar los cambios en la imagen procesada
    %         end
    % 
    %         % --- Agregar marca de agua SIEMPRE al presionar el botón ---
    %         if ~isempty(imgGray)
    %             marca = sprintf('Lat: %.2f, Lon: %.2f', lat, lon);
    %             axes(ax2); imshow(imgGray); title('Grises');
    %             hold on;
    %             text(10, 710, marca, 'Color', 'white', 'FontSize', 7, ...
    %                  'FontWeight', 'bold','Margin', 1);
    %             hold off;
    %         end
    % 
    %     catch
    %          set(issText, 'String', 'Error obteniendo datos');
    %     end
    % end

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
    
    img = [];
    imgGray = []; % Imagen en escala de grises
    cambioOperador(); % Forzar ejecución inicial de configuración del operador
    
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