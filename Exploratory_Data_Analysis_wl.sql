select *
from layoffs_staging2;

select MAX(total_laid_off), MAX(percentage_laid_off)
from layoffs_staging2;

select *
from layoffs_staging2
where percentage_laid_off = 1
order by total_laid_off desc;

select * 
from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc;

select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select min(`date`), max(`date`)
from layoffs_staging2;

select industry, sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc;

select *
from layoffs_staging2;

select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;

select Year(`date`), sum(total_laid_off)
from layoffs_staging2
group by Year(`date`)
order by 1 desc;

select stage, sum(total_laid_off)
from layoffs_staging2
group by stage
order by 2 desc;

Select substring(`date`, 6, 2) as `month`,
sum(total_laid_off)
From layoffs_staging2
group by `month`
order by 2 desc;

select substring(`date`, 1, 7) as `month`,
sum(total_laid_off)
from layoffs_staging2
where substring(`date`, 1, 7) is not null
group by `month`
order by 1 asc;

with Rolling_total as
(
select substring(`date`, 1, 7) as `month`,
sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`, 1, 7) is not null
group by `month`
order by 1 asc
)
select `month`, total_off,
sum(total_off) over(order by `month`) as rolling_total
from Rolling_total;

select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select company, Year(`date`),
sum(total_laid_off)
from layoffs_staging2
group by company, Year(`date`)
order by 3 desc;

with company_year (company, `year`, total_laid_off) as 
(
select company, Year(`date`),
sum(total_laid_off)
from layoffs_staging2
group by company, Year(`date`)
), Company_Year_Rank as
(
select *,
dense_rank() over(partition by `year` order by total_laid_off desc) as Ranking
from company_year
where `year` is not null
)
select *
from Company_Year_Rank
where ranking <= 5;

