source("global.R")

#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$data_summary = DT::renderDataTable({
        
       DT::datatable(dt_summary,
                      options = list(searching = FALSE, paging = FALSE),
                      class = "row-border",
                      rownames = FALSE)
        
    })
    
    output$rct_data = DT::renderDataTable({
        
        DT::datatable(RCT_char,
                      options = list(searching = FALSE, paging = FALSE),
                      class = "row-border",
                      rownames = FALSE)
        
    })
    
    output$rwe_data = DT::renderDataTable({
        
        DT::datatable(RWE_char,
                      options = list(searching = FALSE, paging = FALSE),
                      class = "row-border",
                      rownames = FALSE)
        
    })
    
    output$events_time_plot <- renderHighchart(
        
        events_time %>% hchart('line',hcaes(x="date", y="count", group="group"))
        %>% 
            hc_title(text = "Time Series of Adverse Events for Trial and Non Clinical Trial Patients",
                     style = list(fontWeight = "bold"),
                     align = "center") %>%
            hc_xAxis(title = list(text = "Date"),
                     style = list(fontWeight = "bold")) %>%
            hc_yAxis(title = list(text = "Event Count"),
                     style = list(fontWeight = "bold")) %>%
            hc_legend(title = list(text= 'Group'),layout = "vertical", verticalAlign = 'middle',
                      align = "right") %>%
            hc_tooltip(crosshairs = TRUE,
                       shared = TRUE, 
                       borderWidth = 4) %>% 
            hc_exporting(enabled = TRUE) %>%
            hc_colors(c("#0073C2FF", "#EFC000FF")) %>%
            hc_plotOptions(line = list(pointWidth = 25))
    )
    
    output$events_count_plot <- renderHighchart(
        events_count %>% 
            hchart('bar',hcaes(x='event',y='count', group='group'))
        %>% hc_title(text = "Common Adverse Events in Trial and Non Clinical Trial Patients",
                     style = list(fontWeight = "bold"),
                     align = "center") %>%
            hc_xAxis(title = list(text = "Adverse Event"),
                     style = list(fontWeight = "bold")) %>%
            hc_yAxis(title = list(text = "Count"),
                     style = list(fontWeight = "bold")) %>%
            hc_legend(enabled = TRUE) %>%
            hc_plotOptions(column = list(pointWidth = 25)) %>%
            hc_colors(c("#0073C2FF", "#EFC000FF"))
        
    )
    
    output$rct_char_table <- renderDataTable(
        DT::datatable(RCT_char, # Reactive context, data loaded using reactivity
                      options = list(lengthMenu=list(c(5,15,20), c('5','15','20')), pageLength=6,
                                     
                                     columnDefs=list(list(className='dt-center',targets="_all")), searching = FALSE),
                      selection = 'multiple',
                      style = 'default',
                      class = 'cell-border stripe',
                      rownames = TRUE)
    )
    
    output$rwe_char_table <- renderDataTable(
        DT::datatable(RWE_char, # Reactive context, data loaded using reactivity
                      options = list(lengthMenu=list(c(5,15,20), c('5','15','20')), pageLength=6,
                                     
                                     columnDefs=list(list(className='dt-center',targets="_all")), searching = FALSE),
                      selection = 'multiple',
                      style = 'default',
                      class = 'cell-border stripe',
                      rownames = TRUE)
    )
    
    output$gender_plot <- renderHighchart(
        
        gender_data %>% 
            hchart('column',hcaes(x='Gender',y='Count', group='Group')) %>%
            hc_title(text = "Gender Counts for Trial and Non Clinical Trial Cohorts",
                     style = list(fontWeight = "bold"),
                     align = "center") %>%
            hc_xAxis(title = list(text = "Gender"),
                     style = list(fontWeight = "bold")) %>%
            hc_yAxis(title = list(text = "Count"),
                     style = list(fontWeight = "bold")) %>%
            hc_legend(enabled = TRUE) %>%
            hc_plotOptions(column = list(pointWidth = 25))
        
    )
    
    output$ethnicity_plot <- renderHighchart(
        
        ethnicity_data %>% 
            hchart('column',hcaes(x='Ethnicity',y='Count', group='Group')) %>%
            hc_title(text = "Ethnicity Counts for Trial and Non Clinical Trial Cohorts",
                     style = list(fontWeight = "bold"),
                     align = "center") %>%
            hc_xAxis(title = list(text = "Ethnicity"),
                     style = list(fontWeight = "bold")) %>%
            hc_yAxis(title = list(text = "Count"),
                     style = list(fontWeight = "bold")) %>%
            hc_legend(enabled = TRUE) %>%
            hc_plotOptions(column = list(pointWidth = 25))
        
    )
    
    output$rct_cci_table <- renderDataTable(
        DT::datatable(rct_cci, # Reactive context, data loaded using reactivity
                      options = list(lengthMenu=list(c(5,15,20), c('5','15','20')), pageLength=6,
                                     
                                     columnDefs=list(list(className='dt-center',targets="_all")), searching = FALSE),
                      selection = 'multiple',
                      style = 'default',
                      class = 'cell-border stripe',
                      rownames = TRUE)
    )
    
    output$rwe_cci_table <- renderDataTable(
        DT::datatable(rwe_cci, # Reactive context, data loaded using reactivity
                      options = list(lengthMenu=list(c(5,15,20), c('5','15','20')), pageLength=6,
                                     
                                     columnDefs=list(list(className='dt-center',targets="_all")), searching = FALSE),
                      selection = 'multiple',
                      style = 'default',
                      class = 'cell-border stripe',
                      rownames = TRUE)
    )
    output$circles <- renderUI({
        withMathJax(
        tags$h2("Adverse events"),
        "This visualisation is based on Circos, a way of visualising whole adverse events relation.
         This is a simple mockup in order to explain a way to identify common adverse events in CTS and RWE.
         Inspired from genomics analysis.",
        br(),
        tags$img(src="cloro.PNG")
        )
    })

    output$comorbidiy_analysis <- renderUI({
        withMathJax(
        br(),
        tags$img(src="comorbidity_analysis.png")
        )
    })
    
    output$survival_analysis <- renderUI({
        withMathJax(
        br(),
        tags$img(src="survival_analysis.PNG")
        )
    })
    
    output$adverse_analysis <- renderUI({
        withMathJax(
        br(),
        tags$img(src="adverse_events_analysis.png")
        )
    })
    
    output$adverse_analysis_2 <- renderUI({
        withMathJax(
        br(),
        tags$img(src="adverse_events_analysis_2.png")
        )
    })
    
    output$clustering_h <- renderUI({
        withMathJax(
        tags$h2("heatmap-hierarchical comorbidities"),
        br(),
        tags$img(src="hierarchical_clutering.PNG")
        )
    })
    
    output$clustering <- renderUI({
        withMathJax(
        tags$h2("Clustering comorbidities"),
        br(),
        tags$img(src="clustering.PNG")
        )
    })

})
