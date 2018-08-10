-- 1. What query would you run to get the total revenue for March of 2012?

SELECT MONTH(charged_datetime), YEAR(charged_datetime), SUM(billing.amount)
FROM billing
WHERE MONTH(charged_datetime)	= 03 AND YEAR(charged_datetime) = 2012;

-- 2. What query would you run to get total revenue collected from the client with an id of 2?

SELECT billing.client_id, SUM(billing.amount)
FROM billing
WHERE client_id = 2;

-- 3. What query would you run to get all the sites that client=10 owns?

SELECT sites.client_id, sites.domain_name
FROM sites
WHERE client_id = 10;

-- 4. What query would you run to get total # of sites created per month per year for the client with an id of 1? What about for client=20?

SELECT client_id, COUNT(domain_name) AS number_of_websites, MONTHNAME(created_datetime) AS month_created, YEAR(created_datetime) AS year_created
FROM sites
WHERE client_id = 1 OR client_id = 20
GROUP BY created_datetime;

-- 5. What query would you run to get the total # of leads generated for each of the sites between January 1, 2011 to February 15, 2011?

SELECT domain_name, COUNT(leads_id) AS number_of_leads, CONCAT_WS(' ', MONTHNAME(registered_datetime), DAY(registered_datetime), YEAR(registered_datetime))
FROM sites
LEFT JOIN leads ON sites.site_id = leads.site_id
WHERE registered_datetime between "2011/01/01" and "2011/02/15"
GROUP BY registered_datetime;

-- 6. What query would you run to get a list of client names and the total # of leads we've generated for each of our clients between January 1, 2011 to December 31, 2011?

SELECT CONCAT_WS(' ', clients.first_name, clients.last_name) AS client_name, COUNT(leads.leads_id) AS number_of_leads
FROM clients
LEFT JOIN sites ON clients.client_id = sites.client_id
LEFT JOIN leads ON leads.site_id = sites.site_id 
WHERE leads.registered_datetime between "2011/01/01" and "2011/12/31"
GROUP BY clients.client_id;

-- 7. What query would you run to get a list of client names and the total # of leads we've generated for each client each month between months 1 - 6 of Year 2011?

SELECT CONCAT_WS(' ', clients.first_name, clients.last_name) AS client_name, COUNT(leads.leads_id) AS number_of_leads, MONTHNAME(registered_datetime) AS month_generated
FROM clients
LEFT JOIN sites ON clients.client_id = sites.client_id
LEFT JOIN leads ON leads.site_id = sites.site_id
WHERE leads.registered_datetime between "2011/01/01" and "2011/06/31"
GROUP BY registered_datetime;

-- 8. What query would you run to get a list of client names and the total # of leads we've generated for each of our clients' sites between January 1, 2011 to December 31, 2011? 
-- Order this query by client id.  Come up with a second query that shows all the clients, the site name(s), and the total number of leads generated from each site for all time.

SELECT CONCAT_WS(' ', clients.first_name, clients.last_name) AS client_name, sites.domain_name AS websites, COUNT(leads.leads_id) AS number_of_leads, DATE(registered_datetime) AS date_generated
FROM clients
LEFT JOIN sites ON clients.client_id = sites.client_id
LEFT JOIN leads ON leads.site_id = sites.site_id
WHERE leads.registered_datetime BETWEEN "2011/01/01" AND "2011/12/31"
GROUP BY sites.domain_name;

SELECT CONCAT_WS(' ', clients.first_name, clients.last_name) AS client_name, sites.domain_name AS websites, COUNT(leads.leads_id) AS number_of_leads
FROM clients
LEFT JOIN sites ON clients.client_id = sites.client_id
LEFT JOIN leads ON leads.site_id = sites.site_id
GROUP BY sites.domain_name;

-- 9. Write a single query that retrieves total revenue collected from each client for each month of the year. Order it by client id.

SELECT CONCAT_WS(' ', clients.first_name, clients.last_name) AS client_name, billing.amount AS total_revenue, MONTHNAME(billing.charged_datetime), YEAR(billing.charged_datetime)
FROM clients
LEFT JOIN billing ON clients.client_id = billing.client_id
GROUP BY billing.charged_datetime
ORDER BY clients.client_id ASC;

-- 10. Write a single query that retrieves all the sites that each client owns. Group the results so that each row shows a new client. It will become clearer 
-- when you add a new field called 'sites' that has all the sites that the client owns. (HINT: use GROUP_CONCAT)

SELECT CONCAT_WS(' ', clients.first_name, clients.last_name) AS client_name, GROUP_CONCAT(' ', sites.domain_name SEPARATOR ' /') AS sites
FROM clients
LEFT JOIN sites ON clients.client_id = sites.client_id
GROUP BY clients.client_id;




