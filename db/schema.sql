CREATE TYPE status1 AS ENUM ('active', 'deload', 'completed');
CREATE TYPE set_type1 as ENUM ('warmup', 'working');
CREATE TYPE equipment as ENUM('barbell', 'dumbell', 'machine', 'cable', 'bodyweight');


CREATE TABLE IF NOT EXISTS exercises (
    exercise_id serial primary key,
    exercise_name varchar(50) unique not null,
    primary_muscle_group varchar(50) not null,
    secondary_muscle_groups VARCHAR(50)[],
    equipment_type equipment,
    default_load_increment decimal check(default_load_increment >= 0)
);


CREATE TABLE IF NOT EXISTS mesosycles (
    meso_name varchar(50) primary key,
    starting_date TIMESTAMP not null,
    ending_date TIMESTAMP,
    current_status status1
);

CREATE TABLE IF NOT EXISTS templates (
    temp_name varchar(50),
    exercise_name varchar(50) references exercises (exercise_name),
    work_sets int not null check (work_sets>0),
    min_reps int not null check (min_reps >0),
    max_reps int not null check (max_reps >= min_reps),
    primary key(temp_name,exercise_name)
);



CREATE TABLE IF NOT EXISTS work_session (
    session_id serial primary key,
    temp_name varchar(50) references templates (temp_name),
    session_date TIMESTAMP not null,
    meso_name varchar(50) references mesosycles (meso_name),
    curr_bw decimal not null check (curr_bw > 0)
);

CREATE TABLE IF NOT EXISTS logged_sets (
    session_id serial references work_session (session_id),
    exercise_name varchar(50) references exercises (exercise_name),
    set_order serial unique,
    set_type set_type1,
    weight_kg decimal not null check (weight_kg >= 0),
    reps int not null check (reps >=0),
    rir int check (rir between 0 and 5 or rir is null)
);