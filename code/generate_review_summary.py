from review_mining import xiebuchu568

N = 521; # Specify reviews of how many restaurants you want to mine and summarize

for i in range(100,N):
    xiebuchu568(i)

##f=open("out.csv","a")
##
##for line in open("b1.csv"):
##    f.write(line)
##    
##for j in range(2,N):
##    g = open("b"+str(j)+".csv")
##    g.next() # Skip the header
##    for line in f:
##         f.write(line)
##    g.close()
##f.close()
