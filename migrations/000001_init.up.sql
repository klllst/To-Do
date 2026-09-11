CREATE SCHEMA todolist;

CREATE TABLE todolist.users (
    id           SERIAL      PRIMARY KEY,
    name         VARCHAR(50) NOT NULL,
    email        VARCHAR(50) NOT NULL UNIQUE CHECK (
        email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
    ),
    phone_number VARCHAR(20) NOT NULL CHECK (
        phone_number ~ '^\+[0-9]+$'
        AND char_length(phone_number) BETWEEN 6 AND 20
    )
);

CREATE TABLE todolist.tasks (
    id           SERIAL       PRIMARY KEY,
    title        VARCHAR(50)  NOT NULL,
    description  VARCHAR(500),
    status       SMALLINT     NOT NULL CHECK (status BETWEEN 0 AND 9),
    created_at   TIMESTAMPTZ  NOT NULL DEFAULT now(),
    completed_at TIMESTAMPTZ,
    user_id      INTEGER      NOT NULL REFERENCES todolist.users(id)
);