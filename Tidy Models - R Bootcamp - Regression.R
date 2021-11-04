

library(tidyverse)
library(tidymodels)
library(caret)
library(ggcorrplot)
library(psych)
library(factoextra)




###
df_raw <- read_csv("Downloads/geohackathon_bootcamps-main/regression_example/example_WT2021.csv")


skim(df_raw)

# Drop the rows with NA
df_raw %<>% drop_na()
set.seed(123)


df_raw %<>%
  rename(.,flow_rate = `Flow rate [m3/d]`)

recipe1 <-  recipes::recipe(flow_rate ~ `Pump speed [rpm]`+ `WHP [bar]`+`WHT [C]`, data = df_raw )



df_split <- initial_split(data = df_raw,prop = .75)

df_split_train <- training(df_split)
df_split_test <- testing(df_split)
df_split_train_folded <- vfold_cv(df_split_train)


rf_rec <- recipe(flow_rate ~`Pump speed [rpm]`+ `WHP [bar]`+`WHT [C]`,data = df_split_train ) %>%
  step_scale(all_predictors())

rf_rec


rf_spec <- rand_forest(mode = "regression",engine = "ranger")


df_wf <- workflow() %>%
    add_recipe(rf_rec)

rf_rs <- df_wf %>%
  add_model(rf_spec)%>%
  fit_resamples(resamples = df_split_train_folded,
                control = control_resamples(save_pred = T))


rf_rs$.predictions

collect_metrics(rf_rs)


### Plot a comparison of Predicted vs actual values to get a visual sense of the model fit
collect_predictions(rf_rs)%>%
  ggplot(aes(flow_rate,.pred,colour= id))+
  geom_point(alpha=.5)+
  labs(x="Actual", y="Predicted",title = "Flow Rate: Fit Actual vs Predicted Performance")+
  theme_minimal()

### Running the model on the test data set
rf_pred <- df_wf %>% add_model(rf_spec) %>% last_fit(split = df_split)

##### Lets dip into the predictions tibble
rf_pred$.predictions

### Lets Collect the results of the test data set
collect_metrics(rf_pred)


### Lets plot it out to get a better visual sense of how the model did in its predictions
rf_pred$.predictions
collect_predictions(rf_pred)%>%
  ggplot(aes(flow_rate,.pred,colour= id))+
  geom_point(alpha=.5)+
  geom_abline(lty = 2) +
  labs(x="Actual", y="Predicted",title = "Flow Rate: Actual vs Predicted using")+
  theme_minimal()



##### Linear Regression:
set.seed(124)

lm_rec <- recipe(flow_rate ~`Pump speed [rpm]`+ `WHP [bar]`+`WHT [C]`,data = df_split_train ) %>%
  step_scale(all_predictors())

lm_spec <- linear_reg(mode = "regression",engine = "stan")

df_wf_lm <- workflow() %>%
  add_recipe(lm_rec)


lm_rs <- df_wf_lm %>%
  add_model(lm_spec)%>%
  fit_resamples(resamples = df_split_train_folded,
                control = control_resamples(save_pred = T))

lm_rs

collect_metrics(lm_rs)



### Plot a comparison of Predicted vs actual values to get a visual sense
collect_predictions(lm_rs)%>%
  ggplot(aes(flow_rate,.pred,colour= id))+
  geom_abline(lty = 2) +
  geom_point(alpha=.5)+
  labs(x="Actual", y="Predicted",title = "Flow Rate: Actual vs Predicted using")+
  theme_minimal()

### Running the model on the test data set
lm_pred <- df_wf %>% add_model(lm_spec) %>% last_fit(split = df_split)

##### Lets dip into the predictions tibble
lm_pred$.predictions

### Lets Collect the results of the test data set
collect_metrics(lm_pred)


### Lets plot it out to get a better visual sense of how the model did in its predictions
lm_pred$.predictions
collect_predictions(lm_pred)%>%
  ggplot(aes(flow_rate,.pred,colour= id))+
  geom_abline(lty = 2) +
  geom_point(alpha=.5)+
  labs(x="Actual", y="Predicted",title = "Flow Rate: Actual vs Predicted using")+
  theme_minimal()

