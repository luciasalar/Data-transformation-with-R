
library(tidyverse)

#observe data
battles1 <- read.csv("battles.csv", header = T)

#convert your data into tibble
# tibble only shows the first few rows and all the columns that fit on one screen.
battles <- as_data_frame(battles1)
battles

#filter
attacker <- filter(battles, attacker_king == "Robb Stark")

#R either prints out the results, or saves them to a variable. If you want to do both, you can wrap the assignment in parentheses:

(attacker <- filter(battles, attacker_king == "Robb Stark"))

#logical operators 
# or  |    & and

filter(battles, attacker_king == "Robb Stark" & attacker_outcome == "win")

filter(battles, attacker_king == "Robb Stark" | defender_king == "Joffrey/Tommen Baratheon")

# A useful short-hand for this problem is x %in% y. This will select every row where x is one of the values 
#in y. We could use it to rewrite the code above:
filter(battles, attacker_king %in% c("Robb Stark", "Joffrey/Tommen Baratheon"))

#not x and not y
major_battle<- filter(battles, !(attacker_size < 3000 | major_death < 1))


#remove missing value

remove_na<- filter(battles, !is.na(attacker_size))


##############arrange 
#If you provide more than one column name, each additional column will be used to break ties in the values of preceding columns:
arrange(battles, year, attacker_size)
arrange(battles, year, desc(attacker_size))

#Missing values are always sorted at the end:


############select
select(battles, year, battle_number)

# Select all columns between year and day (inclusive)
select(battles, year:attacker_1)

# Select all columns except those from year to day (inclusive)
select(battles, -(year:attacker_1))

select(battles, contains("attacker"))


##########rename
rename(battles, attackerKing = attacker_king)




###########mutate

select(battles, name:battle_number, starts_with("attacker"), region)

mutate(battles, gain = attacker_size - defender_size)


#If you only want to keep the new variables, use transmute():
transmute(battles, gain = attacker_size - defender_size)

#summarise 
summarise(battles, attacker_size_aver = mean(attacker_size, na.rm = TRUE))

by_king <- group_by(battles, attacker_king)


### piping   %>%

#Is Robb Stark a good millitary commander ?

compare <- battles %>%
  filter(!is.na(attacker_size & defender_size))%>%
  select(attacker_king, attacker_size, defender_size) %>%
  mutate(gain = attacker_size - defender_size)%>%
  arrange(gain)
  





