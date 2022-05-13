
pl<-read.table("processed_oasis_cross-sectional.csv", header=TRUE, sep=",") 
library("rpart") 

# Include all independent variables and run CART anaylsis
pl_rpart<-rpart(CDR~ ., data=pl, control=rpart.control(xval=100)) 
opt<-which.min(pl_rpart$cptable[,"xerror"]) 
cp<-pl_rpart$cptable[opt,"CP"] 
par(mfrow=c(1,2)) 

# Prune the Tree
pl_prune<-prune(pl_rpart,cp=cp) 

# Plot both trees side by side
plot(pl_prune, uniform=TRUE, margin=0.1, branch=0.5, compress=TRUE) 
text(pl_prune) 
print(pl_prune$cptable) 
plot(pl_rpart, uniform=TRUE, margin=0.1, branch=0.5, compress=TRUE) 
text(pl_rpart) 
print(pl_rpart$cptable) 
