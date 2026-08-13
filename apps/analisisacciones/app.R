
# ============================================================
# Dashboard Shiny - Análisis de Acciones de la Bolsa de Valores
# ============================================================
# Requisitos: Instalar los siguientes paquetes antes de ejecutar
# install.packages(c("shiny", "shinydashboard", "quantmod", "ggplot2", "DT"))

library(shiny)
library(shinydashboard)
library(quantmod)
library(ggplot2)
library(DT)

# ========================== UI ==========================
ui <- dashboardPage(
  skin = "blue",
  
  dashboardHeader(title = "Análisis Bursátil - Histograma"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("chart-bar")),
      hr(),
      # Inputs del usuario
      textInput("ticker", "Ticker de la Acción:", value = "AAPL", placeholder = "Ej: AAPL, MSFT, TSLA"),
      dateInput("fecha_inicio", "Fecha de Inicio:", value = Sys.Date() - 365, format = "yyyy-mm-dd"),
      dateInput("fecha_fin", "Fecha Final:", value = Sys.Date(), format = "yyyy-mm-dd"),
      br(),
      actionButton("btn_analizar", "Analizar", icon = icon("search"), 
                   style = "color: #fff; background-color: #3c8dbc; border-color: #367fa9; width: 90%; margin-left: 5%;")
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard",
              
              # Fila 1: Información general
              fluidRow(
                valueBoxOutput("vbox_ticker", width = 3),
                valueBoxOutput("vbox_media", width = 3),
                valueBoxOutput("vbox_desviacion", width = 3),
                valueBoxOutput("vbox_observaciones", width = 3)
              ),
              
              # Fila 2: Histograma
              fluidRow(
                box(
                  title = "Histograma de Precios de Cierre (9 Clases)",
                  status = "primary",
                  solidHeader = TRUE,
                  width = 12,
                  plotOutput("histograma", height = "450px")
                )
              ),
              
              # Fila 3: Estadísticas descriptivas
              fluidRow(
                box(
                  title = "Estadísticas Descriptivas",
                  status = "info",
                  solidHeader = TRUE,
                  width = 6,
                  tableOutput("tabla_estadisticas")
                ),
                box(
                  title = "Cuartiles",
                  status = "info",
                  solidHeader = TRUE,
                  width = 6,
                  tableOutput("tabla_cuartiles")
                )
              ),
              
              # Fila 4: Tabla de intervalos
              fluidRow(
                box(
                  title = "Tabla de Frecuencias (9 Intervalos)",
                  status = "warning",
                  solidHeader = TRUE,
                  width = 12,
                  DTOutput("tabla_frecuencias")
                )
              )
      )
    )
  )
)

