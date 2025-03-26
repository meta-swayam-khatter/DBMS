-- Assignment 4:

CREATE TABLE states (
    state_id INT PRIMARY KEY AUTO_INCREMENT,
    state_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE cities (
    city_id INT PRIMARY KEY AUTO_INCREMENT,
    city_name VARCHAR(100) NOT NULL
);

CREATE TABLE zip_codes (
    zip_id INT PRIMARY KEY AUTO_INCREMENT,
    zip_code VARCHAR(10) NOT NULL UNIQUE,
    city_id INT NOT NULL,
    state_id INT NOT NULL,
    FOREIGN KEY (city_id)
        REFERENCES cities (city_id),
	FOREIGN KEY (state_id)
		REFERENCES states (state_id)
);

INSERT INTO states (state_name) VALUES 
('Uttar Pradesh'),
('Rajasthan'),
('Gujarat'),
('Madhya Pradesh'),
('Telangana'),
('Punjab'),
('Haryana'),
('Bihar'),
('Odisha'),
('Assam');

-- Insert more cities
INSERT INTO cities (city_name) VALUES 
('Lucknow'),
('Jaipur'),
('Ahmedabad'),
('Indore'),
('Hyderabad'),
('Chandigarh'),
('Gurgaon'),
('Patna'),
('Bhubaneswar'),
('Guwahati');

-- Insert more postal codes
INSERT INTO zip_codes (zip_code, state_id, city_id) VALUES 
(226001, 1, 1),  -- Lucknow, Uttar Pradesh
(302001, 2, 2),  -- Jaipur, Rajasthan
(380001, 3, 3),  -- Ahmedabad, Gujarat
(452001, 4, 4), -- Indore, Madhya Pradesh
(500001, 5, 5), -- Hyderabad, Telangana
(160001, 6, 6), -- Chandigarh, Punjab
(122001, 7, 7), -- Gurgaon, Haryana
(800001, 8, 8), -- Patna, Bihar
(751001, 9, 9), -- Bhubaneswar, Odisha
(781001, 10, 10); -- Guwahati, Assam

-- Query to fetch Zip Code, City, and State ordered by State and City
SELECT z.zip_code, c.city_name, s.state_name
	FROM zip_codes z
	JOIN cities c ON z.city_id = c.city_id
	JOIN states s ON z.state_id = s.state_id
	ORDER BY s.state_name , c.city_name
;
