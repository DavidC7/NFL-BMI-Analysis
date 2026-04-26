-- ****VARIANCE & STANDARD DEVIATION ****

--BMI standard deviation 4.71/4.71
SELECT ROUND(stddev_pop(bmi), 2) AS stddev_pop_bmi, 
ROUND(stddev_samp(bmi), 2) AS stddev_samp_bmi
FROM bmi;

--BMI variance 22.21/22.22
SELECT ROUND(var_pop(bmi), 2) AS var_pop_bmi,
ROUND(var_samp(bmi), 2) AS var_samp_bmi
FROM bmi;

