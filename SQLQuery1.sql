Use Hospital
--Q1
select w.Name,COUNT(p.Id) CountOfPatients
from Patients p join Wards w
on w.Id=p.WardId
Group By w.Name

--Q2
select AVG(Salary) AverageSalary
from Consultants

--Q3
select MIN(salary) MinSalary,MAX(salary) MaxSalary,AVG(Salary) AverageSalary,Sum(salary) TatalSalary
from Consultants

--Q4
select WardId ,COUNT(p.Id) NumberOfPatients
from Patients p Join Wards w
on w.Id=p.WardId
Group By WardId
Order by NumberOfPatients Desc

--Q5
Select p.Id, SUM(Quantity) TotalQuantity
From DrugAdministrations DA Join Patients p
on p.Id=DA.PatientId
Group By p.Id

--Q6
Select PatientId,Count(*) NumOfDrugs
from DrugAdministrations 
Group By PatientId

--Q7
Select w.Name,COUNT(p.Id) NumOfPatients
from Wards w Left Join Patients p
on w.Id=p.WardId
Group By w.Name

--Q8
Select W.Name,AVG(salary) AVGSalary
From Wards w join Nurses n
on w.Id=n.ServesInWardId
Group By w.Name

--Q9
Select w.Name ,COUNT(p.Id) NumOfPatients
From Wards w Join Patients p
on w.Id=p.WardId
Group By w.Name
Having COUNT(p.Id)>3

--Q10
Select P.Id,p.Name,Count(*) NumOfTimes
From Patients p Join DrugAdministrations DA
on p.Id=DA.PatientId
Group By p.Id,p.Name
Having COUNT(*)>5

--Q11
Select Name ,Salary
From Consultants
Where Salary>(Select AVG(salary)From Consultants )

--Q12
Select Name,Salary
From  Nurses
Where Salary>(Select AVG(salary) From Nurses)

--Q13*
Select Name,Id,WardId
From Patients 
Where WardId=(Select Top 1 WardId
From Patients 
Group By WardId
Order by Count(*) desc)

--Q14
select Name,Salary
From Consultants
Where Salary=(Select Max(Salary) From Consultants)

--Q15
Select PatientId ,Count(*)
From DrugAdministrations
Group By PatientId
Having Count(*)>1

--Q16
Select PatientId ,Count(*)
From DrugAdministrations
Group By PatientId
Having Count(*)=0

--Q17
Select p.Id,p.Name ,COUNT(*) NumberOfDA
From Patients p Join DrugAdministrations DA
on p.Id=DA.PatientId
Group By P.Name,p.Id

--Q18
Select p.Id,p.Name ,SUM(DA.Quantity)TotalOfDA
From Patients p Join DrugAdministrations DA
on p.Id=DA.PatientId
Group By P.Name,p.Id

--Q19
Select c.Id,c.Name
From Consultants c Cross Join(select AVG(Salary) AvSalary
From Consultants )AvTable
Where c.Salary= AvTable.AvSalary

--Q20*
SELECT PatientId, SUM(Quantity) AS TotalQ
FROM DrugAdministrations
GROUP BY PatientId
HAVING SUM(Quantity) > (
    SELECT AVG(TotalQuantity)
    FROM (
        SELECT PatientId, SUM(Quantity) AS TotalQuantity
        FROM DrugAdministrations
        GROUP BY PatientId
    ) AS T
)

--Q21
Select *
into PatientCopy
from Patients

--Q22
Select Id,Name,DOB
into PatientCopy1
from Patients

--Q23
Select id,Name,Salary
into ConsultantCopy
from Consultants

--Q24
Select p.Name PName,w.Name WName
into PatientWardCopy
from Patients p Join Wards w
on w.Id=p.WardId

--Q25
Select P.Name PName,c.Name CName
into PatientConsultantCopy
From Patients p Join PatientExaminations PE
on p.Id=PE.PatientId
join Consultants c
on c.Id=pE.ConsultantId

--Q26
select Name ,Salary 
into ConsultantCopy1
From Consultants
Where Salary>50000

--Q27
select Name,DOB
into  PatientCopy3
from Patients
where DOB <'2000-01-01'

--Q28
select n.Name NName,w.Name WName
into NurseCopy
from Nurses n join Wards w
on w.Id=n.ServesInWardId
where n.Salary>30000

--Q29
Select w.Name WName,Count(p.Id) CountOfPatients
into PatientWardCopy1
From Patients p join Wards w
on w.Id=p.WardId
Group by w.Name

--Q30
select p.Id PID,Sum(Quantity) Total
into DACopy
from Patients p join DrugAdministrations DA
on p.Id=dA.PatientId
Group By p.Id

--Q31
go
Create Function dbo.CalculateAge(@DateOfBirth Date)
Returns int
as
Begin
RETURN DATEDIFF(YEAR, @DateOfBirth, GETDATE())
end
go
--Q32
Create Function dbo.CalculateAnnualSalary(@Salary decimal(8,2))
Returns Decimal(8,2)
as
Begin
return @Salary*12
end

--Q33
Create Function dbo.TotalCost(@Quantity int,@UnitPrice Decimal(8,2))
Returns Decimal(8,2)
as
Begin
Return @Quantity*@UnitPrice
End

-- From Q34 to Q39 Out
--Q40
Select 
    p.Name,
    COUNT(DA.PatientId) AS NumberOfAdministrations,
    SUM(DA.Quantity) AS TotalQuantity,
    AVG(DA.Quantity) AS AvQuantity
From Patients p
join DrugAdministrations DA
    on p.Id = DA.PatientId
Group By p.Id, p.Name

--Q41*
Select w.Name, Count(p.Id) As PatientCount
From Wards w
Join Patients p
    On p.WardId = w.Id
Group By w.Id, w.Name
Having Count(p.Id) > (
    Select Avg(PatientCount)
    From (
        Select WardId, Count(Id) As PatientCount
        From Patients
        Group By WardId
    ) As T
)

--Q42
Select p.Id, p.Name
Into PatientsMoreThan5
From Patients p
Join DrugAdministrations DA
    On p.Id = DA.PatientId
Group By p.Id, p.Name
Having Count(DA.PatientId) > 5

--Q43
Select Name, Salary MonthlySalary, Salary * 12 AnnualSalary
Into ConsultantSalaries
From Consultants;

-- From Q44 to Q46 Out
