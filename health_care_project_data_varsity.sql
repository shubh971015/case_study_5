create database heathcare_data_varsity;
use heathcare_data_varsity;
SELECT * FROM heathcare_data_varsity.`papollo-healtcare-dataset`;
alter table `papollo-healtcare-dataset` rename papollo; 
select * from papollo;
truncate table papollo;
alter table papollo rename column ï»¿Patient_ID to Patient_ID;
LOAD DATA INFILE
'E:\\zzz.csv'
INTO TABLE papollo
FIELDS TERMINATED BY ','
enclosed by '"'
LINES TERMINATED BY '\n'
IGNORE 1 rows;
select * from papollo;
select distinct(feedback) from papollo;
-- 1 Can you provide insights into the most prevalent diagnosis among patients
select diagnosis,count(diagnosis) from papollo
group by diagnosis
order by count(diagnosis)
; 
-- 2) How does the distribution of bed occupancy types correlate with billing amounts
select * from papollo;
select Bed_Occupancy,round(avg(`Billing Amount`)) bed_occupancy from papollo
group by Bed_Occupancy 
order by Bed_Occupancy desc ;
-- 3_Could you highlight any significant trends or patterns in the types of tests conducted?
select distinct(test) from papollo;

-- 4 Which doctor received the highest average feedback rating, and what factors may have contributed to this?
select * from papollo;
select doctor ,avg(feedback) from papollo
group by doctor 
order by avg(feedback)
desc
;
-- 5 Can you demonstrate the effectiveness of follow-up appointments in improving patient outcomes?
select * from papollo;
-- 6 How does the average length of stay vary across different diagnosis categories?
select  diagnosis,avg(datediff(Discharge_Date,Admit_Date)) as avg_stay
from papollo
group by diagnosis;
-- 7 Could you identify any outliers or anomalies in the billing amounts?
explain select * from papollo;
--  8 Can you showcase any notable correlations between patient feedback ratings and billing amounts
 select 
	case
		when feedback >=4.5 then 'excellent'
        when feedback >=4 then 'very good'
        when feedback >=3.5 then 'good'
        when feedback >=3 then 'satisfactory'
        else 'bad result'
        end as feedback_category,
avg(`billing amount`) from papollo
group by feedback_category;
-- 9 How many patients were admitted for each diagnosis?
 select * from papollo;
select count(*) , diagnosis from papollo
group by diagnosis
order by count(*) desc ;
-- 10 What is the distribution of bed occupancy types among the patients?
select count(*) , Bed_Occupancy from papollo
group by Bed_Occupancy
order by count(*) desc ;
-- 11 Which bed occupancy type has the highest average billing amount?
 select * from papollo;
select count(*), Bed_Occupancy,avg(`billing amount`) from papollo
group by Bed_Occupancy
order by count(*) desc;
-- 12 What are the top 5 most common tests conducted among the patients?
select count(*), test from papollo
group by test
order by count(*) desc;
-- 13 How many patients were treated by each doctor?
select count(*), doctor from papollo
group by doctor
order by count(*) desc;
-- 14 How many patients had a follow-up appointment scheduled after discharge?

select count(*) as follow_up_no from papollo
where `followup date` is not null;
-- What is the average time (in days) between discharge and follow-up appointment?
select * from papollo;

select avg(datediff(`Followup Date`,`Discharge_Date`)) as avg_follow_up_days
from papollo
where `followup date` is not null and `Discharge_Date` is not null;
-- 16 What is the average billing amount for patients without health insurance?
-- select * from papollo
-- where `Health Insurance Amount` = 0;
select avg(`Billing Amount`) as avg_bill_amount_without_healtha_insurance
from papollo
where `Health Insurance Amount` = 0; --   there are no patients without health insurance in the dataset.
-- 17 How many patients were admitted in each month
select extract(MONTH FROM admit_date) AS MONTHLY_PATIENT_ADMIT,count(patient_id) 
from papollo
group by  extract(MONTH FROM admit_date)
order by  extract(MONTH FROM admit_date) ASC;









        



