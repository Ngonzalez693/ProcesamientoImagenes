%% Interfaz Gráfica
function interfaz_Clima

    % Variables
    img = [];
    imgGray = []; % Imagen en escala de grises
    climaTexto = []; % Referencia al objeto de texto del clima

    % Variables para el formato del texto
    tamanoFuente = 4;
    colorTextoR = 0;
    colorTextoG = 0;
    colorTextoB = 0;

    manualMode = false; % Modo manual
    temperatureAvg = 0; % Inicializar la temperatura

    %% Elementos Interfaz

    % INTERFAZ
    hFig = figure('Name', 'Interfaz', 'NumberTitle', 'off', ...
                 'Position', [100 100 1200 650]);
             
    % BOTÓN cargar imagen
    uicontrol('Style', 'pushbutton', 'String', 'Cargar Imagen', ...
              'FontSize', 10, 'Position', [85 560 100 20], ...
              'Callback', @cargarImagen);

    % Switch para modo manual
    manualSwitch = uicontrol('Style', 'togglebutton', 'String', 'Modo Manual', ...
                              'FontSize', 8, 'Position', [85 530 100 20], ...
                              'Callback', @toggleManualMode, ...
                              'Value', manualMode);

    % BOTÓN descargar imagen
    uicontrol('Style', 'pushbutton', 'String', 'Descargar Imagen', ...
              'FontSize', 8, 'Position', [85 500 100 20], ...
              'Callback', @descargarImagen);

    % BOTÓN equalizar histograma
    uicontrol('Style', 'pushbutton', 'String', 'Equalizar Histograma', ...
              'FontSize', 6, 'Position', [912 435 100 14], ...
              'Callback', @equalizarHistograma);

    % BOTÓN obtener info de la Api
    uicontrol('Style', 'pushbutton', 'String', 'Leer API', ...
              'FontSize', 10, 'Position', [1030 130 100 20], ...
              'Callback', @actualizarClima);

    % TEXTBOX de Estación Metereológica
    estMetText = uicontrol('Style', 'text', 'String', '', 'FontSize', 8, ...
                           'Position', [1020 5 120 120]);

    % SLIDER umbral 1
    uicontrol('Style', 'text', 'String', 'Umbral 1', 'Position', [85 420 100 20]);
    umbral1Slider = uicontrol('Style', 'slider', 'Min', 0, 'Max', 255, 'Value', 0, ...
        'Position', [85 400 100 20], 'Callback', @actualizarUmbral1);
    umbral1Text = uicontrol('Style', 'text', 'String', '0', 'Position', [190 397 30 20]);

    % SLIDER umbral 2
    uicontrol('Style', 'text', 'String', 'Umbral 2', 'Position', [85 370 100 20]);
    umbral2Slider = uicontrol('Style', 'slider', 'Min', 0, 'Max', 255, 'Value', 255, ...
        'Position', [85 350 100 20], 'Callback', @actualizarUmbral2);
    umbral2Text = uicontrol('Style', 'text', 'String', '255', 'Position', [190 347 30 20]);

    % TEXTO de mensaje de validación
    mensajeText = uicontrol('Style', 'text', 'String', '', ...
        'FontSize', 9, 'ForegroundColor', 'red', ...
        'Position', [80 305 130 40], 'HorizontalAlignment', 'center');
    
    % MENÚ DESPLEGABLE
    uicontrol('Style', 'text', 'String', 'Seleccionar Operador:', 'Position', [85 260 100 25]);
    operadorMenu = uicontrol('Style', 'popupmenu', ...
        'String', {'Operador Umbral', 'Operador Int. Umbral', 'Operador Int. Umbral Gris', 'Operador Extensión'}, ...
        'Position', [85 220 100 30], ...
        'Callback', @cambioOperador);

    % Slider para tamaño de fuente
    uicontrol('Style', 'text', 'String', 'Tamaño de Fuente:', 'Position', [105 130 100 20]);
    tamanoFuenteSlider = uicontrol('Style', 'slider', 'Min', 0, 'Max', 100, 'Value', tamanoFuente, ...
        'Position', [80 120 150 15], 'Callback', @actualizarTamanoFuente);
    tamanoFuenteText = uicontrol('Style', 'text', 'String', num2str(tamanoFuente), 'Position', [235 115 30 20]);
    
    % Slider para color Rojo
    uicontrol('Style', 'text', 'String', 'R:', 'Position', [60 85 20 20]);
    colorRSlider = uicontrol('Style', 'slider', 'Min', 0, 'Max', 255, 'Value', colorTextoR, ...
        'Position', [80 90 150 15], 'Callback', @actualizarColorR);
    colorRText = uicontrol('Style', 'text', 'String', num2str(colorTextoR), 'Position', [235 85 30 20]);
    
    % Slider para color Verde
    uicontrol('Style', 'text', 'String', 'G:', 'Position', [60 55 20 20]);
    colorGSlider = uicontrol('Style', 'slider', 'Min', 0, 'Max', 255, 'Value', colorTextoG, ...
        'Position', [80 60 150 15], 'Callback', @actualizarColorG);
    colorGText = uicontrol('Style', 'text', 'String', num2str(colorTextoG), 'Position', [235 55 30 20]);
    
    % Slider para color Azul
    uicontrol('Style', 'text', 'String', 'B:', 'Position', [60 25 20 20]);
    colorBSlider = uicontrol('Style', 'slider', 'Min', 0, 'Max', 255, 'Value', colorTextoB, ...
        'Position', [80 30 150 15], 'Callback', @actualizarColorB);
    colorBText = uicontrol('Style', 'text', 'String', num2str(colorTextoB), 'Position', [235 25 30 20]);
    
    % Muestra de color resultante
    colorMuestra = uicontrol('Style', 'frame', 'BackgroundColor', [colorTextoR/255, colorTextoG/255, colorTextoB/255], ...
        'Position', [270 40 55 55]);

    %% Posición de Imágenes

    % POSICIÓN de las imágenes
    ax1 = axes('Parent', hFig, 'Position', [0.225 0.7 0.35 0.25]); % Imagen original (col 2-3, fila 1)
    title(ax1, 'Imagen Original');
    
    ax2 = axes('Parent', hFig, 'Position', [0.225 0.5 0.15 0.15]); % Imagen en escala de grises (col 2, fila 2)
    title(ax2, 'Escala de Grises');
    
    ax3 = axes('Parent', hFig, 'Position', [0.425 0.5 0.15 0.15]); % Canal Rojo (col 3, fila 2)
    title(ax3, 'Canal Rojo');
    
    ax4 = axes('Parent', hFig, 'Position', [0.625 0.5 0.15 0.15]); % Canal Verde (col 4, fila 2)
    title(ax4, 'Canal Verde');
    
    ax5 = axes('Parent', hFig, 'Position', [0.825 0.5 0.15 0.15]); % Canal Azul (col 5, fila 2)
    title(ax5, 'Canal Azul');
    
    ax6 = axes('Parent', hFig, 'Position', [0.225 0.3 0.15 0.15]); % Histograma Escala de Grises
    title(ax6, 'Histograma Escala de Grises');
    
    ax7 = axes('Parent', hFig, 'Position', [0.425 0.3 0.15 0.15]); % Histograma Rojo
    title(ax7, 'Histograma Rojo');
    
    ax8 = axes('Parent', hFig, 'Position', [0.625 0.3 0.15 0.15]); % Histograma Verde
    title(ax8, 'Histograma Verde');
    
    ax9 = axes('Parent', hFig, 'Position', [0.825 0.3 0.15 0.15]); % Histograma Azul
    title(ax9, 'Histograma Azul');
    
    ax10 = axes('Parent', hFig, 'Position', [0.625 0.7 0.35 0.25]); % Imagen Equalizada (col 4-5, fila 1)
    title(ax10, 'Imagen Equalizada');

    ax11 = axes('Parent', hFig, 'Position', [0.4 0.03 0.4 0.20]); % Imagen Procesada
    title(ax11, 'Imagen Procesada');

    cambioOperador(); % Forzar ejecución inicial de configuración del operador
    toggleManualMode(); % Forzar primera actualización del estado

    %% Funciones Imágenes
    
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

    % FUNCIÓN descargar imagen
    function descargarImagen(~, ~)
        % Verifica si la imagen original (img) existe y si la función actualizarClima ha sido ejecutada
        if ~isempty(img) && ~isempty(climaTexto)
            % Crear una copia de la imagen original
            imgFinal = img;
            
            % Obtener el texto del clima
            textoInfo = get(climaTexto, 'String');
            colorTexto = [colorTextoR/255, colorTextoG/255, colorTextoB/255];
            
            % Crear una figura temporal fuera de pantalla
            tempFig = figure('Visible', 'off');
            imshow(imgFinal);
            hold on;
            text(5, size(imgFinal,1)-5, textoInfo, ...
                'FontSize', tamanoFuente*2, ... % Aumentar el tamaño de la fuente
                'Color', colorTexto, ...
                'VerticalAlignment', 'bottom');
            hold off;
            
            % Capturar la imagen con el texto
            frame = getframe(gca);
            imgConTexto = frame.cdata;
            close(tempFig);
            
            % Abre un cuadro de diálogo para que el usuario elija dónde guardar la imagen
            [file, path] = uiputfile({'*.png';'*.jpg';'*.bmp'}, 'Guardar Imagen con Info', 'imagen_con_info.jpg');
            
            % Verifica si se seleccionó un archivo y una ruta
            if ~isequal(file, 0)
                imwrite(imgConTexto, fullfile(path, file));
            end
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
            humidityAvg = valores.surth.humidityAvg;
            windSpeedAvg = valores.wind.windSpeedAvg;
            windDirectionAvg = valores.wind.windDirectionAvg;

            % Formato del texto a en la imagen
            textoClima = sprintf('Ruido: %.2f, Radiación Solar: %.2f, \nÍndice UV: %.2f, Temperatura: %.2f, \nHumidity: %.2f, Vel. del Viento: %.2f, \nDir. del Viento: %.2f', ...
                noiseAvg, solarRadiationAvg, uvIndexAvg, temperatureAvg, humidityAvg, windSpeedAvg, windDirectionAvg);
            
            % Formato del texto en interfaz
            textoIntClima = sprintf('Ruido: %.2f\nRadiación Solar: %.2f\nÍndice UV: %.2f\nTemperatura: %.2f\nHumidity: %.2f\nVel. del Viento: %.2f\nDir. del Viento: %.2f', ...
                noiseAvg, solarRadiationAvg, uvIndexAvg, temperatureAvg, humidityAvg, windSpeedAvg, windDirectionAvg);

            % Mostrar info abajo en la interfaz
            set(estMetText, 'String', textoIntClima);

            % Eliminar el texto anterior si existe
            if ~isempty(climaTexto) && ishandle(climaTexto)
                delete(climaTexto);
            end
            
            % Mostrar el texto sobre la imagen original
            axes(ax1);
            hold on;
            climaTexto = text(5, size(img,1)-5, textoClima, ...
                'FontSize', tamanoFuente, ...
                'Color', [colorTextoR/255, colorTextoG/255, colorTextoB/255], ...
                'VerticalAlignment', 'bottom', ...
                'BackgroundColor', 'none');
            hold off;

            % Ajustar sliders según la temperatura, solo ajustar si NO está en modo manual
            if ~manualMode
                ajustarPorTemperatura(temperatureAvg);
            end
            
        catch
            if ~isempty(climaTexto) && all(ishandle(climaTexto))
                delete(climaTexto);
                set(estMetText, 'String', 'Error al leer la API');
            end
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

    %% Funciones adicionales
 
     % FUNCIÓN para el Switch de modo manual
    function toggleManualMode(~, ~)
        manualMode = get(manualSwitch, 'Value');
        
        % Actualizar etiqueta del botón
        if manualMode
            set(manualSwitch, 'String', 'Modo Automático');
        else
            set(manualSwitch, 'String', 'Modo Manual');
        end
        
        if manualMode
            set(colorRSlider, 'Enable', 'on');
            set(colorGSlider, 'Enable', 'on');
            set(colorBSlider, 'Enable', 'on');
        else
            set(colorRSlider, 'Enable', 'off');
            set(colorGSlider, 'Enable', 'off');
            set(colorBSlider, 'Enable', 'off');
            actualizarClima();
        end
    end

     
     % FUNCIÓN para ajustar los sliders y el operador según la temperatura
     function ajustarPorTemperatura(temperature)
         if temperature > 24
             % Opción 1: Amarillo intenso
             set(colorRSlider, 'Value', 255);
             set(colorGSlider, 'Value', 176);
             set(colorBSlider, 'Value', 39);
             actualizarColorR();
             actualizarColorG();
             actualizarColorB();
              
             set(operadorMenu, 'Value', 4); % Operador Extensión
             cambioOperador();
             set(umbral1Slider, 'Value', 0);
             set(umbral2Slider, 'Value', 1);
             actualizarUmbral1();
             actualizarUmbral2();
      
         elseif temperature >= 20 && temperature <= 23
             % Opción 2: Azul del cielo
             set(colorRSlider, 'Value', 135);
             set(colorGSlider, 'Value', 206);
             set(colorBSlider, 'Value', 235);
             actualizarColorR();
             actualizarColorG();
             actualizarColorB();
              
             set(operadorMenu, 'Value', 4); % Operador Extensión
             cambioOperador();
             set(umbral1Slider, 'Value', 80);
             set(umbral2Slider, 'Value', 120);
             actualizarUmbral1();
             actualizarUmbral2();
      
         else
             % Opción 3: Gris frío
             set(colorRSlider, 'Value', 130);
             set(colorGSlider, 'Value', 161);
             set(colorBSlider, 'Value', 177); 
             actualizarColorR();
             actualizarColorG();
             actualizarColorB();
              
             set(operadorMenu, 'Value', 4); % Operador Extensión
             cambioOperador();
             set(umbral1Slider, 'Value', 254);
             set(umbral2Slider, 'Value', 255);
             actualizarUmbral1();
             actualizarUmbral2();
         end
     end

end