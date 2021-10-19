/* I. CREATE TABLES */

-- faculty(khoa)
create table faculty (
	id number primary key,
	name nvarchar2(30) not null
);

-- subject(Môn h?c)
create table subject(
	id number primary key,
	name nvarchar2(100) not null,
	lesson_quantity number(2,0) not null
);

-- student(sinh vien)
create table student (
	id number primary key,
	name nvarchar2(30) not null,
	gender nvarchar2(10) not null,
	birthday date not null,
	hometown nvarchar2(100) not null,
	scholarship number,
	faculty_id number not null constraint faculty_id references faculty(id)
);

-- exam management(qu?n lý thi)

create table exam_management(
	id number primary key,
	student_id number not null constraint student_id references student(id),
	subject_id number not null constraint subject_id references subject(id),
	number_of_exam_taking number not null,
	mark number(4,2) not null
);



/*================================================*/

/* II. INSERT SAMPLE DATA */

-- subject
insert into subject (id, name, lesson_quantity) values (1, 'C? s? d? li?u', 45);
insert into subject values (2, 'Trí tu? nhân t?o', 45);
insert into subject values (3, 'Truy?n tin', 45);
insert into subject values (4, '?? h?a', 60);
insert into subject values (5, 'V?n ph?m', 45);


-- faculty
insert into faculty values (1, 'Anh - V?n');
insert into faculty values (2, 'Tin h?c');
insert into faculty values (3, 'Tri?t h?c');
insert into faculty values (4, 'V?t lý');


-- student
insert into student values (1, 'Nguy?n Th? H?i', 'N?', to_date('19900223', 'YYYYMMDD'), 'Hà N?i', 130000, 2);
insert into student values (2, 'Tr?n V?n Chính', 'Nam', to_date('19921224', 'YYYYMMDD'), 'Bình ??nh', 150000, 4);
insert into student values (3, 'Lê Thu Y?n', 'N?', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 150000, 2);
insert into student values (4, 'Lê Thu Y?n', 'N?', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 170000, 2);
insert into student values (5, 'Tr?n Anh Tu?n', 'Nam', to_date('19901220', 'YYYYMMDD'), 'Hà N?i', 180000, 1);
insert into student values (6, 'Tr?n Thanh Mai', 'N?', to_date('19910812', 'YYYYMMDD'), 'H?i Phòng', null, 3);
insert into student values (7, 'Tr?n Th? Thu Th?y', 'N?', to_date('19910102', 'YYYYMMDD'), 'H?i Phòng', 10000, 1);


-- exam_management
insert into exam_management values (1, 1, 1, 1, 3);
insert into exam_management values (2, 1, 1, 2, 6);
insert into exam_management values (3, 1, 2, 2, 6);
insert into exam_management values (4, 1, 3, 1, 5);
insert into exam_management values (5, 2, 1, 1, 4.5);
insert into exam_management values (6, 2, 1, 2, 7);
insert into exam_management values (7, 2, 3, 1, 10);
insert into exam_management values (8, 2, 5, 1, 9);
insert into exam_management values (9, 3, 1, 1, 2);
insert into exam_management values (10, 3, 1, 2, 5);
insert into exam_management values (11, 3, 3, 1, 2.5);
insert into exam_management values (12, 3, 3, 2, 4);
insert into exam_management values (13, 4, 5, 2, 10);
insert into exam_management values (14, 5, 1, 1, 7);
insert into exam_management values (15, 5, 3, 1, 2.5);
insert into exam_management values (16, 5, 3, 2, 5);
insert into exam_management values (17, 6, 2, 1, 6);
insert into exam_management values (18, 6, 4, 1, 10);



/*================================================*/

/* III. QUERY */


 /********* A. BASIC QUERY *********/

-- 1. Li?t kê danh sách sinh viên s?p x?p theo th? t?:
--      a. id t?ng d?n
   select * 
    from student s 
;
--      b. gi?i tính
select *
   from student s
   order by gender ASC
;
--      c. ngày sinh T?NG D?N và h?c b?ng GI?M D?N
  select * 
    from student s
    order by birthday ASC,scholarship DESC
;

-- 2. Môn h?c có tên b?t ??u b?ng ch? 'T'
    select name
    from subject 
    where name like 'T%'
;
-- 3. Sinh viên có ch? cái cu?i cùng trong tên là 'i'
select name
from student s
where name like '%i';
-- 4. Nh?ng khoa có ký t? th? hai c?a tên khoa có ch?a ch? 'n'
select name
from faculty 
where name like '_n%'
;
-- 5. Sinh viên trong tên có t? 'Th?'

select name
from student s
where name like '%Th?%'
;
-- 6. Sinh viên có ký t? ??u tiên c?a tên n?m trong kho?ng t? 'a' ??n 'm', s?p x?p theo h? tên sinh viên

select name 
from student s
where name between 'A' and 'M'
order by name ASC
;
--  Sinh viên có h?c b?ng l?n h?n 100000, s?p x?p theo mã khoa gi?m d?n

