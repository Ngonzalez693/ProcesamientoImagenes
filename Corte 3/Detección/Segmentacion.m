function interfaz_final_segmentacion()
    %% ---------- CONFIGURACIÓN INICIAL ----------
    % Constantes y parámetros de configuración
    CONFIG.DEFAULT_AREA_MIN = 800;
    CONFIG.DEFAULT_COLOR = [1 0 0]; % Rojo
    CONFIG.DEFAULT_FORMA = 'Todos';
    CONFIG.DEFAULT_OPERACION_MORFOLOGICA = 'Cierre';
    CONFIG.DEFAULT_TAMANO_ELEMENTO = 3;

    %% ---------- CARGA DE IMAGEN ----------
    RGB = imread('pillsetc.png');
    I = rgb2gray(RGB);
    bwBase = imbinarize(I);
    
    %% ---------- INTERFAZ GRÁFICA DE USUARIO ----------
    % Figura principal con tamaño optimizado
    fig = uifigure('Name', 'Segmentación Inteligente de Objetos', ...
                   'Position', [50 50 1300 750], ...
                   'Color', [0.94 0.94 0.94]);
    
    % Organización en paneles para mejor estructura
    panelImagen = uipanel(fig, 'Title', 'Visualización', ...
                         'Position', [10 10 850 730], ...
                         'BackgroundColor', [0.96 0.96 0.96]);
    
    panelControl = uipanel(fig, 'Title', 'Controles', ...
                          'Position', [870 10 420 730], ...
                          'BackgroundColor', [0.96 0.96 0.96]);
    
    % Panel imagen original
    axOrig = uiaxes(panelImagen, 'Position', [20 420 400 290]);
    title(axOrig, 'Imagen Original');
    imshow(RGB, 'Parent', axOrig);
    
    % Panel imagen procesada
    axSeg = uiaxes(panelImagen, 'Position', [20 20 810 380]);
    title(axSeg, 'Imagen Segmentada');
    
    %% ---------- VARIABLES GLOBALES ----------
    estado = struct();
    estado.areaMin = CONFIG.DEFAULT_AREA_MIN;
    estado.color = CONFIG.DEFAULT_COLOR;
    estado.forma = CONFIG.DEFAULT_FORMA;
    estado.opMorfologica = CONFIG.DEFAULT_OPERACION_MORFOLOGICA;
    estado.tamanoElemento = CONFIG.DEFAULT_TAMANO_ELEMENTO;
    
    %% ---------- PANEL DE PROCESAMIENTO ----------
    % Grupo: Filtrado de objetos
    grupoFiltrado = uipanel(panelControl, 'Title', 'Filtrado de Objetos', ...
                           'Position', [20 560 380 150]);
    
    % Área mínima
    uilabel(grupoFiltrado, 'Text', 'Área mínima (px):', ...
           'Position', [20 100 150 20]);
    sliderArea = uislider(grupoFiltrado, 'Limits', [100 10000], ...
                         'Value', estado.areaMin, ...
                         'Position', [20 80 340 3], ...
                         'ValueChangedFcn', @(src,event) actualizar());
    areaValueLabel = uilabel(grupoFiltrado, 'Text', num2str(estado.areaMin), ...
                            'Position', [360 100 50 20]);
    
    % Operaciones morfológicas
    uilabel(grupoFiltrado, 'Text', 'Operación morfológica:', ...
           'Position', [20 50 150 20]);
    opMorfDrop = uidropdown(grupoFiltrado, 'Items', {'Ninguna', 'Cierre', 'Apertura', 'Dilatación', 'Erosión'}, ...
                           'Value', estado.opMorfologica, ...
                           'Position', [180 50 180 22], ...
                           'ValueChangedFcn', @(src,event) actualizar());
    
    % Tamaño del elemento estructurante
    uilabel(grupoFiltrado, 'Text', 'Tamaño del elemento:', ...
           'Position', [20 20 150 20]);
    sliderElemento = uislider(grupoFiltrado, 'Limits', [1 15], ...
                             'Value', estado.tamanoElemento, ...
                             'Position', [180 20 180 3], ...
                             'ValueChangedFcn', @(src,event) actualizar());
    elementoValueLabel = uilabel(grupoFiltrado, 'Text', num2str(estado.tamanoElemento), ...
                                'Position', [360 20 50 20]);
    
    %% ---------- PANEL DE VISUALIZACIÓN ----------
    % Grupo: Opciones de visualización
    grupoVisualizacion = uipanel(panelControl, 'Title', 'Visualización', ...
                                'Position', [20 300 380 240]);
    
    % Selector de color
    colorPreview = uipanel(grupoVisualizacion, 'Title', 'Color Contorno', ...
                          'Position', [20 120 340 100], ...
                          'BackgroundColor', estado.color);
    
    rSlider = uislider(grupoVisualizacion, 'Limits', [0 1], 'Value', estado.color(1), ...
                      'Position', [80 190 280 3], ...
                      'ValueChangedFcn', @(src,event) actualizar());
    uilabel(grupoVisualizacion, 'Text', 'Rojo:', ...
           'Position', [20 190 50 20]);
    
    gSlider = uislider(grupoVisualizacion, 'Limits', [0 1], 'Value', estado.color(2), ...
                      'Position', [80 160 280 3], ...
                      'ValueChangedFcn', @(src,event) actualizar());
    uilabel(grupoVisualizacion, 'Text', 'Verde:', ...
           'Position', [20 160 50 20]);
    
    bSlider = uislider(grupoVisualizacion, 'Limits', [0 1], 'Value', estado.color(3), ...
                      'Position', [80 130 280 3], ...
                      'ValueChangedFcn', @(src,event) actualizar());
    uilabel(grupoVisualizacion, 'Text', 'Azul:', ...
           'Position', [20 130 50 20]);
    
    % Selector de forma geométrica
    uilabel(grupoVisualizacion, 'Text', 'Forma de contorno:', ...
           'Position', [20 80 150 20]);
    formaDrop = uidropdown(grupoVisualizacion, ...
                          'Items', {'Contorno', 'Rectángulo', 'Círculo', 'Todos'}, ...
                          'Value', estado.forma, ...
                          'Position', [20 50 340 25], ...
                          'ValueChangedFcn', @(src,event) actualizar());
    
    % Grupo: Información y acciones
    grupoAcciones = uipanel(panelControl, 'Title', 'Información y Acciones', ...
                           'Position', [20 20 380 260]);
    
    % Conteo de objetos
    countLabel = uilabel(grupoAcciones, ...
                        'Text', 'Objetos detectados: 0', ...
                        'Position', [20 200 340 30], ...
                        'FontSize', 16, 'FontWeight', 'bold');
    
    % Info adicional
    infoLabel = uilabel(grupoAcciones, ...
                       'Text', 'Procesamiento listo', ...
                       'Position', [20 170 340 20]);
    
    % Botones de acción
    uibutton(grupoAcciones, 'Text', 'Guardar Imagen', ...
            'Position', [20 130 160 30], ...
            'FontWeight', 'bold', ...
            'BackgroundColor', [0.8 0.9 1], ...
            'ButtonPushedFcn', @(btn,event) guardarImagen());
    
    uibutton(grupoAcciones, 'Text', 'Restaurar Valores', ...
            'Position', [200 130 160 30], ...
            'BackgroundColor', [1 0.9 0.8], ...
            'ButtonPushedFcn', @(btn,event) restaurar());
    
    % Histograma de áreas
    axHist = uiaxes(grupoAcciones, 'Position', [20 20 340 90]);
    title(axHist, 'Distribución de Áreas');
    
    %% -------- ACTUALIZAR PROCESAMIENTO --------
    function actualizar()
        % Leer estado actual
        estado.areaMin = round(sliderArea.Value);
        estado.color = [rSlider.Value, gSlider.Value, bSlider.Value];
        estado.forma = formaDrop.Value;
        estado.opMorfologica = opMorfDrop.Value;
        estado.tamanoElemento = round(sliderElemento.Value);
        
        % Actualizar etiquetas con valores actuales
        areaValueLabel.Text = num2str(estado.areaMin);
        elementoValueLabel.Text = num2str(estado.tamanoElemento);
        colorPreview.BackgroundColor = estado.color;
        
        % Procesamiento mejorado de la imagen
        % Invertir imagen si es necesario (para objetos claros en fondo oscuro)
        bw = bwBase;  
        
        % Aplicar operaciones morfológicas según la selección
        switch estado.opMorfologica
            case 'Cierre'
                bw = imclose(bw, strel('disk', estado.tamanoElemento));
            case 'Apertura'
                bw = imopen(bw, strel('disk', estado.tamanoElemento));
            case 'Dilatación'
                bw = imdilate(bw, strel('disk', estado.tamanoElemento));
            case 'Erosión'
                bw = imerode(bw, strel('disk', estado.tamanoElemento));
            case 'Ninguna'
                % No aplicar ninguna operación
        end
        
        % Filtrado por área mínima más agresivo
        bw = bwareaopen(bw, estado.areaMin);
        
        % Rellenar huecos para capturar objetos completos
        bw = imfill(bw, 'holes');
        
        % Refinar bordes con operaciones adicionales
        bw = imclose(bw, strel('disk', 2));
        
        % Etiquetar objetos
        [B, L, n] = bwboundaries(bw, 'noholes');
        stats = regionprops(L, 'BoundingBox', 'Centroid', 'EquivDiameter', 'Area');
        
        % Mostrar imagen segmentada
        imshow(label2rgb(L, @jet, [.5 .5 .5]), 'Parent', axSeg);
        hold(axSeg, 'on');
        
        % Dibujar contornos según la forma seleccionada
        for k = 1:length(B)
            boundary = B{k};
            centroid = stats(k).Centroid;
            box = stats(k).BoundingBox;
            radius = stats(k).EquivDiameter / 2;
            
            switch estado.forma
                case 'Contorno'
                    plot(axSeg, boundary(:,2), boundary(:,1), 'Color', estado.color, 'LineWidth', 2);
                case 'Rectángulo'
                    rectangle(axSeg, 'Position', box, 'EdgeColor', estado.color, 'LineWidth', 2);
                case 'Círculo'
                    viscircles(axSeg, centroid, radius, 'Color', estado.color, 'LineWidth', 1.5);
                case 'Todos'
                    plot(axSeg, boundary(:,2), boundary(:,1), 'Color', estado.color, 'LineWidth', 1.5);
                    rectangle(axSeg, 'Position', box, 'EdgeColor', estado.color, 'LineWidth', 1);
                    viscircles(axSeg, centroid, radius, 'Color', estado.color, 'LineWidth', 0.8);
            end
        end
        
        hold(axSeg, 'off');
        
        % Actualizar información
        countLabel.Text = ['Objetos detectados: ', num2str(length(B))];
        infoLabel.Text = ['Último procesamiento: ', datestr(now, 'HH:MM:SS')];
        
        % Actualizar histograma de áreas
        if ~isempty(stats)
            areas = [stats.Area];
            cla(axHist);
            histogram(axHist, areas, min(10, numel(unique(areas))));
            xlabel(axHist, 'Área (px)');
            ylabel(axHist, 'Frecuencia');
        end
    end

    %% -------- GUARDAR IMAGEN RESULTANTE --------
    function guardarImagen()
        frame = getframe(axSeg);
        timestamp = datestr(now, 'yyyymmdd_HHMMSS');
        filename = ['segmentacion_', timestamp, '.png'];
        imwrite(frame.cdata, filename);
        infoLabel.Text = ['Imagen guardada: ', filename];
        uialert(fig, ['Imagen guardada como "', filename, '"'], 'Guardado Exitoso', 'Icon', 'success');
    end

    %% -------- RESTAURAR A ESTADO INICIAL --------
    function restaurar()
        % Restaurar todos los controles a valores predeterminados
        sliderArea.Value = CONFIG.DEFAULT_AREA_MIN;
        rSlider.Value = CONFIG.DEFAULT_COLOR(1);
        gSlider.Value = CONFIG.DEFAULT_COLOR(2);
        bSlider.Value = CONFIG.DEFAULT_COLOR(3);
        formaDrop.Value = CONFIG.DEFAULT_FORMA;
        opMorfDrop.Value = CONFIG.DEFAULT_OPERACION_MORFOLOGICA;
        sliderElemento.Value = CONFIG.DEFAULT_TAMANO_ELEMENTO;
        
        % Actualizar la interfaz
        actualizar();
        
        % Mostrar mensaje de confirmación
        infoLabel.Text = 'Valores restaurados a configuración inicial';
    end

    % Ejecutar primera vez
    actualizar();
end