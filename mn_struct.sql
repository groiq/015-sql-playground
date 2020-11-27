
drop database if exists doodles;
create database doodles;
use doodles;

-- simplified representation of wallets and transactions


CREATE TABLE wallets (
    wallet_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(64),
    customer_id INT,
    balance DECIMAL(8 , 2 )
);

CREATE TABLE transactions (
    txid INT PRIMARY KEY AUTO_INCREMENT,
    sender_id INT,
    receiver_id INT,
    tx_amount DECIMAL(8 , 2 ),
    tx_timestamp timestamp,
    FOREIGN KEY (sender_id)
        REFERENCES wallets (wallet_id),
    FOREIGN KEY (receiver_id)
        REFERENCES wallets (wallet_id)
);

-- A customer invests into masternodes by doing a transaction to the sammelwallet.alter



insert into wallets (customer_name, balance) values ("Sammelwallet", 100);

insert into wallets (customer_name, balance) values ("Adam", 100);
insert into wallets (customer_name, balance) values ("Bob", 100);
insert into wallets (customer_name, balance) values ("Charlie", 100);


