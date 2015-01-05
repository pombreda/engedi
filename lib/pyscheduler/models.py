class Course:
    def __init__(self, code, group = 1, lecturer = "", hours = 1, type = "A"):
        self.code = code
        self.group = group
        self.lecturer = lecturer
        self.hours = hours
        self.type = type

    def __str__(self):
        return self.code + "-Group " + str(self.group)


class Lecturer:
    def __init__(self, code = ""):
        self.code = code

    def __unicode__(self):
        return self.code


class Day:
    def __init__(self, day_index = 0):
        self.day_index = day_index

    def __unicode__(self):
        return self.day_index


class Timeslot:
    def __init__(self, timeslot_index):
        self.timeslot_index = timeslot_index

    def __unicode__(self):
        return self.timeslot_index


class Room:
    def __init__(self, code = ""):
        self.code = code

    def __str__(self):
        return self.code


class Period:
    def __init__(self, day, timeslot):
        self.day = day
        self.timeslot = timeslot
        self.count = 1

    def __add__(self, other):
        self.count += other.count

    def __iadd__(self, other):
        self.count += other.count

    def __str__(self):
        return "Day " + str(self.day.day_index) + " - Slot " + str(self.timeslot.timeslot_index)


class Lecture:
    def __init__(self, course, period, room):
        self.course = course
        self.period = period
        self.room = room

    def __unicode__(self):
        return self.period + " (" + self.course + ")"