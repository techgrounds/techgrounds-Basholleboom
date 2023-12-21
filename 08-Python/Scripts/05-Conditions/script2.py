x=0                             #definieert x
while x != 100:                 #start loop tot 100 wordt ingevoerd
    x=input("uw nummer ", )
    x=int(x)                    #zet x naar type integer
    if x < 100:
        print("laag")
    if x > 100:
        print("hoog")
    if x == 100: 
        print("nice")