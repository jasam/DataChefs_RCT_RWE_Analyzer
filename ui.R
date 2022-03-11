# Header page
header = dashboardHeader(title = "RCT / RWE Engine Analyzer",
                         tags$li(class="dropdown",
                                 tags$a(href="https://github.com/jasam/multi_method_comparison", 
                                        icon("github"), "Source Code", target="_blank")))

# Side Menu
sidebar = dashboardSidebar(sidebarMenu(
    menuItem("Introduction", tabName = "intro", icon = icon("question-circle-o")),
    menuItem("Insight Discovery", tabName = "crt", icon = icon("folder-open-o")),           
    menuItem("Experimental", tabName = "ind", icon = icon("clone"))           
))

# Body Page
body = dashboardBody(
    tags$head(
        # Styling Well 
        tags$style(
            "section.content { overflow-y: hidden; }")),
    tabItems(tabItem(tabName = "intro",
                     h2("Cohort Comparison Platform"),
                     h3('This disease exploration platform explores pooled data from RCTs and RWE to allow greater understanding of the broader patient journey.
                        Compare the pre- and post- trial data of trial participants, along with a representative cohort from the greater population with the same primary diagnosis.'),
                     h3('Development Team'),
                     shiny::p('For support, please contact:'),
                     tags$ul(
                         tags$li(tags$a(href="", 
                                        icon="github", target="_blank",
                                        "Priyanka, Priyanka-1"))
                     ),
                     tags$ul(
                         tags$li(tags$a(href="", 
                                        icon="github", target="_blank",
                                        "Hickey, Orlaith"))
                     ),
                     tags$ul(
                         tags$li(tags$a(href="", 
                                        icon="github", target="_blank",
                                        "Foley, Stephen"))
                     ),
                     tags$ul(
                         tags$li(tags$a(href="", 
                                        icon="github", target="_blank",
                                        "Noone, Gearoid"))
                     ),
                     tags$ul(
                         tags$li(tags$a(href="", 
                                        icon="github", target="_blank",
                                        "Javier Rey"))
                     ),
                     tags$ul(
                         tags$li(tags$a(href="", 
                                        icon="github", target="_blank",
                                        "Connector: Goodson, Forrest"))
                     ),
                     h3('Source code'),
                     shiny::p('The source code V.1 for this application can be found at ', tags$a(href="https://github.com/jasam/DataChefs_RCT_RWE_Analyzer/", icon("github"), target="_blank", "https://github.com/jasam/DataChefs_RCT_RWE_Analyzer/")),
                     shiny::p('Bug reports and feature requests can be submitted through the GitHub issues page ',  
                              tags$a(href="https://github.com/jasam/DataChefs_RCT_RWE_Analyzer/issues", icon("github"), 
                                     target="_blank", "https://github.com/jasam/multi_method_comparison/issues")),
                     
                     h3('Packages used'),
                     shiny::p('1. data.table: Extension of `data.frame`', tags$a(href="https://CRAN.R-project.org/package=data.table/", 
                                                                                 icon("file-pdf"), 
                                                                                 target="_blank", "https://CRAN.R-project.org/package=data.table")),
                     
                     shiny::p('2. DT: A Wrapper of the JavaScript Library DataTables', tags$a(href="https://github.com/rstudio/DT/", 
                                                                                              icon("file-pdf"), 
                                                                                              target="_blank", "https://github.com/rstudio/DT")),
                     
                     shiny::p('3. shiny: Web Application Framework for R', tags$a(href="https://shiny.rstudio.com/", 
                                                                                  icon("file-pdf"), 
                                                                                  target="_blank", "https://shiny.rstudio.com/")),
                     
                     shiny::p('4. shinydashboard: Create Dashboards with Shiny', tags$a(href="http://rstudio.github.io/shinydashboard/", 
                                                                                        icon("file-pdf"), 
                                                                                        target="_blank", "http://rstudio.github.io/shinydashboard/")),
                     
                     shiny::HTML("<a rel='license' href='http://creativecommons.org/licenses/by-nc/4.0/'><img alt='Creative Commons Licence' 
                                 style='border-width:0' src='https://i.creativecommons.org/l/by-nc/4.0/88x31.png' 
                                 /></a><br />This work is licensed under a <a rel='license' 
                                 href='http://creativecommons.org/licenses/by-nc/4.0/'>Creative Commons Attribution-NonCommercial 4.0 International License</a>.")
    ),
    tabItem(tabName = "crt", 
            box(title = "Parameters selector", status = "primary", solidHeader = TRUE, width = 12,
                collapsible = T,collapsed = F,
                fluidRow(column(width=2, selectInput("disease_area", label = "Disease Area", choices = disease_list)),
                         column(width=2, selectInput("disease", label = "Disease", choices = disease_list_2)) 
                ),
                fluidRow(column(width=7, selectInput("rct", label = "Randomized Clinical Trial", choices = cts_list)),
                         column(width=2, selectInput("rwd", label = "Real World Data", choices = rwd_list)) 
                )
            ),
            tabBox(title = "Insights Discovery", id = "tab_report", width = 12,
                   tabPanel("Data Summary",
                            h3(strong("Selected Data Sources")),
                            fluidRow(column(DT::dataTableOutput("data_summary"),
                                            width = 12)
                            ),
                            tabBox(title = "", id = "RCT-Cohort-Characteristics", width = 12,
                                   tabPanel("RCT Cohort",
                                            h4(strong("RCT Cohort Characteristics - AMALEE: Study of 2 Ribocidib Doses in Combination With Aromatase Inhibitors in Women With HR +, HER2- Advanced Breast Cancer")),
                                            br(),
                                            fluidRow(column(DT::dataTableOutput("rct_char_table"),
                                                            width = 12)
                                            )
                                   ),
                                   tabPanel("Matched RWE",
                                            h4(strong("Matched RWE Cohort Characteristics - OPTUM EHR")),
                                            br(),
                                            fluidRow(column(DT::dataTableOutput("rwe_char_table"),
                                                            width = 12))
                                            
                                   ),
                                   tabPanel("Gender-Ethnicity",
                                            fluidRow(
                                                column(width=6, 
                                                       highchartOutput("gender_plot")),
                                                column(width=6,
                                                       highchartOutput("ethnicity_plot"))
                                            )),
                                   tabPanel("Matched RCT Cohort Charlson",
                                            h4(strong("RCT Cohort Charlson Comorbidity Index Score - AMALEE: Study of 2 Ribocidib Doses in Combination With Aromatase Inhibitors in Women With HR +, HER2- Advanced Breast Cancer")),
                                            br(),
                                            fluidRow(
                                                
                                                column(DT::dataTableOutput("rct_cci_table"),
                                                       width = 12)
                                            )),
                                   tabPanel("Matched RWE Cohort Charlson",
                                            h4(strong("Matched RWE Cohort Charlson Comorbidity Index Score - OPTUM EHR")),
                                            br(),
                                            fluidRow(
                                                
                                                column(DT::dataTableOutput("rwe_cci_table"),
                                                       width = 12)
                                            )
                                   )
                            )
                   ),
                   
                   
                   tabPanel("Survival Analysis",
                            uiOutput("survival_analysis")
                   ),
                   tabPanel("Comorbidity Analysis",
                            uiOutput("comorbidiy_analysis")
                   ),
                   tabPanel("Adverse Events Analysis",
                            fluidRow(column(width=6, 
                                            br(),
                                            h5("This plot shows a time series of the occurrence of adverse events in trial and non trial patients"),
                                            br(),
                                            highchartOutput("events_time_plot")
                            ),
                            column(width=6, 
                                   br(),
                                   h5("This plot shows the distribution of adverse events across trial and non-trial patients."),
                                   br(),
                                   highchartOutput("events_count_plot")
                                   
                            )
                            )       
                   )
            )
    ),
    tabItem(tabName = "ind",
            tabBox(title = "Insights Discovery", id = "tab_cluster", width = 12,
                   tabPanel("Circles plot",
                            uiOutput("circles")
                   ),
                   tabPanel("Hierarchical Heatmap",
                            uiOutput("clustering_h")
                   ),
                   tabPanel("Clustering",
                            uiOutput("clustering")
                   )
            )
    )
    )
    
)

## Deploy page
dashboardPage(header, sidebar, body)