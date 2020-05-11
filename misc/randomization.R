


data.frame(
  scores = c(1,2,3,4,5), 
  group = c("C", "C", "C", "T", "T")
  ) %>%
  modelr::permute(n = 100, group) %>% # permute the group column 100 times
  mutate(
    models = map(perm, ~coef(lm(scores ~ group, data = .))[[2]])
  ) %>% # do a t-test for each permutation
  mutate(tidy = map(models, broom::tidy)) %>% # extract useful statistics from the t-test
  unnest(tidy)


my_sample = rep(NA, 1000)

for(i in 1:1000){

#   my_sample[i] = data.frame(
#   scores = c(1,2,3,4,5), 
#   group = c("C", "C", "C", "T", "T")
# ) %>%
  
my_sample[i] = after_school %>%  
  group_by(sample(treatment)) %>%
  summarize(M = mean(delinq)) %>%
  #ungroup() %>%
  summarize(d = diff(M))

}

d = data.frame(
  mean_diffs = unlist(my_sample)
)


ggplot(data = d, aes(x = mean_diffs)) +
  geom_density()

names(t.test(scores ~ group, data = d))

coef(lm(scores ~ group, data = d))[[2]]
