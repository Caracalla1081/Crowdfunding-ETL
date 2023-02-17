-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT 
	cf_id,
	backers_count
FROM
	campaign
WHERE outcome = 'live'
	ORDER BY cf_id DESC;


-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT
	cf_id,
	COUNT(backer_id)
FROM backers
GROUP BY cf_id
ORDER BY cf_id DESC;



-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
CREATE TABLE email_contacts_remaining_goal_amount AS
SELECT 
	contacts.first_name,
	contacts.last_name,
	contacts.email,
	(campaign.goal - campaign.pledged) AS Remaining_Goal_Amount
FROM
	contacts
	LEFT JOIN campaign ON campaign.contact_id = contacts.contact_id
WHERE campaign.outcome = 'live'
ORDER BY Remaining_Goal_Amount DESC;
	


-- Check the table


-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 
CREATE TABLE email_backers_remaining_goal_amount AS
SELECT 
	backers.first_name AS email,
	backers.last_name AS first_name,
	backers.email AS last_name,
	campaign.cf_id,
	campaign.company_name,
	campaign.description,
	campaign.end_date,
	(campaign.goal - campaign.pledged) AS Left_of_Goal
FROM
	backers
	LEFT JOIN campaign ON campaign.cf_id = backers.cf_id
WHERE campaign.outcome = 'live'
GROUP BY backers.first_name,
	backers.last_name,
	backers.email,
	campaign.cf_id,
	campaign.company_name,
	campaign.description,
	campaign.end_date,
	(campaign.goal - campaign.pledged)
ORDER BY backers.email ASC;

-- Check the table


