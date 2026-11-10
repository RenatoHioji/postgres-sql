CREATE TABLE payment (
    id             BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    transaction_id UUID NOT NULL,
    value          NUMERIC(12, 2) NOT NULL,
    payment_date   TIMESTAMPTZ NOT NULL,
    status         TEXT NOT NULL
);

INSERT INTO payment (transaction_id, value, payment_date, status)
SELECT
    gen_random_uuid(),
    round((random() * 990 + 10)::numeric, 2),
    now() - (random() * interval '90 days'),
    (ARRAY['pending', 'completed', 'failed', 'refunded'])[floor(random() * 4 + 1)::int]
FROM generate_series(1, 1000000);

CREATE INDEX idx_payment_transaction_id ON payment (transaction_id);