
library(nycflights13)
library(tidyverse)

#observe data
flights

# tibble only shows the first few rows and all the columns that fit on one screen.


#filter
jan1 <- filter(flights, month == 1, day == 1)

#R either prints out the results, or saves them to a variable. If you want to do both, you can wrap the assignment in parentheses:

(dec25 <- filter(flights, month == 12, day == 25))

#logical operators 
# or  |

jan11Or12<- filter(flights, month == 11 | month == 12)

# A useful short-hand for this problem is x %in% y. This will select every row where x is one of the values 
#in y. We could use it to rewrite the code above:
nov_dec <- filter(flights, month %in% c(11, 12))

#not x and not y
filter(flights, !(arr_delay > 120 | dep_delay > 120))


#remove missing value
df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)
filter(df, !is.na(x) | x > 1)


##############arrange 
#If you provide more than one column name, each additional column will be used to break ties in the values of preceding columns:
arrange(flights, year, month, dep_time)
arrange(flights, desc(arr_delay))

#Missing values are always sorted at the end:

df <- tibble(x = c(5, 2, NA))
arrange(df, x)
arrange(df, desc(x))

############select
select(flights, year, month, day)

# Select all columns between year and day (inclusive)
select(flights, year:day)

# Select all columns except those from year to day (inclusive)
select(flights, -(year:day))

select(flights, contains("TIME"))


##########rename
rename(flights, tail_num = tailnum)




###########mutate

select(flights, year:day, ends_with("delay"), distance, air_time)

mutate(flights, gain = arr_delay - dep_delay, speed = distance / air_time * 60)


#If you only want to keep the new variables, use transmute():
transmute(flights,
          gain = arr_delay - dep_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
)

#summarise 
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))

by_day <- group_by(flights, year, day)

summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))



### piping   %>%

filter(flights, year == 2013) %>%
  arrange(flights, year, month, dep_time)%>%
  select(-(year)) %>%
  rename(tail_num = tailnum)%>%
  mutate(gain = arr_delay - dep_delay, speed = distance / air_time * 60)
  