select *
from student	
where scholarship > 100000
order by faculty_id DESC
;
-- 8. Sinh viên có h?c b?ng t? 150000 tr? lên và sinh ? Hà N?i

select *
from student
where scholarship >= 150000 AND hometown like 'Hà N?i';
-- 9. Nh?ng sinh viên có ngày sinh t? ngày 01/01/1991 ??n ngày 05/06/1992
select *
from student s
where birthday  between to_date('19910101', 'YYYYMMDD') and to_date('19920605', 'YYYYMMDD')
;
-- 10. Nh?ng sinh viên có h?c b?ng t? 80000 ??n 150000
select *
from student
where scholarship BETWEEN 80000 AND 150000
;
-- 11. Nh?ng môn h?c có s? ti?t l?n h?n 30 và nh? h?n 45
select *
from subject
where lesson_quantity BETWEEN 30 AND 45
;


-------------------------------------------------------------------

/********* B. CALCULATION QUERY *********/

-- 1. Cho bi?t thông tin v? m?c h?c b?ng c?a các sinh viên, g?m: Mã sinh viên, Gi?i tính, Mã 
		-- khoa, M?c h?c b?ng. Trong ?ó, m?c h?c b?ng s? hi?n th? là “H?c b?ng cao” n?u giá tr? 
		-- c?a h?c b?ng l?n h?n 500,000 và ng??c l?i hi?n th? là “M?c trung bình”.
    select s.id,gender,faculty_id,scholarship,
    case 
	when scholarship >500000 
	THEN N'hoc bong cao'
	else N'M?c trung bình'
	end 
	from student s  inner join faculty  on s.faculty_id = faculty.id;
-- 2. Tính t?ng s? sinh viên c?a toàn tr??ng
select  count(id) as sinhvien
from student s;
-- 3. Tính t?ng s? sinh viên nam và t?ng s? sinh viên n?.
select count(id),
        count(case when gender = 'Nam' then 1 end ) as Nam,
		count(case when gender = 'N?' then 1 end) as Nu
from student;
-- 4. Tính t?ng s? sinh viên t?ng khoa (ch?a c?n JOIN)
select f.name as khoa , count(s.id) as TongSV
from faculty f , student s 
where f.id = s.faculty_id
group by f.name;
-- 5. Tính t?ng s? sinh viên c?a t?ng môn h?c
select  sj.name , count(s.id) as TongSV
from subject sj inner join exam_management e on sj.id = e.subject_id
 inner join student s on  e.student_id = s.id
 group by sj.name ;

-- 6. Tính s? l??ng môn h?c mà sinh viên ?ã h?c
select count(sj.id) as tongmonhoc,s.name as sinhvien
from  subject sj inner join exam_management e on sj.id = e.subject_id
 inner join student s on  e.student_id = s.id
 group by s.name;
-- 7. T?ng s? h?c b?ng c?a m?i khoa	
select  f.name , count(s.scholarship)
from faculty f inner join student s  on  f.id = s.faculty_id
group by  f.name;
-- 8. Cho bi?t h?c b?ng cao nh?t c?a m?i khoa
select f.name, max(s.scholarship)as MaxHocBong
from student s inner join faculty f on s.faculty_id =f.id
group by f.name;
-- 9. Cho bi?t t?ng s? sinh viên nam và t?ng s? sinh viên n? c?a m?i khoa
select f.name, s.gender, count(*) 
from student s,faculty f
where s.faculty_id=f.id  
group by f.name, s.gender;

-- 10. Cho bi?t s? l??ng sinh viên theo t?ng ?? tu?i
select s.birthday, count(s.id) 
from student s
group by s.birthday;

-- 11. Cho bi?t nh?ng n?i nào có h?n 2 sinh viên ?ang theo h?c t?i tr??ng
select s.hometown,count(s.id)  
from student s 
group by s.hometown 
having count(s.id) > 2;
-- 12. Cho bi?t nh?ng sinh viên thi l?i ít nh?t 2 l?n
select s.name, e.subject_id, count(e.number_of_exam_taking) 
from exam_management e, student s 
where s.id = e.student_id
group by s.name, e.subject_id 
having count(number_of_exam_taking) >= 2;
-- 13. Cho bi?t nh?ng sinh viên nam có ?i?m trung bình l?n 1 trên 7.0 
	select s.name,avg(e.mark)
    from  student s ,exam_management e 
	where  s.id = e.student_id and s.gender = 'Nam' and e.number_of_exam_taking = 1
	group by s.name , e.mark
	having avg(e.mark) >= 7.0 ;
