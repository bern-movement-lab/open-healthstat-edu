# Packages
library(tidyverse)
# Import data
df <- read_csv("../data/MMs.csv")
df$Farbe <- as_factor(df$Farbe)
df$ID <- as_factor(df$ID)
# Overall mean weight
m <- mean(df$Gewicht, na.rm = T)
# Overall color probabilities
prob_all <- df |>                     # keep only rows where a colour is recorded
  filter(!is.na(Farbe)) |>            
  count(Farbe, name = "n") |>         # how many times each colour occurs
  mutate(
    total    = sum(n),                 # total number of non‑NA colour observations
    prob     = n / total,              # P(colour)
    prob_not = 1 - prob                # complementary probability
  ) |>
  select(Farbe, n, prob, prob_not)
# Reshape color probabilities
prob_long <- prob_all |>
  pivot_longer(
    cols = c(prob, prob_not),
    names_to = "type",
    values_to = "value"
  ) |>
  mutate(
    type = factor(type,
                  ## levels = c("prob", "prob_not"),
                  ## labels = c("P(Farbe)", "1–P(Farbe)"))
                  levels = c("prob_not", "prob"),
                  labels = c("1–P(Farbe)", "P(Farbe)"))
  )
# Draw samples
set.seed(33)
nA <- 10 # number of items to draw for sample A
nB <- 30 # number of items to draw for sample B
nC <- 100 # number of items to draw for sample C
samples <- 1:500 # number of samples to draw
weightdf <- data.frame()
colordf <- data.frame()
for (i in samples) {
  rowsA <- sample(1:nrow(df), nA)
  rowsB <- sample(1:nrow(df), nB)
  rowsC <- sample(1:nrow(df), nC)
  dfA <- df[rowsA,]
  dfB <- df[rowsB,]
  dfC <- df[rowsC,]
  meanAdf <- data.frame(Gewicht=mean(dfA$Gewicht, na.rm = T), n=nA)
  meanBdf <- data.frame(Gewicht=mean(dfB$Gewicht, na.rm = T), n=nB)
  meanCdf <- data.frame(Gewicht=mean(dfC$Gewicht, na.rm = T), n=nC)
  meandf <- bind_rows(meanAdf, meanBdf, meanCdf)
  meandf$Ziehung <- i
  weightdf <- bind_rows(weightdf,meandf)
  probA <- dfA |>                     # keep only rows where a colour is recorded
    filter(!is.na(Farbe)) |>            
    count(Farbe, name = "n") |>         # how many times each colour occurs
    mutate(
      total    = sum(n),                 # total number of non‑NA colour observations
      prob     = n / total,              # P(colour)
      prob_not = 1 - prob                # complementary probability
    ) |>
    select(Farbe, n, prob, prob_not)
  probA$n <- nA
  probB <- dfB |>                     # keep only rows where a colour is recorded
    filter(!is.na(Farbe)) |>            
    count(Farbe, name = "n") |>         # how many times each colour occurs
    mutate(
      total    = sum(n),                 # total number of non‑NA colour observations
      prob     = n / total,              # P(colour)
      prob_not = 1 - prob                # complementary probability
    ) |>
    select(Farbe, n, prob, prob_not)
  probB$n <- nB
  probC <- dfC |>                     # keep only rows where a colour is recorded
    filter(!is.na(Farbe)) |>            
    count(Farbe, name = "n") |>         # how many times each colour occurs
    mutate(
      total    = sum(n),                 # total number of non‑NA colour observations
      prob     = n / total,              # P(colour)
      prob_not = 1 - prob                # complementary probability
    ) |>
    select(Farbe, n, prob, prob_not)
  probC$n <- nC
  probdf <- bind_rows(probA,probB,probC)
  probdf$Ziehung <- i
  colordf <- bind_rows(colordf,probdf)
}
p1 <- weightdf |>
  ggplot(aes(x=Gewicht)) +
  geom_histogram(aes(y = ..density..)) +
  labs(x="Gewicht (g)",
       y="") +
  theme(text = element_text(size = 24),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank()) +
  facet_grid(vars(n))
