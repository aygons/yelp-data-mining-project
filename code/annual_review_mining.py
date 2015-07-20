import dateutil.parser as parser
import csv

def haishixiebuchu(N):
  f1 = open('c'+str(N)+'.csv','wb')
  f1.write('BID,positive,negative,cool,funny,useful,year,annual review,rRate\n')
  with open('b'+str(N)+'.csv','rb') as csvfile:
     csvfile.next()
     datareader = csv.reader(csvfile)
     yr =[]
     total_pos = 0
     total_neg = 0
     total_cool = 0
     total_funny = 0
     total_useful = 0
     total_review = 0
     for row in datareader:
        if parser.parse(row[6]).year < 2015:
            total_review += 1
            total_pos += int(row[0])
            total_neg += int(row[1])
            total_cool += int(row[2])
            total_funny += int(row[4])
            total_useful += int(row[8])
            y = parser.parse(row[6]).year
            if y not in yr:
                              yr.append(y)
     l = len(yr)

     if l == 1:
        f1.write(row[3]+','+str(total_pos/l)+','+str(total_neg/l)+','+str(total_cool/l)+','+str(total_funny/l)+','+str(total_useful/l)+','+str(l)+','+str(total_review)+',NA\n')
     else:
        
        start = min(yr)
        end = max(yr)
        # s_pos = 0
        # s_neg = 0
        # s_cool = 0
        # s_funny = 0
        # s_useful = 0
        # e_pos = 0
        # e_neg = 0
        # e_cool = 0
        # e_funny = 0
        # e_useful = 0
        s = 0
        e = 0
        with open('b'+str(N)+'.csv','rb') as csvfile:
             csvfile.next()
             datareader = csv.reader(csvfile)
             for rrow in datareader:
                if parser.parse(row[6]).year < 2015:
                     y = parser.parse(rrow[6]).year

                     if y == start:
                        s += 1
                        # s_pos += float(rrow[0])
                        # s_neg += float(rrow[1])
                        # s_cool += float(rrow[2])
                        # s_funny += float(rrow[4])
                        # s_useful += float(rrow[8])
                     if y == end:
                        e += 1
                        # e_pos += float(rrow[0])
                        # e_neg += float(rrow[1])
                        # e_cool += float(rrow[2])
                        # e_funny += float(rrow[4])
                        # e_useful += float(rrow[8])
             # rate_p = (e_pos-s_pos)/(end-start)
             # rate_n = (e_neg-s_neg)/(end-start)
             # rate_c = (e_cool-s_cool)/(end-start)
             # rate_f = (e_funny-s_funny)/(end-start)
             # rate_u = (e_useful-s_useful)/(end-start)
             rate = (float(e)-float(s))/float((end-start))
             f1.write(row[3]+','+str(total_pos/l)+','+str(total_neg/l)+','+str(total_cool/l)+','+str(total_funny/l)+','+str(total_useful/l)+','+str(l)+','+str(float(total_review)/l)+','+str(rate)+'\n')
  f1.close()
