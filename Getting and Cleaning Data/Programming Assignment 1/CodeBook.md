# Code Book

## Variables

### subject
An identifier of the subject who carried out the experiment.

Class: factor w/ 30 levels (ranges from integers 1 to 30)

### activity
The activity being performed by the person.

Class: factor w/ 6 levels (Laying, Sitting, Standing, Walking, Walking Downstairs,
Walking Upstairs)

### domain
The domain which the measured variable belong to.

Class: factor w/ 2 levels (time, frequency)

### signal
The variable signals represented by each observation. This was put into a single column to
simplify summarization of the data. All possible variable signals are listed below.

Class: factor w/ 20 levels
* Body Acceleration in the X axis
* Body Acceleration in the Y axis
* Body Acceleration in the Z axis
* Gravity Acceleration in the X axis
* Gravity Acceleration in the Y axis
* Gravity Acceleration in the Z axis
* Body Acceleration Jerk in the X axis
* Body Acceleration Jerk in the Y axis
* Body Acceleration Jerk in the Z axis
* Body Gyroscope in the X axis
* Body Gyroscope in the Y axis
* Body Gyroscope in the Z axis
* Body Gyroscope Jerk in the X axis
* Body Gyroscope Jerk in the Y axis
* Body Gyroscope Jerk in the Z axis
* Body Acceleration Magnitude
* Gravity Acceleration Magnitude
* Body Acceleration Jerk Magnitude
* Body Gyroscope Magnitude
* Body Gyroscope Jerk Magnitude

### statistic
The type of statistic computed at each observation.

Class: factor w/ 2 levels (mean, std)

### measure
The numeric value measured in the observation. It represents the value measured by the
signal in the specific domain when the subject is performing the associated activity.

Class: numeric (ranges from [-1,1])

### mean_activity
Mean summarization of the measure grouped by each signal and activity.

Class: numeric

### mean_subject
Mean summarization of the measure grouped by each signal and subject.

Class numeric


## Transformations Performed on the Data

All the measurement variables has been put into a single column, as they all represent a
type of signal measure. This type is held by the **signal** column and the measured
value is held by the **measure** column. The dimension was not separated from the signal,
since some instances would have missing values, because of the magnitude variables that
are independent of any dimension.

The domain was separated from those variables and put into the **domain** column.
There are only two domains: 'time' or 'frequency'.

Also, to separate between mean and standard deviation kinds of calculations, those were
put into the **statistic** column.

All of these data transformations were done via the **tidyr**, **dplyr** and **stringr**
packages.