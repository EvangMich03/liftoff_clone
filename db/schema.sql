CREATE TABLE IF NOT EXISTS exercises (
    exercise_id serial primary key,
    exercise_name varchar(50) unique not null,
    primary_muscle_group varchar(50) not null,
    secondary_muscle_groups ARRAY[VARCHAR(50)],
    equipment_type varchar(15) not null
    default_load_increment float
)

CREATE TYPE status1 AS ENUM ('active', 'deload', 'completed');



CREATE TABLE IF NOT EXISTS exercises (
    meso_name varchar(50) primary key,
    starting_date TIMESTAMP not null,
    ending_date TIMESTAMP,
    current_status status1

)
