class Course:
    def __init__(self, code, section=1, lecturer="", periods=1):
        self.code = code
        self.section = section
        self.lecturer = lecturer
        self.periods = periods

    def __str__(self):
        return self.code + "-Section " + str(self.section) + "-Periods " + str(self.periods)


class Lecturer:
    def __init__(self, code = ""):
        self.code = code

    def __unicode__(self):
        return self.code


class Room:
    def __init__(self, code = ""):
        self.code = code

    def __str__(self):
        return self.code


class Period:
    def __init__(self, day_index, time_slot):
        self.day_index = day_index
        self.time_slot = time_slot

    def __str__(self):
        return "Day " + str(self.day_index) + " - Slot " + str(self.time_slot)


class Lecture:
    def __init__(self, course, period, room):
        self.course = course
        self.period = period
        self.room = room

    def __unicode__(self):
        return self.period + " (" + self.course + ")"