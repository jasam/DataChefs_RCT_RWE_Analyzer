# Load libraries

library(shiny)
library(shinydashboard)
library(data.table)
library(DT)
library(highcharter)
library(readxl)

# Load data
dt_summary = data.table::fread("./data/data_summary.txt", sep=",")
events_time <- read_excel("./data/Adverse_events_time_series.xlsx")
events_count <- read_excel("./data/Adverse_events_count.xlsx")
events_time$date <- as.Date(events_time$date)

# Global reference
dt_summary <<- dt_summary

# List catalogs

disease_list = c("Musculoskeletal Diseases", "Ophthalmology", "Autoimmunity", 
                 "Transplantation & Inflammatory Disease", "Cardiovascular & Metabolic Diseases", "Oncology",
                 "Neuroscience")
disease_list <<- disease_list

disease_list_2 = c("Lymphoma - Non-Hodgkin",
                   "Lung Cancer",
                   "Colorectal Cancer",
                   "Breast Cancer",
                   "Bladder Cancer", 
                   "Kidney Cancer")
disease_list_2 <<- disease_list_2

cts_list = c("AMALEE: Study of 2 Ribocidib Doses in Combination With Aromatase Inhibitors in Women With HR +, HER2- Advanced Breast Cancer", 
             "BYlieve:Study Assessing the efficacy and Safety of Alpelisib Plus Fulvestrant or Letrozole, Based on Prior Endocrine Therapy,in Patients With PIK3CA Mutation With Advanced Breast Cancer Who Have Progressed on or After Prior Treatments",
             "SOLAR-1:Study Assessing the Efficacy and Safety of Alpelisib Plus Fulvestrant in Men and Postmenopausal Women With Advanced Breast Cancer Which Progressed on or After Aromatase Inhibitor Treatment",
             "LEADER: CDK4/6 Inhinitor, Ribocidib, With Adjuvant Endocrine Therapy for ER- positive Breast Cancer",
             "Comparison of Single-Agent Carboplatin vs the Combination of Carboplatin and Everolimus for the Treatment of Advanced Triple-Negative Breast Cancer",
             "Study of Safety and Efficacy of DKY709 Alone or in Combination With PDR001 in Patients With Advanced Solid Tumors")
cts_list <<- cts_list

rwd_list = c("Optum EHR",
             "MarketScan",
             "Flatiron",
             "CPRD",
             "UK Biobank",
             "Adelphi",
             "JMDC")
rwd_list <<- rwd_list

RCT_char <- data.frame(Mean = c(62.14,
                                27.21,
                                2.78,
                                1.02),
                       Median = c(60.14,
                                  28.02994064,
                                  2.41,
                                  1.20
                       ),
                       StddDev = c(11.84,
                                   5.73,
                                   2.07,
                                   0.45
                       ),
                       Min = c(18,
                               17.3,
                               0,
                               0
                       ),
                       Max = c(84,
                               31.4,
                               8,
                               6
                       )
)

RCT_char <<- RCT_char

row.names(RCT_char) <- c("Age", "BMI", "Time Since First Diagnosis", "Charlson's comorbidity Score")


RWE_char <- data.frame(Mean = c(60.83,
                                27.21,
                                2.92,
                                1.05
),
Median = c(60.04,
           29.60,
           3.37,
           1.17
           
),
StddDev = c(11.80,
            4.13,
            2.66,
            0.54
            
),
Min = c(18,
        18.14,
        0,
        0
        
),
Max = c(82,
        30.65,
        9,
        6
        
)
)

row.names(RWE_char) <- c("Age", "BMI", "Time Since First Diagnosis", "Charlson's comorbidity Score")

RWE_char <<- RWE_char

sex <- c("Male", "Female", "Unknown", "Male", "Female", "Unknown")
group <- c("RCT", "RCT", "RCT", "RWE", "RWE", "RWE")
count11 <- c(2,685,1,2,687,0)

gender_data <- data.frame(Gender = factor(sex), Group = factor(group), Count = count11)
gender_data <<- gender_data

## Plot 2 ####

ethnicity <- c("Caucasian",
               "African American",
               "Asian",
               "Other/Unknown",
               "Caucasian",
               "African American",
               "Asian",
               "Other/Unknown"
)

group1 <- c("RCT", "RCT", "RCT", "RCT", "RWE", "RWE", "RWE", "RWE")
count2 <- c(577,76,10,26,572,79,13,25)

ethnicity_data <- data.frame(Ethnicity = factor(ethnicity), Group = factor(group1), Count = count2)
ethnicity_data <<- ethnicity_data

CCI_Score <- c("0","1", "2", "3+")
rct_ccount <- c(321,182,115,71)
rct_per <- c("46.6%",
             "26.4%",
             "16.7%",
             "10.3%"
)

rct_cci <- data.frame(CCI_Score, Count = rct_ccount, Percentage = rct_per)
rct_cci <<- rct_cci

CCI_Score <- c("0","1", "2", "3+")
rwe_ccount <- c(325,182,113,69)
rwe_per <- c("47.2%",
             "26.4%",
             "16.4%",
             "10.0%"
)

rwe_cci <- data.frame(CCI_Score, Count = rwe_ccount, Percentage = rwe_per)
rwe_cci <<- rwe_cci


