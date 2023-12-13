-- Active: 1675484766118@@127.0.0.1@3306@classicmodels
-- LEFT(col_name, no_of_characters) extracts strings 
-- starting from left and accepts alias

-- RIGHT(col_name, no_of_characters) extracts strings
-- starting from right and accepts alias

-- SUBSTR(string, start, length) Extracts substring from 
-- a string (starting at any position)

-- CONCAT(string1,string2, string3, ...) joins the set of 
-- strings to form one strng

-- CAST(expression AS datatype) this changes the datatype of 
-- the expression(a column) into the passed datatype

-- POSITON(substring IN string) gets the position of first occurance of
-- substring in a string. its result is used for further operation

-- STRPOS(string, substring) REturns position of a substring in a string

--COALESCE(val1, val2, val3, ...) returns the first non null value in the list

SELECT *
FROM orders;

SELECT
    REVERSE(PARSER(REPLACE(REVERSE(orderDate), '-'), 1)) AS YEAR
    ,REVERSE(PARSER(REPLACE(REVERSE(orderDate), '-', '.'), 2)) AS Month
    ,REVERSE(PARSER(REPLACE(REVERSE(orderDate), '-', '.'), 3)) AS Day
FROM orders; string_