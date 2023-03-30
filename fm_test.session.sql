SELECT u."id", u."firstName", u."lasName", o."id" AS "orders"
FROM "users" AS u
    JOIN "orders" AS o ON o."userId" = u."id"
WHERE u."id"=25;

SELECT o.id, p.brand count(p.model) AS quantity-- получить id всех пользователей, которые заказали Sony
FROM "orders" AS o
    JOIN "phones_to_orders" AS pto ON o.id=pto."orderId"
    JOIN "phones" AS p ON p.id=pto."phoneId"
WHERE p.brand ILIKE 'Sony'
GROUP BY o.id, p.brand
HAVING count(p.model)>=5
ORDER BY quantity;

INSERT INTO "phones"(
    "brand", "model", "price", "quantity"
) VALUES ('eNote', 'Kherson', 12300, 2);

SELECT * -- выбрать бренды телефонов, которые не покупают (там не будет телефона eNote)
FROM "phones" AS p
    JOIN "phones_to_orders" AS pto ON pto."phoneId"=p.id
GROUP BY p.brand
ORDER BY p.brand;


SELECT u.email, p.brand -- выбрать почту пользователей, которые покупали iPhone
FROM "users" AS u
    JOIN "orders" AS o ON u.id=o."userId"
    JOIN "phones_to_orders" AS pto ON o.id=pto."orderId"
    JOIN "phones" AS p ON p.id=pto."phoneId"
WHERE p.brand ILIKE 'iPhone'
GROUP BY u.email, p.brand;

SELECT * FROM -- посчитать пользователей, у которых количество заказов больше трех
(
    SELECT u.email, count(o.id) AS amount
    FROM "users" AS u
        JOIN "orders" AS o ON u.id=o."userId"
    GROUP BY u.email
) AS coe
WHERE coe.amount>3
ORDER BY coe.amount;

SELECT p.model, o.id, u.email -- выбрать все заказы телефона с id=33 и почту покупателей
FROM "users" AS u
    JOIN "orders" AS o ON u.id=o."userId"
    JOIN "phones_to_orders" AS pto ON o.id=pto."orderId"
    JOIN "phones" AS p ON p.id=pto."phoneId"
WHERE pto."phoneId"=33;

SELECT sum(pto.quantity) as amount, -- выбрать самый популярный телефон
pto."phoneId"
FROM "phones_to_orders" AS pto
GROUP BY pto."phoneId"
ORDER BY amount DESC
LIMIT 1;