-- 14. Cho bi?t danh sách các sinh viên r?t trên 2 môn ? l?n thi 1 (r?t môn là ?i?m thi c?a môn không quá 4 ?i?m)
select s.name 
from student s, exam_management e
where e.number_of_exam_taking = 1 and e.mark <= 4 and s.id = e.student_id 
group by s.name;
-- 15. Cho bi?t danh sách nh?ng khoa có nhi?u h?n 2 sinh viên nam (ch?a c?n JOIN)
select f.name, count(s.gender) 
from faculty f, student  s
where s.faculty_id = f.id
and s.gender = 'Nam'
group by f.name
having count(student.gender)>2;
-- 16. Cho bi?t nh?ng khoa có 2 sinh viên ??t h?c b?ng t? 200000 ??n 300000
select f.name, count(s.id) 
from student s ,faculty f 
where s.scholarship >=200000 and s.scholarship <= 300000
group by f.name
having count(s.id) =2 ;
-- 17. Cho bi?t sinh viên nào có h?c b?ng cao nh?t

select s.name, max(s.scholarship) 
from student s
where s.scholarship = (select max(s.scholarship) from student s)
group by s.name;
-------------------------------------------------------------------

/********* C. DATE/TIME QUERY *********/

-- 1. Sinh viên có n?i sinh ? Hà N?i và sinh vào tháng 02
select s.name
from student s 
where s.hometown = 'Hà N?i' and to_char(birthday,'MM') = '02';

-- 2. Sinh viên có tu?i l?n h?n 20
select s.name, current_year - to_number(to_char(s.birthday, 'YYYY')) as tuoi
from student s, (select to_number(to_char(sysdate, 'YYYY')) current_year from dual)
where current_year - to_number(to_char(s.birthday, 'YYYY')) > 20;
-- 3. Sinh viên sinh vào mùa xuân n?m 1990

select s.name
from student s
where to_char(s.birthday, 'MM') in ('01', '02', '03') and to_char(s.birthday, 'YYYY') = '1990';

-------------------------------------------------------------------


/********* D. JOIN QUERY *********/

-- 1. Danh sách các sinh viên c?a khoa ANH V?N và khoa V?T LÝ
select * 
from student  s
INNER JOIN faculty f on s.faculty_id = f.id
WHERE f.id in (1,4);

-- 2. Nh?ng sinh viên nam c?a khoa ANH V?N và khoa TIN H?C
select * 
from student  s
INNER JOIN faculty f on s.faculty_id = f.id
WHERE f.id in (1,2) and s.gender = 'Nam';
-- 3. Cho bi?t sinh viên nào có ?i?m thi l?n 1 môn c? s? d? li?u cao nh?t
select * 
from student s
INNER JOIN exam_management e on e.student_id = s.id
INNER JOIN subject  sj on e.subject_id = sj.id
where sj.id = 1 and e.mark = (select MAX(mark) from exam_management where subject_id = 1);
-- 4. Cho bi?t sinh viên khoa anh v?n có tu?i l?n nh?t.

--
--select * from student as s
--INNER JOIN faculty as f on s.faculty_id = f.id
--WHERE f.id = 1 and (YEAR(NOW())- YEAR(birthday))  = (select MAX(YEAR(NOW())-YEAR(birthday)) from student where faculty_id = 1)

select s.name, f.name, current_year - to_number(to_char(s.birthday, 'YYYY')) age
from faculty f , student s, (select to_number(to_char(sysdate, 'YYYY')) current_year from dual)
where f.name = 'Anh - V?n' and s.faculty_id = f.id
and current_year - to_number(to_char(s.birthday, 'YYYY'))=(select max(current_year - to_number(to_char(s.birthday, 'YYYY')))from student s);
-- 5. Cho bi?t khoa nào có ?ông sinh viên nh?t
select faculty.name, count(student.id) 
from faculty, student    
where faculty.id = student.faculty_id 
group by faculty.name having count(student.faculty_id)>= all(select count(student.id) from student group by student.faculty_id);
-- 6. Cho bi?t khoa nào có ?ông n? nh?t
select f.name, s.gender, count(gender) as Nu 
from faculty f,student s
where f.id = s.faculty_id and s.gender = N'N?'
group by f.name, s.gender 
having count(s.faculty_id)>= all(select count(s.gender) from student s where s.gender =N'N?' group by s.faculty_id);
-- 7. Cho bi?t nh?ng sinh viên ??t ?i?m cao nh?t trong t?ng môn
select s.name , max(mark)
from exam_management e, student s
where  e.student_id = s.id
group by s.name;
-- 8. Cho bi?t nh?ng khoa không có sinh viên h?c
select f.name, count(s.id) 
from faculty f 
inner join student s on f.id = s.faculty_id
group by f.name 
having count(s.id) = 0;

-- 9. Cho bi?t sinh viên ch?a thi môn c? s? d? li?u
select * from student  s
INNER JOIN exam_management e on e.student_id = s.id
WHERE subject_id not in(1);
-- 10. Cho bi?t sinh viên nào không thi l?n 1 mà có d? thi l?n 2
select * from student s
INNER JOIN exam_management e on e.student_id = s.id
WHERE e.number_of_exam_taking  = 2
