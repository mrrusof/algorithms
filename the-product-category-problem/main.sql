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

CREATE FUNCTION if_no_sub_c(cid integer)
  RETURNS bool AS
  $func$
    SELECT NOT EXISTS (SELECT 1 FROM categories WHERE parent = cid);
  $func$ LANGUAGE sql STABLE;

ALTER TABLE p_c ADD CONSTRAINT if_no_sub_c_check
  CHECK (if_no_sub_c(cid));

INSERT INTO products (name) VALUES ('pizza');
SELECT products.name AS product, categories.name AS category
  FROM products, p_c, categories
  WHERE products.id = pid AND cid = categories.id;
INSERT INTO p_c (pid, cid)
  SELECT products.id, categories.id
  FROM products, categories
  WHERE products.name = 'pizza' AND categories.name = 'food';
SELECT products.name AS product, categories.name AS category
  FROM products, p_c, categories
  WHERE products.id = pid AND cid = categories.id;

CREATE FUNCTION if_no_prod(id integer)
  RETURNS bool AS
  $func$
    SELECT NOT EXISTS (SELECT 1 FROM p_c WHERE cid = id);
  $func$ LANGUAGE sql STABLE;

ALTER TABLE categories ADD CONSTRAINT if_no_prod_check
  CHECK (if_no_prod(parent));

SELECT * FROM categories;
INSERT INTO categories (name, parent)
  SELECT 'fast food', gsf.id
  FROM categories AS gsf
  WHERE gsf.name = 'gas station food';
SELECT * FROM categories;

CREATE FUNCTION categories(product_id integer)
  RETURNS TABLE (category varchar(50)) AS
  $func$
    WITH RECURSIVE cats(pid, cid, name, parent) AS (
      SELECT pid, categories.*
      FROM p_c, categories
      WHERE cid = id
    UNION ALL
      SELECT pid, categories.*
      FROM cats, categories
      WHERE cats.parent = categories.id
    )
    SELECT name FROM cats WHERE pid = product_id;
  $func$ LANGUAGE sql;

SELECT categories(id) FROM products WHERE name = 'sandwich';
SELECT categories(id) FROM products WHERE name = 'pizza';
INSERT INTO categories (name, parent)
  SELECT 'fast food', categories.id
  FROM categories
  WHERE name = 'food';
INSERT INTO p_c (pid, cid)
  SELECT products.id, categories.id
  FROM products, categories
  WHERE products.name = 'pizza' AND categories.name = 'fast food';
SELECT categories(id) FROM products WHERE name = 'pizza';

CREATE FUNCTION products(category_id integer)
  RETURNS TABLE (products varchar(50)) AS
  $func$
    WITH RECURSIVE prods(cid, parent, pid, product) AS (
        SELECT cid, parent, pid, products.name
        FROM p_c, products, categories
        WHERE pid = products.id AND cid = categories.id
      UNION ALL
        SELECT par.id, par.parent, pid, product
        FROM prods, categories AS par
        WHERE prods.parent = par.id
    )
    SELECT product FROM prods WHERE cid = category_id
  $func$ LANGUAGE sql;

SELECT products(id) FROM categories WHERE name = 'food';
SELECT products(id) FROM categories WHERE name = 'fast food';
SELECT products(id) FROM categories WHERE name = 'gas station food';

