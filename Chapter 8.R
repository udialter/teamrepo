

library(tidyverse)
library(dbplyr)
library(nycflights13)



tibble(
    x = 1:5, 
    y = 1, 
    z = x ^ 2 + y
)

tribble(
  ~x, ~y, ~z,
  #--|--|----
  "a", 2, 3.6,
  "b", 1, 8.5
)

tibble(
  a = lubridate::now() + runif(1e3) * 86400,
  b = lubridate::today() + runif(1e3) * 30,
  c = 1:1e3,
  d = runif(1e3),
  e = sample(letters, 1e3, replace = TRUE)
)


nycflights13::flights %>% 
  print(n = 10, width = Inf)

df <- tibble(
  x = runif(5),
  y = rnorm(5)
)

# extracting a vector (single variable/column)
df$x
df[["x"]]
df[[1]]

# extracting using the pipe
df %>% .$x
df %>% .[["x"]]


# change to regular data frame instead of tibble
as.data.frame(df)


### Exercises 10.5

#1. How can you tell if an object is a tibble? (Hint: try printing mtcars, which is a regular data frame).

#You can use the str() function. mtcars is a data.frame with 32 obs and 11 variables

#diamonds (a tibble) has multiple classes:
#tbl_df, tbl, and data.frame

#If you print diamonds, before providing the first 10 rows, it says "A tibble" followed by the dimensions. Printing mtcars prints the whole dataframe and doesn't give information about it's class or structure. 

#2. Compare and contrast the following operations on a data.frame and equivalent tibble. What is different? Why might the default data frame behaviours cause you frustration?


df <- data.frame(abc = 1, xyz = "a")
df
df$x
df[, "xyz"]
df[, c("abc", "xyz")]

df2<-tibble(abc = 1, xyz = "a")
df2$xyz 
df2[, "xyz"]
df2[, c("abc", "xyz")]


#The dataframe takes x as a shorthand for xyz which maybe you didn't want to do. It also makes xyz a factor by automatically converting string data into a factor.

#the tibble throws an error for df$x and preserves the character vector instead of converting to factor.

#3. If you have the name of a variable stored in an object, e.g. var <- "mpg", how can you extract the reference variable from a tibble?

#4. Practice referring to non-syntactic names in the following data frame by:


annoying <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(length(`1`))
)

# 1
annoying$`1`

#2
plot(annoying$`1`, annoying$`2`)
ggplot(annoying, aes(x=`1`, y=`2`))+geom_point()

#3
annoying2<-mutate(annoying, 
                  `3`=`1`/`2`)

annoying3<-rename(annoying2,
    three=`3`, one=`1`, two=`2`)



#* Extracting the variable called 1.

#* Plotting a scatterplot of 1 vs 2.

#* Creating a new column called 3 which is 2 divided by 1.

#* Renaming the columns to one, two and three.

#5. What does tibble::enframe() do? When might you use it?


tibble::enframe(c(a = 5, b = 4))
tibble::enframe(c(a = 5, b = c(4,7)))
tibble::enframe(list(one = 1, two = 2:3, three = 4:6))



#provides a tibble with the name of the variable as the column variable and the value in a new variable. If a list the value would correspond to the list.


#6. What option controls how many additional column names are printed at the footer of a tibble?

#n_extra argument in print function on a tibble

package?tibble
?print.tbl

print(nycflights13::flights, n_extra=5)
