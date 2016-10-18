DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS p_c;
DROP FUNCTION IF EXISTS if_no_sub_c(integer);
DROP FUNCTION IF EXISTS if_no_p(integer);
DROP FUNCTION IF EXISTS categories(integer);
DROP FUNCTION IF EXISTS products(integer);

CREATE TABLE products (
  id serial PRIMARY KEY,
  name varchar(50)
);

INSERT INTO products (name) VALUES ('sandwich');
SELECT * FROM products;

CREATE TABLE categories (
  id serial PRIMARY KEY,
  name varchar(50)
);

INSERT INTO categories (name) VALUES ('gas station food');
SELECT * FROM categories;

CREATE TABLE p_c (
  pid integer REFERENCES products(id),
  cid integer REFERENCES categories(id)
);

INSERT INTO p_c (pid, cid) VALUES (1, 1);
SELECT products.name AS product, categories.name AS category
  FROM products, p_c, categories
  WHERE products.id = pid AND cid = categories.id;

-- DROP TABLE IF EXISTS categories CASCADE;
-- CREATE TABLE categories (
--   id serial PRIMARY KEY,
--   name varchar(50),
--   parent integer REFERENCES categories(id)
-- );

ALTER TABLE categories
  ADD COLUMN parent integer
  REFERENCES categories(id);

INSERT INTO categories (name) VALUES ('food');
UPDATE categories SET parent = 2 WHERE id = 1;
SELECT c1.name AS parent, c2.name AS child
  FROM categories AS c1, categories AS c2
  WHERE c1.id = c2.parent;

-- CREATE FUNCTION if_no_sub_c(id integer)
--   RETURNS bool AS
-- $func$
--   SELECT NOT EXISTS (SELECT 1 FROM sub_c WHERE id = parent);
-- $func$ LANGUAGE sql STABLE;

-- ALTER TABLE p_c ADD CONSTRAINT if_no_sub_c_check
--   CHECK (if_no_sub_c(cid));

-- INSERT INTO products (name) VALUES ('pizza');
-- INSERT INTO p_c (pid, cid) VALUES (2, 2);
-- SELECT count(*) from p_c, sub_c WHERE cid = parent;

-- CREATE FUNCTION if_no_p(id integer)
--   RETURNS bool AS
-- $func$
--   SELECT NOT EXISTS (SELECT 1 FROM p_c WHERE id = pid);
-- $func$ LANGUAGE sql STABLE;

-- ALTER TABLE sub_c ADD CONSTRAINT if_no_p_check
--   CHECK (if_no_p(parent));

-- INSERT INTO categories (name) VALUES ('fast food');
-- INSERT INTO sub_c (parent, child) VALUES (1, 3);
-- SELECT count(*) from p_c, sub_c WHERE cid = parent;

-- CREATE FUNCTION categories(product_id integer)
--   RETURNS TABLE (category varchar(50)) AS
-- $func$
--   WITH RECURSIVE cats(pid, cid, category) AS (
--       SELECT pid, cid, name
--       FROM p_c, categories
--       WHERE cid = id
--     UNION ALL
--       SELECT pid, parent, name
--       FROM cats, sub_c, categories
--       WHERE cid = child AND parent = id
--   )
--   SELECT category FROM cats WHERE pid = product_id;
-- $func$ LANGUAGE sql;

-- SELECT categories(id) FROM products WHERE name = 'sandwich';

-- CREATE FUNCTION products(category_id integer)
--   RETURNS TABLE (products varchar(50)) AS
-- $func$
--   WITH RECURSIVE prods(cid, pid, product) AS (
--       SELECT cid, pid, name
--       FROM p_c, products
--       WHERE pid = id
--     UNION
--       SELECT parent, pid, product
--       FROM prods, sub_c
--       WHERE cid = child
--   )
--   SELECT product FROM prods WHERE cid = category_id
-- $func$ LANGUAGE sql;

-- SELECT products(id) FROM categories WHERE name = 'food';
-- INSERT INTO sub_c (parent, child)
--   SELECT food.id, ff.id
--   FROM categories AS food, categories AS ff
--   WHERE food.name = 'food' AND ff.name = 'fast food';
-- INSERT INTO p_c (pid, cid)
--   SELECT pizza.id, ff.id
--   FROM products AS pizza, categories AS ff
--   WHERE pizza.name = 'pizza' AND ff.name = 'fast food';
-- SELECT products(id) FROM categories WHERE name = 'food';
