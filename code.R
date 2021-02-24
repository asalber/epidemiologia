# Alfredo Sánchez (asalber@ceu.es)
library(ggplot2)
library(svglite)

test_plot <- function(pre, sen, spe) {
  # Compute the true and false positives and negatives
  tp <- pre * sen
  fn <- pre * (1-sen)
  fp <- (1-pre)*(1-spe)
  tn <- (1-pre)*spe
  # Compute the coordinates for the rectangles of the plot
  xmin <- c(0, 0, pre, pre)
  xmax <- c(pre, pre, 1, 1)
  ymin <- c(0, sen, spe, 0)
  ymax <- c(sen, 1, 1, spe)
  # Create a data frame
  data <- data.frame(Resultado=c("VP", "FN", "FP", "VN"), Frecuencia=paste0(c(tp, fn, fp, tn) * 100, '%'), xmin, xmax, ymin, ymax)
  # Generate the plot
  p <- ggplot(data) + geom_rect(aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax, fill=Resultado), colour="white") + 
  geom_text(aes(x=(xmax+xmin)/2, y=(ymin+ymax)/2, label = Frecuencia), size=6) +
  scale_fill_manual(values = c("#CC0000", "#FF3333", "#33FF99", "#00CC66")) +
  ggtitle(paste0("Prevalencia = ", pre*100, "%\nSensibilidad = ", sen*100, "%    Especificidad = ", spe*100, "%")) +
  theme(plot.title = element_text(hjust = 0.5, size = 20),
        axis.title.x = element_blank(), axis.text.x = element_blank(), axis.ticks.x = element_blank(), 
        axis.title.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank(),
        panel.background = element_blank())
  ggsave(paste0("img/resultados-test", pre, "-", sen, "-", spe, ".svg"))
  return(p)
}

# Test with a prevalence 1%, sensitivity 70% and specificity 95%
test_plot(pre=0.01, sen=0.7, spe=0.95)

# Test with a prevalence 10%, sensitivity 70% and specificity 95%
test_plot(pre=0.1, sen=0.7, spe=0.95)

