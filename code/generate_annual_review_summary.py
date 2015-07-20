from annual_review_mining import haishixiebuchu

N = 521; # Specify reviews of how many restaurants you want to mine and summarize

for i in range(1,N):
    #if i != 11:
    try:
        haishixiebuchu(i)
    except:
        continue

f=open("3out.csv","a")

for line in open("c1.csv"):
    f.write(line)
   
for j in range(2,N):
    try:
    #if j != 11:
        g = open("c"+str(j)+".csv")
        g.next() # Skip the header
        for line in g:
            f.write(line)
        g.close()
    except:
        continue
    
f.close()
