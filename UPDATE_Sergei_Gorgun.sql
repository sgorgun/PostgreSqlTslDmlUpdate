DO $$
DECLARE
    customer_rec RECORD;
BEGIN
    UPDATE film
    SET rental_duration = 21, rental_rate = 9.99
    WHERE title = UPPER('The Matrix');

    FOR customer_rec IN
        SELECT c.customer_id, c.address_id
        FROM customer c
        JOIN rental r ON c.customer_id = r.customer_id
        JOIN payment p ON c.customer_id = p.customer_id
        GROUP BY c.customer_id, c.address_id
        HAVING COUNT(r.rental_id) >= 10 AND COUNT(p.payment_id) >= 10
        LIMIT 1
    LOOP
        UPDATE customer
        SET first_name = UPPER('Sergei'), last_name = UPPER('Gorgun'), email = 'SERGEI.GORGUN@sakilacustomer.org', create_date = CURRENT_DATE, address_id = 10
        WHERE customer_id = customer_rec.customer_id;
    END LOOP;
END $$;
