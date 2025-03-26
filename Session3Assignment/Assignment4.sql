-- Assignment 4:

CREATE TABLE states (
    state_id INT PRIMARY KEY AUTO_INCREMENT,
    state_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE cities (
    city_id INT PRIMARY KEY AUTO_INCREMENT,
    city_name VARCHAR(100) NOT NULL,
    state_id INT NOT NULL,
    FOREIGN KEY (state_id)
        REFERENCES states (state_id)
);

CREATE TABLE zip_codes (
    zip_id INT PRIMARY KEY AUTO_INCREMENT,
    zip_code VARCHAR(10) NOT NULL UNIQUE,
    city_id INT NOT NULL,
    FOREIGN KEY (city_id)
        REFERENCES cities (city_id)
);

-- Query to fetch Zip Code, City, and State ordered by State and City
SELECT z.zip_code, c.city_name, s.state_name
	FROM zip_codes z
	JOIN cities c ON z.city_id = c.city_id
	JOIN states s ON c.state_id = s.state_id
	ORDER BY s.state_name , c.city_name
;
