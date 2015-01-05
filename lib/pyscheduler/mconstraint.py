from constraint import *
import random
from pprint import pprint


class ModifiedMinConflictsSolver(Solver):
    def __init__(self, breakSlot=6, steps=100):
        """
        @param steps: Maximum number of steps to perform before giving up
                      when looking for a solution (default is 1000)
        @type  steps: int
        """
        self._steps = steps
        self.breakSlot = breakSlot

    def __initAssignment(self, domains):
        assignments = {}
        for variable in domains:
            assignments[variable] = self.__getClassPeriods(variable, domains)

        for v in assignments:
            pprint(v.__str__())
            for p in assignments[v]:
                pprint(p.__str__())
            print

        return assignments

    @staticmethod
    def __getRightPeriodInDay(klass, period, domain):
        p = period
        for i in range(1, klass.hours):
            p = ModifiedMinConflictsSolver.__getPrevPeriodInDay(p, domain)

        return p

    @classmethod
    def __getClassPeriods(self, klass, domains, period=None):
        slice = int(10 - klass.hours)

        if period == None:
            period = random.choice(domains[klass][:slice])

        if period.timeslot.timeslot_index >= slice:
            period = self.__getRightPeriodInDay(klass, period, domains[klass])

        while(True):
            p = period
            valid = True
            for _ in range(0,klass.hours):
                if not self.__isValidPeriod(p, domains[klass]):
                    period = self.__getPrevPeriodInDay(period, domains[klass])
                    valid = False
                    break
                p = self.__getNextPeriodInDay(p, domains[klass])

            if valid:
                break

        lst = [period]
        sequence = self.__getPeriodsInSequence(period, domains[klass])
        for _ in range(1, klass.type):
            r = random.choice(sequence)
            lst.append(r)
            sequence.remove(r)

        exp = []
        for p in lst:
            pp = p
            for _ in range(0, int(klass.hours - 1)):
                pp = self.__getNextPeriodInDay(pp, domains[klass])
                exp.append(pp)

        return lst + exp

    @staticmethod
    def __getPeriodsInSequence(startPeriod, periods):
        lst = []
        for p in periods:
            if p != startPeriod and p.timeslot.timeslot_index == startPeriod.timeslot.timeslot_index:
                lst.append(p)

        return lst

    @staticmethod
    def __getNextPeriodInDay(startPeriod, periods):
        np = None
        for p in periods:
            if p.day.day_index == startPeriod.day.day_index and p.timeslot.timeslot_index == startPeriod.timeslot.timeslot_index + 1:
                np = p
                break
        return np

    @staticmethod
    def __getPrevPeriodInDay(startPeriod, periods):
        np = None
        for p in periods:
            if p.day.day_index == startPeriod.day.day_index and p.timeslot.timeslot_index == startPeriod.timeslot.timeslot_index - 1:
                np = p
                break
        return np

    @staticmethod
    def __isValidPeriod(period, domain):
        return period in domain

    def getSolution(self, domains, constraints, vconstraints):
        assignments = self.__initAssignment(domains)

        for _ in xrange(self._steps):
            conflicted = False
            lst = domains.keys()
            random.shuffle(lst)
            for variable in lst:
                if not assignments[variable]:
                    assignments[variable] = self.__getClassPeriods(variable, domains)

                # Check if variable is not in conflict
                for constraint, variables in vconstraints[variable]:
                    if not constraint(variables, domains, assignments):
                        break
                else:
                    continue
                # Variable has conflicts. Find values with less conflicts.
                mincount = len(vconstraints[variable])
                minvalues = []
                for value in domains[variable]:
                    lst = self.__getClassPeriods(variable, domains, value)
                    assignments[variable] = lst
                    count = 0
                    for constraint, variables in vconstraints[variable]:
                        if not constraint(variables, domains, assignments):
                            count += 1
                    if count == mincount:
                        minvalues.append(lst)
                    elif count < mincount:
                        mincount = count
                        del minvalues[:]
                        minvalues.append(lst)
                # Pick a random one from these values.
                assignments[variable] = random.choice(minvalues)
                conflicted = True
            if not conflicted:
                return assignments
        return None

    @classmethod
    def resetGroupAssignments(self, klass, period, assignments, domains):
       for variable in assignments:
            if klass != variable and klass.group == variable.group:
                for p in assignments[variable]:
                    if p == period:
                        assignments[variable] = ModifiedMinConflictsSolver.__getClassPeriods(klass, domains)
                        break


class GroupPeriodConstraint(Constraint):
    def __call__(self, variables, domains, assignments, forwardcheck=False,
                 _unassigned=Unassigned):
        groups = {}
        for variable in variables:
            try:
                if assignments[variable] is not _unassigned:
                    for period in assignments[variable]:
                        if groups.has_key(period):
                            if variable.group in groups[period]:
                                ModifiedMinConflictsSolver.resetGroupAssignments(variable, period, assignments, domains)
                                return False
                        else:
                            groups[period] = []
                        groups[period].append(variable.group)
            except TypeError:
                return False
        return True


class LecturerMaxSlotConstraint(Constraint):
    def __call__(self, variables, domains, assignments, forwardcheck=False,
                 _unassigned=Unassigned):
        teacherSlots = {}
        for variable in assignments:
            if variable.lecturer:
                if not teacherSlots.has_key(variable.lecturer):
                    teacherSlots[variable.lecturer] = {}

                for period in assignments[variable]:
                    if not teacherSlots[variable.lecturer].has_key(period.day):
                        teacherSlots[variable.lecturer][period.day] = 0
                    teacherSlots[variable.lecturer][period.day] += 1

                    if teacherSlots[variable.lecturer][period.day] > 4:
                        return False
        return True


class BreakConstraint(Constraint):
    def __init__(self, breakSlot=6):
        self.breakSlot = breakSlot

    def __call__(self, variables, domains, assignments, forwardcheck=False):
        # preProcess() will remove it.
        raise RuntimeError, "Can't happen"

    def preProcess(self, variables, domains, constraints, vconstraints):
        for variable in variables:
            domain = domains[variable]
            for period in domain:
                if period.timeslot.timeslot_index == self.breakSlot:
                    domain.remove(period)
            vconstraints[variable].remove((self, variables))
        constraints.remove((self, variables))
