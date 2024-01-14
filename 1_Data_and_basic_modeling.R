# Load mlr3 library
library(mlr3)

#------ Creating tasks

### 1. Tasks from a dictionary using tsk() 
tsk_mtcars = tsk('mtcars')
tsk_mtcars


### 2. Your own regression tasks with the function as_task_regr()
mtcars_subset = subset(mtcars, select = c("mpg", "cyl", "disp"))

# View the structure of the data.frame
str(mtcars_subset)

# Create your own task
tsk_mtcars2 = as_task_regr(mtcars_subset, target = "mpg", id = "cars")
tsk_mtcars2


#------ Plot the task using mlr3viz  ?
library(mlr3viz)
autoplot(tsk_mtcars2, type = "pairs")


#------ Retrieving Data

### 1. Task dimensions using $nrow and $ncol

c(tsk_mtcars$nrow, tsk_mtcars$ncol)


### 2. Features and target columns using $feature_names and $target_names
c(Features = tsk_mtcars$feature_names, Target = tsk_mtcars$target_names)


### 3. Row IDs using $row_ids
head(tsk_mtcars$row_ids)

# Rows are not features and are not used when training but are metadata that allows 
# us to access individual elements


### 4. Data using $data() returning a data.table object
tsk_mtcars$data()

# $data() method has optional arguments rows and cols to specify subsets of data to retrieve
tsk_mtcars$data(rows=c(1,3,5), cols = tsk_mtcars$feature_names)


### 5. Using standard R e.g to extract summary from a task
summary(as.data.table(tsk_mtcars))

summary(as.data.table(tsk_mtcars$data(cols = c('mpg', 'cyl', 'disp'))))

#----- Task Mutators

### 1. Modifying the given task by subsetting by columns using $select() and by rows using $filter()

tsk_mtcars_small = tsk("mtcars") # initialize with the full task
tsk_mtcars_small$select("cyl") # keep only one feature
tsk_mtcars_small$filter(2:3) # keep only these rows
tsk_mtcars_small$data()


### 2. Using $clone to modify a task while keep the original object intact
# the right way
tsk_mtcars = tsk("mtcars")
tsk_mtcars_right = tsk_mtcars$clone()
tsk_mtcars_right$filter(1:2)
# original data unaffected
tsk_mtcars$head()
tsk_mtcars_right$head()


### 3. Adding extra rows and columns to a task using $rbind() and $cbind()
tsk_mtcars_small$cbind( # add another column
  data.frame(disp = c(150, 160))
)
tsk_mtcars_small$rbind( # add another row
  data.frame(mpg = 23, cyl = 5, disp = 170)
)
tsk_mtcars_small$data()






