/* delete tables if they exist */
DROP TABLE IF EXISTS transactions_eoa;
DROP TABLE IF EXISTS fees;

/* create new table with transactions which do not involve contracts */
SELECT block_time, gas_used, gas_price
INTO transactions_eoa
FROM transactions
WHERE (transactions.from NOT IN (
  SELECT address
  FROM contracts
))
AND (transactions.to NOT IN (
  SELECT address
  FROM contracts
))
AND (transactions.from != '0x0000000000000000000000000000000000000000')
AND (transactions.to != '0x0000000000000000000000000000000000000000');

/* calculate fee */
ALTER TABLE transactions_eoa
ADD fee NUMERIC;
UPDATE transactions_eoa
SET fee = gas_used * gas_price;

/* truncate time stamp to the full hour */
ALTER TABLE transactions_eoa
ADD block_time_hours timestamp;
UPDATE transactions_eoa
SET block_time_hours = DATE_TRUNC('hour', block_time);

/* group by hour */
SELECT block_time_hours, SUM(fee)
INTO fees
FROM transactions_eoa
GROUP BY block_time_hours;
ALTER TABLE fees
RENAME COLUMN sum TO fee_gwei;

/* convert to unix timestamp */
ALTER TABLE fees
ADD t NUMERIC;
UPDATE fees
SET t = EXTRACT(EPOCH FROM block_time_hours);

/* convert fee to eth */
ALTER TABLE fees
ADD v NUMERIC;
UPDATE fees
SET v = fee_gwei/10^9;

/* remove obsolete columns */
ALTER TABLE fees
DROP COLUMN block_time_hours;
ALTER TABLE fees
DROP COLUMN fee_gwei;
