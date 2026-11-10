# Film and Emotions: Positive Affect Analysis
# Secondary analysis of the psychTools affect dataset
# Author: Mohammad Sabzian Molaei

# 1. Load the original dataset
data("affect", package = "psychTools")

# 2. Create the outcome variable
affect$PA_change <- affect$PA2 - affect$PA1

# 3. Verify dataset dimensions
dim(affect)

# 4. Fit regression models

# Model 1: Film and study associations
model1 <- lm(PA_change ~ Study + factor(Film), data = affect)

# Model 2: Study × Film interaction
model2 <- lm(PA_change ~ Study * factor(Film), data = affect)

# Model 3: Adjust for baseline positive affect
model3 <- lm(PA_change ~ PA1 + Study + factor(Film),
             data = affect)

# 5. Verify model results
summary(model1)
anova(model1, model2)
summary(model3)

# 6. HC3 heteroskedasticity-robust inference

# Model 1: Robust standard errors
hc3_model1 <- lmtest::coeftest(
  model1,
  vcov. = sandwich::vcovHC(model1, type = "HC3")
)

# Model 3: Robust standard errors
hc3_model3 <- lmtest::coeftest(
  model3,
  vcov. = sandwich::vcovHC(model3, type = "HC3")
)

# Display results
hc3_model1
hc3_model3

# 7. Test baseline positive affect by film interaction
anova(model3, update(model3, . ~ . + PA1:factor(Film)))


# 8. Outlier and influence diagnostics

# Identify observations with |studentized residual| > 3
flagged <- which(abs(rstudent(model1)) > 3)
flagged

# Identify the 10 largest Cook's distances
sort(cooks.distance(model1), decreasing = TRUE)[1:10]

# 9. Sensitivity analysis
model1_sensitivity <- lm(
  PA_change ~ Study + factor(Film),
  data = affect[-flagged, ]
)

# Compare regression coefficients
round(cbind(
  original = coef(model1),
  without_outliers = coef(model1_sensitivity)
), 3)

# 10. Visualize and save positive-affect changes by film

dir.create("figures", showWarnings = FALSE)

png("figures/positive_affect_by_film.png",
    width = 1800, height = 1200, res = 200)

boxplot(
  PA_change ~ factor(Film),
  data = affect,
  names = c("Frontline", "Halloween", "Nature", "Parenthood"),
  xlab = "Film",
  ylab = "Change in positive affect (PA2 - PA1)",
  main = "Positive-Affect Change by Film"
)

abline(h = 0, lty = 2)

dev.off()


# 11. Export regression results

dir.create("results", showWarnings = FALSE)

# Model 1: HC3 results
results1 <- data.frame(
  Term = rownames(hc3_model1),
  Estimate = as.numeric(hc3_model1[, 1]),
  Robust_SE = as.numeric(hc3_model1[, 2]),
  t_value = as.numeric(hc3_model1[, 3]),
  p_value = as.numeric(hc3_model1[, 4])
)

write.csv(results1, "results/model1_hc3.csv",
          row.names = FALSE)

# Model 3: HC3 results
results3 <- data.frame(
  Term = rownames(hc3_model3),
  Estimate = as.numeric(hc3_model3[, 1]),
  Robust_SE = as.numeric(hc3_model3[, 2]),
  t_value = as.numeric(hc3_model3[, 3]),
  p_value = as.numeric(hc3_model3[, 4])
)

write.csv(results3, "results/model3_hc3.csv",
          row.names = FALSE)

# 12. Export model comparison and sensitivity results

# Model 1 vs. Model 2: Interaction test
interaction_results <- anova(model1, model2)

write.csv(
  interaction_results,
  "results/study_film_interaction.csv"
)

# Sensitivity analysis: Original vs. reduced sample
sensitivity_results <- data.frame(
  Term = names(coef(model1)),
  Original = as.numeric(coef(model1)),
  Without_outliers = as.numeric(coef(model1_sensitivity))
)

write.csv(
  sensitivity_results,
  "results/sensitivity_analysis.csv",
  row.names = FALSE
)