# ========================== SERVER ==========================
server <- function(input, output, session) {
  
  # Reactivo: Obtener datos de la acción
  datos_accion <- eventReactive(input$btn_analizar, {
    req(input$ticker, input$fecha_inicio, input$fecha_fin)
    
    tryCatch({
      # Descargar datos usando quantmod
      datos <- getSymbols(input$ticker, src = "yahoo", 
                          from = input$fecha_inicio, 
                          to = input$fecha_fin, 
                          auto.assign = FALSE)
      
      # Extraer precios de cierre ajustados
      precios_cierre <- as.numeric(Ad(datos))
      precios_cierre <- precios_cierre[!is.na(precios_cierre)]
      
      return(precios_cierre)
    }, error = function(e) {
      showNotification(paste("Error al obtener datos:", e$message), type = "error")
      return(NULL)
    })
  }, ignoreNULL = FALSE)
  
  # ---- Value Boxes ----
  output$vbox_ticker <- renderValueBox({
    valueBox(
      value = toupper(input$ticker),
      subtitle = "Ticker",
      icon = icon("chart-line"),
      color = "blue"
    )
  })
  
  output$vbox_media <- renderValueBox({
    precios <- datos_accion()
    media <- ifelse(!is.null(precios), round(mean(precios), 2), "N/A")
    valueBox(
      value = paste("$", media),
      subtitle = "Precio Medio",
      icon = icon("dollar-sign"),
      color = "green"
    )
  })
  
  output$vbox_desviacion <- renderValueBox({
    precios <- datos_accion()
    sd_val <- ifelse(!is.null(precios), round(sd(precios), 4), "N/A")
    valueBox(
      value = sd_val,
      subtitle = "Desviación Estándar",
      icon = icon("arrows-alt-h"),
      color = "yellow"
    )
  })
  
  output$vbox_observaciones <- renderValueBox({
    precios <- datos_accion()
    n <- ifelse(!is.null(precios), length(precios), 0)
    valueBox(
      value = n,
      subtitle = "Observaciones",
      icon = icon("database"),
      color = "purple"
    )
  })
  
  # ---- Histograma con 9 clases ----
  output$histograma <- renderPlot({
    precios <- datos_accion()
    req(precios)
    
    df <- data.frame(Precio = precios)
    
    ggplot(df, aes(x = Precio)) +
      geom_histogram(bins = 9, fill = "#3c8dbc", color = "white", alpha = 0.85) +
      geom_vline(aes(xintercept = mean(Precio)), color = "red", linetype = "dashed", size = 1) +
      labs(
        title = paste("Histograma de Precios de Cierre -", toupper(input$ticker)),
        subtitle = paste("Período:", input$fecha_inicio, "a", input$fecha_fin, "| Línea roja = Media"),
        x = "Precio de Cierre Ajustado ($)",
        y = "Frecuencia"
      ) +
      theme_minimal(base_size = 14) +
      theme(
        plot.title = element_text(face = "bold", hjust = 0.5, size = 16),
        plot.subtitle = element_text(hjust = 0.5, color = "gray40"),
        panel.grid.minor = element_blank()
      )
  })
  
  # ---- Tabla de Estadísticas Descriptivas ----
  output$tabla_estadisticas <- renderTable({
    precios <- datos_accion()
    req(precios)
    
    data.frame(
      Estadístico = c("Media", "Varianza", "Desviación Estándar", 
                      "Precio Mínimo", "Precio Máximo", "Rango"),
      Valor = c(
        round(mean(precios), 4),
        round(var(precios), 4),
        round(sd(precios), 4),
        round(min(precios), 4),
        round(max(precios), 4),
        round(max(precios) - min(precios), 4)
      )
    )
  }, striped = TRUE, hover = TRUE, bordered = TRUE, width = "100%")
  
  # ---- Tabla de Cuartiles ----
  output$tabla_cuartiles <- renderTable({
    precios <- datos_accion()
    req(precios)
    
    cuartiles <- quantile(precios, probs = c(0, 0.25, 0.50, 0.75, 1.00))
    
    data.frame(
      Cuartil = c("Mínimo (Q0)", "Primer Cuartil (Q1)", "Mediana (Q2)", 
                  "Tercer Cuartil (Q3)", "Máximo (Q4)"),
      Percentil = c("0%", "25%", "50%", "75%", "100%"),
      Valor = round(as.numeric(cuartiles), 4)
    )
  }, striped = TRUE, hover = TRUE, bordered = TRUE, width = "100%")
  
  # ---- Tabla de Frecuencias por Intervalo ----
  output$tabla_frecuencias <- renderDT({
    precios <- datos_accion()
    req(precios)
    
    # Crear 9 intervalos
    cortes <- seq(min(precios), max(precios), length.out = 10)
    intervalos <- cut(precios, breaks = cortes, include.lowest = TRUE, dig.lab = 4)
    
    # Tabla de frecuencias
    freq_tabla <- as.data.frame(table(intervalos))
    colnames(freq_tabla) <- c("Intervalo", "Frecuencia Absoluta")
    freq_tabla$`Frecuencia Relativa` <- round(freq_tabla$`Frecuencia Absoluta` / sum(freq_tabla$`Frecuencia Absoluta`), 4)
    freq_tabla$`Frecuencia Acumulada` <- cumsum(freq_tabla$`Frecuencia Absoluta`)
    freq_tabla$`% Acumulado` <- round(freq_tabla$`Frecuencia Acumulada` / sum(freq_tabla$`Frecuencia Absoluta`) * 100, 2)
    
    datatable(freq_tabla, options = list(pageLength = 9, dom = 't'), rownames = FALSE)
  })
}

# ========================== EJECUTAR APP ==========================
shinyApp(ui = ui, server = server)

