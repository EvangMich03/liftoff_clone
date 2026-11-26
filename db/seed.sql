INSERT INTO exercises (exercise_name,primary_muscle_group,secondary_muscle_groups,equipment_type,default_load_increment)
VALUES  ('hacksquat','quadriceps','{hamstrings,glutes}','machine',2.5), 
		('barbell bench','chest','{triceps,shoulders}','barbell',1.25),
		('lateral raises','shoulders',NULL,'dumbell',1.25),
		('hamstring curl','hamtrings',NULL,'machine',2.5),
		('bicep curl','biceps',NULL,'dumbell',1.25),
		('calf raises','calfs',NULL,'machine',1.25),
		('lat pulldown','back','{biceps}','machine',2.5),
		('dips','chest','{shoulders,triceps}','bodyweight',2.5),
		('hip thrust','glutes',NULL,'machine',2.5);



INSERT INTO templates (temp_name,exercise_name,work_sets,min_reps,max_reps)
VALUES  ('Upper A','barbell bench',2,8,10),
        ('Upper A','lateral raises',3,10,15),
        ('Upper A','lat pulldown',2,10,12),
        ('Upper A','dips',3,5,7),
        ('Lower A','hacksquat',2,6,8),
        ('Lower A','calf raises',3,12,15),
        ('Lower A','hamstring curl',2,10,12),
        ('Lower A','hip thrust',3,10,12);
        

--select * from templates t 