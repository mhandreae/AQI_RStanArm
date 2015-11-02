library(rstanarm)
data(lalonde, package = "arm")
??lalonde
t7 <- student_t(df = 7) 
f <- treat ~ re74 + re75 + educ + black + hisp + married + nodegr + u74 + u75
fit3 <- stan_glm(f, data = lalonde, family = binomial(link="logit"), 
                 prior = t7, prior_intercept = t7)
ppcheck(fit3, check = "resid", nreps = 2)
ppcheck(fit3, check = "test", test = mean)
ppcheck(fit3, check = "test", test = sd)
ppcheck(fit3, check = "dist", overlay = FALSE)


newdata <- data.frame(age = 40, educ = 12, black = 1, hisp = 0, 
                      married = 1, nodegr = 0, re74 = 0, re75 = 0, 
                      re78 = mean(lalonde$re78), u74 = 1, u75 = 1)
ppd_new <- posterior_predict(fit3, newdata = newdata)
