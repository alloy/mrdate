#!/usr/local/bin/macruby

# NSDate docs mention:
#
# NSDate models the change from the Julian to the Gregorian calendar in October
# 1582, and calendrical calculations performed in conjunction with NSCalendar
# take this transition into account. Note, however, that some locales adopted
# the Gregorian calendar at other times; for example, Great Britain didn't
# switch over until September 1752.
#
# Not sure if that means, be aware of this, or that it's possible to create a
# date in some which takes this into account...

framework 'Foundation'

PARSE_COMPONENTS = NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit
c = NSCalendar.alloc.initWithCalendarIdentifier(NSGregorianCalendar)

l = NSLocale.alloc.initWithLocaleIdentifier("en_GB")
p l.localeIdentifier
c.locale = l

components = NSDateComponents.new
components.year = 1752
components.month = 9
components.day = 3

d = c.dateFromComponents(components)

components = c.components(PARSE_COMPONENTS, fromDate: d)
p components.year, components.month, components.day