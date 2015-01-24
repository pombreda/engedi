from mconstraint import *
from models import *
from pprint import pprint
import sys
import json


def main(path):
    out = {}
    problem = Problem(ModifiedMinConflictsSolver(breakSlot=6))

    periods = []
    courseList = []

    for i in range(0, 5):
        for j in range(0, 10):
            p = Period(i, j)
            periods.append(p)

    with open(path + '/in.json') as json_data:
        d = json.load(json_data)
        json_data.close()

        out['schedule'] = d['schedule_id']

        for c in d['courses']:
            course = Course(c['code'], c['section'], c['lecturer'], c['periods'])
            courseList.append(course)
            problem.addVariable(course, periods)

    problem.addConstraint(SectionPeriodConstraint(), courseList)
    problem.addConstraint(LecturerMaxSlotConstraint(), courseList)
    problem.addConstraint(BreakConstraint(), courseList)
    problem.addConstraint(LecturerSinglePeriodConstraint(), courseList)

    solution = None
    for _ in range(0, 5):
        solution = problem.getSolution()
        if solution:
            break

    klasses = []

    if solution:
        for s in solution:
            klass = {'code': s.code, 'lectures': []}
            ss = sorted(solution[s], key=lambda period: period.day_index)

            for p in ss:
                klass['lectures'].append({'dayIndex': p.day_index, 'slotIndex': p.time_slot})
            klasses.append(klass)

    pprint(klasses)

    f = open(path + "/out.json", 'w')
    f.write(json.dumps(klasses))


if __name__ == "__main__":
    if len(sys.argv) == 2:
        main(sys.argv[1])
    else:
        main('C:\Sites\Scheduler\schedules\\r1421613262')