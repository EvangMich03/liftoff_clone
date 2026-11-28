import logging
from collections import defaultdict

logging.basicConfig(level=logging.INFO)



def calculate_e1rm(weight: float, reps:int) -> float:
    if reps <= 0:
        raise ValueError("You are not allowed to use zero or negative reps")

    if weight < 0:
        raise ValueError("You cannot use negative weight")
    
    if reps == 1:
        return weight
    else:
        return round(weight * (1 + (reps/30)),2)



def calculate_relative_strength(e1rm:float, bw:float) -> float:
    if bw <=0:
        raise ValueError("You are not allowed to input 0 or negative bw")

    return round(e1rm/bw,2)


def evaluate_progression(target_work_sets:int, min_reps:int, max_reps:int, load_increment_kg:float, set_list: list):
    #INITIAL_CALIBRATION = (suggested_weight_kg = None, target_reps = min_reps)

    old_work_sets = [(set_type,weight_kg,reps) for (set_type,weight_kg,reps) in set_list if set_type != 'warmup']
    reps = [(reps) for (_,_,reps) in old_work_sets]
    weight = [(weight_kg) for (_,weight_kg,_) in old_work_sets ]

    if len(old_work_sets) == 0:
        return ("INITIAL_CALIBRATION",None,min_reps)

    elif len(old_work_sets) >= target_work_sets and all(r >= max_reps for r in reps):
        return ("INCREASE_LOAD",max(weight) + load_increment_kg, min_reps)

    else:
        reps = [(max_reps - r) for r in reps]
        reps = [max(r,0) for r in reps]
        return ("HOLD_LOAD",max(weight),reps)



def aggregate_weekly_volume(logged_sets:list[dict]):
    result = {
        "active": defaultdict(float),
        "deload": defaultdict(float)
    }
    for x in logged_sets:
        if x["set_type"] == "warmup":
            continue
        else:
            if x["current_status"] == "active":
                muscle_group = x["primary_muscle_group"]
                result["active"][muscle_group] +=1.0
                if x["secondary_muscle_groups"] != None:
                    secondary = x["secondary_muscle_groups"]
                    for k in secondary:
                        result["active"][k] += 0.5
            elif x["current_status"] == "completed":
                continue            
            else:
                muscle_group = x["primary_muscle_group"]
                result["deload"][muscle_group] +=1.0
                if x["secondary_muscle_groups"] != None:
                    secondary = x["secondary_muscle_groups"]
                    for k in secondary:
                        result["deload"][k] += 0.5

    return result                    


    

def main():
    max_reps = 10
    reps = [8,12,10,9,15]
    reps = [(max_reps - r) for r in reps]
    reps = [max(r,0) for r in reps]
    logging.info(reps)

    logging.info("main")

if __name__ == '__main__':
    main()