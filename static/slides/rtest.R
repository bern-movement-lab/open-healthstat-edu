library(tidyverse)
library(kableExtra)
library(rio)
library(patchwork)
library(ggbrace)
library(gamlss)
library(pastecs) # descriptive statistics of data frame
ggred <- "#F8766D"
ggblue <- "#00BFC4"
gggreen <- "#7CAE00"
ggviolet <- "#C77CFF"
df.stud <- import("../data/01-physio.csv")
df.stud <- df.stud |>
    mutate(
        Kohorte = extract_numeric(Kohorte),
        Groesse = as.numeric(Groesse),
        Gewicht = as.numeric(Gewicht),
        Geschwister = as.integer(sample(0:4, nrow(df.stud), prob = c(0.2, 0.3, 0.3, 0.1, 0.1), replace = TRUE)),
        Kohorte = as.factor(Kohorte),
        Geschlecht = as.factor(Geschlecht),
        Augenfarbe = as.factor(Augenfarbe),
        Klasse = as.factor(Klasse)
    )
df.stud_w <- df.stud |>
    filter(Geschlecht == "w")
head(df.stud, 5) |>
    select(c(ID, Augenfarbe, Groesse, Gewicht)) |>
    kableExtra::kable()
