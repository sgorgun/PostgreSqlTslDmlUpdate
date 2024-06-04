DO $$
DECLARE
    customer_rec RECORD;
BEGIN
    -- Update rental duration and rental rate for "The Matrix"
    UPDATE film
    SET rental_duration = 21, rental_rate = 9.99
    WHERE title = UPPER('The Matrix');

    -- Find a customer with at least 10 rentals and 10 payments
    FOR customer_rec IN
        SELECT c.customer_id, c.address_id
        FROM customer c
        JOIN rental r ON c.customer_id = r.customer_id
        JOIN payment p ON c.customer_id = p.customer_id
        GROUP BY c.customer_id, c.address_id
        HAVING COUNT(r.rental_id) >= 10 AND COUNT(p.payment_id) >= 10
        LIMIT 1
    LOOP
        -- Update the customer's information
        UPDATE customer
        SET first_name = UPPER('Sergei'), last_name = UPPER('Gorgun'), email = 'SERGEI.GORGUN@sakilacustomer.org', create_date = CURRENT_DATE, address_id = customer_rec.address_id
        WHERE customer_id = customer_rec.customer_id;
    END LOOP;
END $$;



--Here is the complete code to check all changes:
-- Verify changes to the film "The Matrix"
SELECT *
FROM film
WHERE title = UPPER('The Matrix');

-- Verify the customer ID and address ID for a customer with at least 10 rentals and 10 payments
SELECT c.customer_id, c.address_id
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.address_id
HAVING COUNT(r.rental_id) >= 10 AND COUNT(p.payment_id) >= 10
LIMIT 1;

-- Assuming the result from the query above gives customer_id = 123 and address_id = 456

-- Verify the customer's information
SELECT customer_id, first_name, last_name, email, address_id, create_date
FROM customer
WHERE customer_id = 123;

-- Verify the address information
SELECT address_id, address, district, city_id, postal_code, phone
FROM address
WHERE address_id = 456;

--
SELECT * FROM public.film
ORDER BY film_id DESC LIMIT 10;

SELECT * FROM public.actor
ORDER BY actor_id DESC LIMIT 10;

SELECT * FROM public.film_actor
ORDER BY actor_id DESC, film_id DESC LIMIT 10;

SELECT * FROM public.inventory
ORDER BY inventory_id DESC LIMIT 10;


-- Получить данные о заказах и платежах клиента Sergei Gorgun
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    r.rental_id,
    r.rental_date,
    r.return_date,
    p.payment_id,
    p.amount,
    p.payment_date
FROM
    customer c
JOIN
    rental r ON c.customer_id = r.customer_id
JOIN
    payment p ON r.rental_id = p.rental_id
WHERE
    c.first_name = 'SERGEI'
    AND c.last_name = 'GORGUN';


