Select *
from layoffs;

Create Table layoffs_staging
like layoffs;

Select *
from layoffs_staging;

insert layoffs_staging
select *
from layoffs;

Select *
from layoffs_staging;

select *,
row_number() over(partition by company, industry, total_laid_off, percentage_laid_off, `date`, location, country) as row_num
from layoffs_staging
;

with duplicate_cte as
(
select *,
row_number() over(partition by company, industry, total_laid_off, percentage_laid_off, `date`, location, country, stage, funds_raised_millions) as row_num
from layoffs_staging
)
select *
from duplicate_cte
where row_num > 1;

select *
from layoffs_staging
where company = 'Casper';

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from layoffs_staging2;

insert into layoffs_staging2
select *,
row_number() over(partition by company, industry, total_laid_off, percentage_laid_off, `date`, location, country, stage, funds_raised_millions) as row_num
from layoffs_staging;

select *
from layoffs_staging2
where row_num > 1
;

delete
from layoffs_staging2
where row_num > 1;

select *
from layoffs_staging2
where row_num > 1
;

select *
from layoffs_staging2;

Select company, (trim(company))
from layoffs_staging2;

update layoffs_staging2
set company = Trim(company);

select *
from layoffs_staging2;

Select distinct(industry)
from layoffs_staging2
order by 1;

select *
from layoffs_staging2
where industry like 'Crypto%';

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

select distinct(location)
from layoffs_staging2
order by 1;

select distinct(country)
from layoffs_staging2
order by 1;

Select distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1;

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';

select `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set date = str_to_date(`date`, '%m/%d/%Y');

alter table layoffs_staging2
modify column `date` DATE;

select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoffs_staging2
where industry is null
or industry = '';

select *
from layoffs_staging2
where company = 'Airbnb';

Select t1.industry, t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
    and t1.location = t2.location
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

update layoffs_staging2
set industry = null
where industry = '';

update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
    and t1.location = t2.location
set t1.industry = t2.industry
where t1.industry is null
and t2.industry is not null;

select *
from layoffs_staging2
where company like 'Bally%';

select t1.company, t1.location, t1.stage, t2.company, t2.location, t2.stage, t1.`date`, t2.`date`
from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
    and t1.location = t2.location
where t1.stage != t2.stage
and t1.`date` = t2.`date`;

select *
from layoffs_staging2
where company = 'Terminus';

update layoffs_staging2
set stage = 'Series C'
where company = 'Terminus';

select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

delete
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoffs_staging2;

alter table layoffs_staging2
drop column row_num;





