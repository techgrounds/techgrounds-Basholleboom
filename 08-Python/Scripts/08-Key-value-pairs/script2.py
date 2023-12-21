naam=input('naam: ')
achternaam=input('achternaam: ')
functietitel=input('functietitel: ')
bedrijf=input('bedrijf: ')

dict = {
    "naam": naam,
    "achternaam": achternaam,
    "functietitel": functietitel,
    "bedrijf": bedrijf
}
#for x, y in dict.items():
#   print(x, y)

import csv

# csv header
fieldnames = ['naam', 'achternaam', 'functietitel', 'bedrijf']

# csv data
rows = [
    {"naam": naam,
    "achternaam": achternaam,
    "functietitel": functietitel,
    "bedrijf": bedrijf}
]


# met 'a' append je ipv overwrite
with open('list.csv', 'a', encoding='UTF8', newline='') as f:
    writer = csv.DictWriter(f, fieldnames=fieldnames)
    writer.writeheader()
    writer.writerows(rows)
