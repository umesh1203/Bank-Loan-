create database bank_loan;
use bank_loan;
create table bank(
 id int,
 address_state varchar(5),
 application_type varchar(20),
 emp_length varchar(20),
 emp_title varchar(75),
 grade varchar(5),
 home_ownership varchar(30),
 issue_date date,
 last_credit_pull_date DATE,
 last_payment_date DATE,
 loan_status varchar(30),
 next_payment_date DATE,
 member_id int,
 purpose varchar(30),
 sub_grade varchar(30),
 term varchar(30),
 verification_status varchar(30),
 annual_income float (10,2),
 dti float(10,2),
 installment float(10,2),
 int_rate float(10,2),
 loan_amount int,
 total_acc int,
 total_payment int
);
-- Total Loan Application
select * from bank;
-- total application 
select count(id) as total_loan_application from bank;
-- month on month sales +,- 
select month(issue_date) as months,count(id) as total_loan_application,
(count(id) - lag(count(id),1) over(order by month(issue_date)))/
lag(count(id),1) over(order by month(issue_date)) * 100 as pct
from bank
where month(issue_date) in (9,10)
group by month(issue_date);
-- Total Fund Received
select sum(loan_amount) as total_funded_amount from bank;
-- monthwise
select sum(loan_amount) as total_funded_amount from bank
where monthname(issue_date) = 'november';
-- month on month
select month(issue_date) as months,sum(loan_amount) as amount,
(sum(loan_amount) - lag(sum(loan_amount),1) over (order by month(issue_date)))/
lag(sum(loan_amount),1) over (order by month(issue_date)) * 100 as pct
from bank
where month(issue_date) in (1,2,3)
group by months;
-- total funded received
select sum(total_payment) as recevied_amount from bank;
-- selected month
select month(issue_date),sum(total_payment) as recevied_amount from bank
where month(issue_date) in (5,6)
group by month(issue_date);
-- month wise percentage
select monthname(issue_date) as months,sum(total_payment) as received_amount,
(sum(total_payment)-lag(sum(total_payment),1) over(order by monthname(issue_date)))/
lag(sum(total_payment),1) over(order by monthname(issue_date)) * 100 as pct
from bank
where monthname(issue_date) in ('june','july')
group by months;
-- average int rate
select * from bank;
select avg(int_rate) *100  as average_int_rate from bank;
-- monthwise
select month(issue_date) as months,round(avg(int_rate), 3) * 100 as interest_rate
from bank
where month(issue_date) in (11,12)
group by months;
-- average of dti
select * from bank;
select avg(dti) * 100  as Dti from bank;
-- monthwise
select month(issue_date) as months,avg(dti) * 100 as average from bank
where month(issue_date) in (11,12)
group by months;
-- good loan pct
select * from bank;
select count(case
when loan_status = 'Fully Paid' or loan_status = 'current' then id end)/count(id) * 100 as good_loan_pct
from bank;
-- good_loan_application
select count(id) as Total_appliocation from bank
where loan_status in ('Fully Paid','Current');
-- good_loan_funded amount
select sum(loan_amount) as Good_loan_amount from bank
where loan_status in ('Fully Paid','Current');
-- received money from good application
select sum(total_payment) as Good_loan_amount from bank
where loan_status in ('Fully Paid','Current');
-- bad loan percentage
select * from bank;
select count(case when loan_status = 'Charged Off' then id end)/
count(id) * 100 as pct
from bank;
-- bad loan application
select count(id) as bad_loan_application from bank 
where loan_status = 'Charged Off';
-- bad loan funded amount 
select sum(loan_amount) as Bad_loan_funded_amount 
from bank
where loan_status = 'Charged Off';
-- bad loan received amount
select sum(total_payment) as bad_loan_received_amount
from bank
where loan_status = 'Charged Off';
-- loan status view 
select loan_status,
count(id) as Total_application,
sum(loan_amount) as loan_amount,
sum(total_payment) as received_amount,
avg(int_rate)*100 as interest_rate,
avg(dti)*100 as debt_to_income_ration
from bank
group by loan_status; 
-- loan status view mtd
select loan_status,
sum(loan_amount) as loan_amount,
sum(total_payment) as received_amount
from bank
where month(issue_date) = 12
group by loan_status;
-- monthwise status
select month(issue_date) as Months,
monthname(issue_date) as monthsname,
count(id) as Total_Loan_application,
sum(loan_amount) as Total_amount_funded,
sum(total_payment) as Total_amount_received
from bank
group by months,monthsname
order by Months;
-- state wise
select address_state as Region,
count(id) as Total_Loan_application,
sum(loan_amount) as Total_amount_funded,
sum(total_payment) as Total_amount_received
from bank
group by Region
order by Region;
-- by loan term analysis
select * from bank;
select term,
count(id) as Total_application,
sum(loan_amount) as Total_Funded_amount,
sum(total_payment) as Total_received_amount
from bank
group by term
order by term;
-- employee length analysis
select emp_length as Employee_Length,
count(id) as Total_application,
sum(loan_amount) as Total_Funded_amount,
sum(total_payment) as Total_received_amount
from bank
group by Employee_Length
order by Employee_Length;
-- Loan purpose breakdown
select * from bank;
select purpose,
count(id) as Total_application,
sum(loan_amount) as Total_Amount_Funded,
sum(total_payment) as Total_Amount_Received
from bank
group by purpose;
-- analysis by house ownership
select home_ownership as Ownership,
count(id) as Total_application,
sum(loan_amount) as Total_Amount_Funded,
sum(total_payment) as Total_Amount_Received
from bank
group by Ownership 
order by Ownership;


















