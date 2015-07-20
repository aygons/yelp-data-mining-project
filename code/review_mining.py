import csv
import re

def xiebuchu568(N):

    businessID =[];

    # Generate Dictionary Begin
    with open('positive_words.txt') as f:
        pw = f.readlines()
    pw = map(lambda s: s.strip(), pw)
    p_dict = dict(zip(pw,range(0,len(pw))))
    with open('negative_words.txt') as g:
        nw = g.readlines()
    nw = map(lambda s: s.strip(), nw)
    n_dict = dict(zip(nw,range(0,len(nw))))
    # Generate Dictionary End


    # Import BusinessID Start
    with open('pitt.csv') as h:
        sbreader = csv.reader(h)
        for roww in sbreader:
            businessID.append(roww[0])
    businessID.pop(0)
    # Import BusinessID End


    # Body Part Begin
    fd = open('b'+str(N)+'.csv','ab') # Write the review information into files with naming convention b+number.csv
    fd.write("positive, negative, cool, BID, funny, stars, date,type,useful\n") # Add column names at beginning
    with open('review.csv', "rb") as csvfile:
        datareader = csv.reader(csvfile)
        # i=0 for test purpose
        for row in datareader:
            if row[4] == businessID[N-1]: # CHANGE N TO CHANGE THE BUSINESS ID
                for j in range(2,len(row)):
                    pro = 0
                    neg = 0
                    if j != 2:
                        fd.write(str(row[j])+", ")
                    else:
                        # if i < 3: for test purpose
                        #     i+=1
                        #     print i
                        #     print re.sub(r'\\[a-z]*[A-z]*\s','',row[2])
                        text = re.sub(r'\\[a-z]*[A-z]*\s','',row[2]) # Remove special characters from review texts
                        for word in text.split(' '): # Iterate through review texts to count number of pos. & neg. words
                            if word in p_dict:
                                pro += 1
                            if word in n_dict:
                                neg += 1
                        fd.write(str(pro)+","+str(neg)+",")
                fd.write("\n")
    fd.close()
    return