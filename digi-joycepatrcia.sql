--Buat table accounts
CREATE TABLE public.accounts (
	account_id int8 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	"name" varchar NOT NULL,
	balance int8 DEFAULT 0 NOT NULL,
	referral_account_id int8 NULL,
	CONSTRAINT accounts_pkey PRIMARY KEY (account_id),
	CONSTRAINT fk_account FOREIGN KEY (referral_account_id) REFERENCES public.accounts(account_id)
);

--Buat table auths
CREATE TABLE public.auths (
	auth_id int8 GENERATED ALWAYS AS IDENTITY NOT NULL,
	account_id int8 NOT NULL,
	username varchar NOT NULL,
	"password" varchar DEFAULT '1234'::character varying NOT NULL,
	CONSTRAINT auths_pk PRIMARY KEY (auth_id),
	CONSTRAINT auths_unique UNIQUE (username, account_id)
);

--Buat table transaction categories
CREATE TABLE public.transaction_categories (
	transaction_category_id int4 GENERATED ALWAYS AS IDENTITY NOT NULL,
	"name" varchar NULL,
	CONSTRAINT transaction_categories_pk PRIMARY KEY (transaction_category_id)
);

--Buat table transaction transaction
CREATE TABLE public."transaction" (
	transaction_id int8 GENERATED ALWAYS AS IDENTITY NOT NULL,
	transaction_category_id int8 NULL,
	account_id int8 NULL,
	from_account_id int8 NULL,
	to_account_id int8 NULL,
	amount int8 DEFAULT 0 NULL,
	transaction_date timestamp NULL,
	CONSTRAINT transaction_pk PRIMARY KEY (transaction_id)
);

--Isi 5 data accounts
INSERT INTO public.accounts ("name",balance,referral_account_id) VALUES
	 ('Taeyong',2000000,NULL),
	 ('Jaehyun',1650000,NULL),
	 ('Doyoung',700000,NULL),
	 ('Mark',1500000,NULL),
	 ('Ten',600000,NULL);

--Isi 2 data transaction categories
INSERT INTO public.transaction_categories ("name") VALUES
	 ('Drink'),
	 ('Meal');

--Isi 12 data transaction transaction
INSERT INTO public."transaction" (transaction_category_id,account_id,from_account_id,to_account_id,amount,transaction_date) VALUES
	 (2,4,4,5,25000,'2024-02-24 11:12:45'),
	 (1,5,5,3,15000,'2024-11-05 14:19:07'),
	 (1,6,6,7,50000,'2024-03-23 20:01:30'),
	 (2,7,7,4,120000,'2024-04-23 18:05:35'),
	 (1,3,3,5,75000,'2024-05-12 09:30:25'),
	 (1,5,5,4,64000,'2024-06-06 15:25:21'),
	 (2,4,4,3,55000,'2024-07-01 11:56:43'),
	 (2,7,7,3,88000,'2024-08-13 08:04:08'),
	 (1,6,6,7,30000,'2024-09-28 12:12:12'),
	 (1,5,5,6,45000,'2024-10-10 20:21:32'),
	 (2,4,4,3,95000,'2024-12-25 16:17:46'),
	 (2,3,3,6,100000,'2024-01-17 10:20:33');


--Update nama di accounts (given account_id)
UPDATE public.accounts SET "name"='Mark Lee' WHERE account_id=3;

--Update balance di accounts (given account_id)
UPDATE public.accounts SET balance=900000 WHERE account_id=7;

--List semua data accounts
select * from accounts a ;

-- List semua data transactions join dengan accounts (account_id = account_id) dan tampilkan nama dari accounts
select a.name, t.* from accounts a join "transaction" t on a.account_id = t.account_id;

-- Query 1 data accounts dengan balance terbanyak
SELECT * FROM accounts a order by balance desc limit 1;

-- Query semua transaction yg terjadi di bulan Mei (Bulan 5)
SELECT * FROM transaction t WHERE EXTRACT(MONTH FROM transaction_date) = 5;
