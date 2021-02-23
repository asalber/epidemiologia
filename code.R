# Alfredo Sánchez (asalber@ceu.es)
library(ggplot2)
library(svglite)

pre <- 0.01
sen <- 0.62
spe <- 0.98
tp <- pre * sen
fn <- pre * (1-sen)
fp <- (1-pre)*(1-spe)
tn <- (1-pre)*spe

n <- 1000

xmin <- c(0, 0, pre, pre)
xmax <- c(pre, pre, 1, 1)
ymin <- c(0, sen, spe, 0)
ymax <- c(sen, 1, 1, spe)
data <- data.frame(Resultado=c("VP", "FN", "FP", "VN"), Frecuencia=paste0(c(tp, fn, fp, tn) * 100, '%'), xmin, xmax, ymin, ymax)

p <- ggplot(data) + geom_rect(aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax, fill=Resultado), colour="white") + 
  geom_text(aes(x=(xmax+xmin)/2, y=(ymin+ymax)/2, label = Frecuencia), size=6) +
  scale_fill_manual(values = c("#CC0000", "#FF3333", "#33FF99", "#00CC66")) +
  ggtitle(paste0("Prevalencia = ", pre*100, "%")) +
  theme(plot.title = element_text(hjust = 0.5),
        axis.title.x = element_blank(), axis.text.x = element_blank(), axis.ticks.x = element_blank(), 
        axis.title.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank(),
        panel.background = element_blank())
p
ggsave("img/resultados-test-1.svg")
