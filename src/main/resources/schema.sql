CREATE TABLE tour (
  id BIGSERIAL PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  description VARCHAR(2000) NOT NULL,
  blurb VARCHAR(2000) NOT NULL,
  bullets VARCHAR(2000) NOT NULL,
  price VARCHAR(10) not null,
  duration VARCHAR(32) NOT NULL,
  difficulty VARCHAR(16) NOT NULL,
  region VARCHAR(20) NOT NULL,
  keywords VARCHAR(100)
);
