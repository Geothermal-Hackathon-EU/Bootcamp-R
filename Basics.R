

##### Start with the basics 
# R has six basic types of data;
# 1. numeric - any numeric value like whole numbers, decimal, floating... 
# 2. integer -  whole numbers
# 3. logical - Boolean (TRUE or FALSE)
# 4. character - any string of characters,
# 5. complex - for complex numbers (too complex for me, so we will cover them later)
# 6. raw - never dealt with that
# so, we will deal with only the first 4.
# 


# first things first: we can do a bunch of calculations in R by directly writing them out, like

1 + 2

3*4

5/6

pi * 7

## interesting note, R knows what 'pi' is, so don't use it as a variable name

pi = 5
## you can change 'pi'
pi * 7

########## its not very useful just doing direct  calculations so lets check out the assignment. 
########## In R you can use '<-' or '=' to assign value to a variable

#### Numeric
num1 <- 10
num2 = 14

sumNum = num1 + num2
sumNum

## use the class() function to check its class
class(sumNum)

#### Character
char1 <- "Hello"
char2 <- "World"

class(char1)

#### Boolean: Note: R accepts T or F & TRUE or FALSE (in CAPS) but not True / False
boo1 <- TRUE
boo2 = F
boo3 <- True

class(boo1)



############## graduating from data types to data structures ################
## R has four basic data structure
## 1. Vectors
## 2. Matrix and Arrays
## 3. Lists
## 4. Data Frame


## lets play with a matrix

matrix(c(1,2,3,4,5,6,7,8),nrow = 2,byrow = F)

matrix(c(1,2,3,4,5,6,7,8,9),nrow = 2,byrow = T) + matrix(1:10,nrow = 2)

matrix(1:10,nrow = 2) + matrix(11:20,nrow = 2)
matrix(1:10,nrow = 2) * matrix(11:20,nrow = 2)
matrix(1:10,nrow = 2) %*% matrix(11:20,nrow = 2)

# R will 'Recycle' the value in case of the first Matrix. it provides error/warning but completes the process


mat1 <- matrix(1:16, nrow = 4, byrow = TRUE)
mat1

## Creating an array using the array function, using 1 to 16, creating 2 arrays of dimension 2 rows and 4 columns
arr1 <- array(1:16)
arr1 <- array(1:16, dim = c(2, 4, 2))
arr1

## we can use the rownames and colnames functions to name the arrays for easier access later
rownames(mat1) <- c("A", "B", "C", "D")
colnames(mat1) <- c("a", "b", "c", "d")


mat1["B","a"]


### the constrain on Matrix and Arrays are that all elements need to be of the 
### same type. Lists do not have that restriction

list1 <- list(c("dog", "cat", "horse", "cow"),
               c(TRUE, TRUE, FALSE, TRUE, FALSE),
               matrix(1:15, nrow = 3))
list1

names(list1) <- c("animals", "eval", "num_mat")
list1


### Data frames: Getting started with with the big power of R
## it is what inspired Pandas in Python


df1 <- data.frame(model = c("a","b","a","b","c","d","d","d","a","e"),
                  height = c(12,13.5,14,11,12.24,13,17,15,16,15.5),
                  width = c(34,28,24,32,29,35,33,27,32,35))

## lets look at the structure of the data
class(df1)
str(df1)

## how to run basic statistics
mean(df1$height)
mean(df1$width)

summary(df1$height)

## how to filter data


df1$height>=15

df1[df1$height>=15&df1$width<33,]

## data.frame[row.index, column.index]

df1[df1$height>=15,c("height","width")]

long_df <- df1[df1$height>=15,]

df1[df1$height>=15 & df1$width <=27,]

##### ordering dataframes

df1[order(df1$height),]
df1[order(df1$height,decreasing = T),]
 


df2 <- data.frame(model = c("a","b","a","b","c","d","d","d","a","e"),
                  height = c(11,12.5,15,13,14,13,18,21,19,17),
                  width = c(33,28,23,32,30,34,31,26,33,36))


df2 %>%
  group_by(model) %>%
  summarise(mean.height = mean(height))






