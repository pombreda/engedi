from constraint import *
import random
from pprint import pprint
from functools import reduce


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
    def __getFirstHalfPeriods(domain, breakSlot):
        return reduce(lambda p: p.time_slot < breakSlot, domain)

    @staticmethod
    def __getSecondHalfPeriods(domain, breakSlot):
        return reduce((lambda p: p.time_slot > breakSlot), domain)

    @staticmethod
    def __getOneHourSlots(domain, breakSlot):
        slots = []
        for p in domain:
            if (p.time_slot < breakSlot and p.time_slot > breakSlot - 2) or p.time_slot > breakSlot:
                slots.append(p)
        return slots

    @staticmethod
    def __getRightPeriodInDay(klass, period, domain):
        p = period
        for i in range(1, klass.periods):
            p = ModifiedMinConflictsSolver.__getPrevPeriodInDay(p, domain)

        return p

    @classmethod
    def __getAvailableSlots(self, breakSlot, domains, klass, lst, period_slice, prev_assignments={}):
        available = self.__getOneHourSlots(domains[klass], breakSlot) if period_slice == 1 else domains[klass]
        available = domains[klass]
        available = [x for x in available if x not in lst]

        # invalid = []
        # for p in lst:
        #     for a in available:
        #         if p.day_index == a.day_index:
        #             invalid.append(a)
        #
        # available = [x for x in available if x not in invalid]

        invalid = []
        if period_slice > 1:
            for p in available:
                if p.time_slot == 9 or p.time_slot == breakSlot - 1:
                    invalid.append(p)


        return [x for x in available if x not in invalid]

    @classmethod
    def __getClassPeriods(self, klass, domains, breakSlot=6, period=None, prev_assignments={}):
        period_slice = klass.periods
        lst = []

        while period_slice > 0:
            available = self.__getAvailableSlots(breakSlot, domains, klass, lst, period_slice, prev_assignments)

            if not period or period not in available:
                period = random.choice(available)

            while True:
                p = period
                valid = True
                for _ in range(0, min(period_slice - 1, 2)):
                    if not self.__isValidPeriod(p, domains[klass]):
                        period = self.__getPrevPeriodInDay(period, domains[klass])
                        valid = False
                        break
                    p = self.__getNextPeriodInDay(p, domains[klass])

                if valid:
                    break

            lst.append(period)
            if period_slice >= 2:
                pr = self.__getNextPeriodInDay(period, domains[klass])
                lst.append(pr)
                period_slice -= 1

            period_slice -= 1
            period = None

        return lst

    @staticmethod
    def __getPeriodsInSequence(startPeriod, periods):
        lst = []
        for p in periods:
            if p != startPeriod and p.time_slot == startPeriod.time_slot:
                lst.append(p)

        return lst

    @staticmethod
    def __getNextPeriodInDay(startPeriod, periods):
        np = None
        for p in periods:
            if p.day_index == startPeriod.day_index and p.time_slot == startPeriod.time_slot + 1:
                np = p
                break
        return np

    @staticmethod
    def __getPrevPeriodInDay(startPeriod, periods):
        np = None
        for p in periods:
            if p.day_index == startPeriod.day_index and p.time_slot == startPeriod.time_slot - 1:
                np = p
                break
        return np

    @staticmethod
    def __isValidPeriod(period, domain):
        return period in domain

    def getSolution(self, domains, constraints, vconstraints):
        assignments = self.__initAssignment(domains)

        self.print_conflicts(self.find_conflicting_periods(assignments))

        for _ in xrange(self._steps):
            conflicted = False
            lst = domains.keys()
            random.shuffle(lst)
            for variable in lst:
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
                    lst = self.__getClassPeriods(variable, domains, period=value)
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
                self.print_conflicts(self.find_conflicting_periods(assignments))
                conflicted = True
            if not conflicted:
                return assignments
        return None

    @classmethod
    def resetSectionAssignments(self, klass, period, assignments, domains):
        for variable in assignments:
            if klass != variable and klass.section == variable.section:
                for p in assignments[variable]:
                    if p == period:
                        assignments[variable] = ModifiedMinConflictsSolver.__getClassPeriods(variable, domains,
                                                                                             prev_assignments=assignments)
                        break

    @classmethod
    def __getCourseSections(self, section, variables):
        sections = []
        for variable in variables:
            if variable.section == section:
                sections.append(variable)

        return sections

    @classmethod
    def getCourseSectionAssignments(self, section, variables, assignments):
        return dict(filter(lambda i: i[0] in self.__getCourseSections(section, variables), assignments.iteritems()))

    @staticmethod
    def print_assignments(assignments):
        klasses = []

        if assignments:
            for s in assignments:
                klass = {'code': s.code, 'lectures': []}
                ss = sorted(assignments[s], key=lambda period: period.day_index)

                for p in ss:
                    klass['lectures'].append({'dayIndex': p.day_index, 'slotIndex': p.time_slot})
                klasses.append(klass)

        pprint(klasses)

    @staticmethod
    def find_conflicting_periods(assignments):
        conflicts = []
        periods = []
        for variable in assignments:
            for p in assignments[variable]:
                if p not in periods:
                    periods.append(p)
                else:
                    conflicts.append(p)

        return conflicts

    @staticmethod
    def print_conflicts(conflicts):
        [pprint(str(x)) for x in conflicts]
        print


class SectionPeriodConstraint(Constraint):
    def __call__(self, variables, domains, assignments, forwardcheck=False,
                 _unassigned=Unassigned):
        sections = {}
        for variable in variables:
            for period in assignments[variable]:
                if sections.has_key(period):
                    if variable.section in sections[period]:
                        # ModifiedMinConflictsSolver.resetSectionAssignments(variable, period,
                        #                                                    ModifiedMinConflictsSolver.getCourseSectionAssignments(
                        #                                                        variable.section, variables,
                        #                                                        assignments), domains)
                        return False
                else:
                    sections[period] = []

                sections[period].append(variable.section)

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
                    if not teacherSlots[variable.lecturer].has_key(period.day_index):
                        teacherSlots[variable.lecturer][period.day_index] = 0
                    teacherSlots[variable.lecturer][period.day_index] += 1

                    if teacherSlots[variable.lecturer][period.day_index] > 4:
                        return False
        return True


class LecturerSinglePeriodConstraint(Constraint):
    def __call__(self, variables, domains, assignments, forwardcheck=False,
                 _unassigned=Unassigned):
        lecturerPeriod = {}
        for klass in assignments:
            if klass.lecturer:
                if not lecturerPeriod.has_key(klass.lecturer):
                    lecturerPeriod[klass.lecturer] = []
                for period in assignments[klass]:
                    if period in lecturerPeriod[klass.lecturer]:
                        return False
                    lecturerPeriod[klass.lecturer].append(period)
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
                if period.time_slot == self.breakSlot:
                    domain.remove(period)
            vconstraints[variable].remove((self, variables))
        constraints.remove((self, variables))
