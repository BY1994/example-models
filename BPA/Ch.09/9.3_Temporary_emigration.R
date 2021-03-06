## 9. Multistate capture-recapture models
## 9.3. Accounting_for_temporary emigration
## 9.3.3. Analysis of the model

library(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
set.seed(123)

## Read data
## The data generation code is in bpa-code.txt, available at
## http://www.vogelwarte.ch/de/projekte/publikationen/bpa/complete-code-and-data-files-of-the-book.html
stan_data <- read_rdump("tempemi.data.R")

## Initial values
inits <- function() list(mean_phi = runif(1, 0, 1),
                         mean_psiIO = runif(1, 0, 1),
                         mean_psiOI = runif(1, 0, 1),
                         mean_p = runif(1, 0, 1))

## Parameters monitored
params <- c("mean_phi", "mean_psiIO", "mean_psiOI", "mean_p")

## MCMC settings
ni <- 2000
nt <- 1
nb <- 1000
nc <- 4

## Call Stan from R
tempemi <- stan("tempemi.stan",
                data = stan_data, init = inits, pars = params,
                chains = nc, iter = ni, warmup = nb, thin = nt,
                seed = 1,
                open_progress = FALSE)
print(tempemi, digits = 3)
