# How to change ggplot font type and font size:
# Heinermann, Janosch; 2022-02-24

# When making plots in R, often times the letters are too small if you export a plot. 
# Also the text size often varies between plots in your word document. Therefore
# it is smart to just export a plot where all the text sizes are always equal.
# It could also be, that you want to change the text font (Schriftart).
# This script should give you some advise on how to maintain the text size of plots and 
# how to change the font of a plot. We first start by changing the font:

# Load important packages:
# install.packages("ggplot2")
# install.packages("showtext")

library(ggplot2)
library(showtext)

# We can add fonts to R using a function from showtext:
# (fonts can be found at https://fonts.google.com/)
font_add_google("Open Sans", "OpenSans")
# The first input is the name of the font that you want to add to R (take a look on the website, 
# the font is written on top of each font).
# The second input is the name you want to give to the font. The font is called by that name in ggplot.

# Add some other fonts for demonstration
font_add_google("Lobster", "Lobster")
font_add_google("Dancing Script", "Dance_Script")


showtext_auto(enable = TRUE) # Enable showtext for ggplot-functions

# Before we plot something, we create some data:
d <- data.frame(x = 1:10, y = 1:10, label = LETTERS[1:10])

# Look at the data, plot it with ggplot:
ggplot(d)+
  geom_text(aes(x = x, y = y, label = label))

# We can now change the font of the plot text. This is done by calling theme and change the text family.
ggplot(d)+
  geom_text(aes(x = x, y = y, label = label))+
  theme(text = element_text(family = "Lobster"))  # Here we refere to all text elements of ggplot

# We can also change the font of only axis labels.
ggplot(d)+
  geom_text(aes(x = x, y = y, label = label))+
  theme(axis.text.x = element_text(family = "Dance_Script")) # Here we only change X-Axis-Tick-Labels (Text on Axis)

# Or we can change the font of the text elements that we plottet with geoms.
ggplot(d)+
  geom_text(aes(x = x, y = y, label = label), family = "Dance_Script") # Here we only change the Labels of certain geoms

# More details about the possible stuff you can write in themes at:
# https://ggplot2.tidyverse.org/reference/theme.html


# Now that we set the font, we need to set the font size also. 
# Note that you export a plot, that has fixed text sizes. If you change the size of the plot in word,
# then you end up with varying text sizes again. Therefore it makes sense
# to just export the plot with the size that you want your plot to be in word at the end.

# In case you used the showtext-Package before, we need to change the dpi (dots per inch) value:
showtext_opts(dpi = 300)

# First we save the plot in a variable in R:
p <- ggplot(d)+
  geom_text(aes(x = x, y = y, label = label), size = 12 / .pt, family = "Dance_Script", inherit.aes = FALSE)+
  theme(axis.text.x = element_text(family = "Dance_Script"),
        text = element_text(size = 12))

# We then export the plot using ggsave():
ggsave(plot = p, file = "~/MyPlot.png",
       width = 4, height = 3, units = "in", dpi = 300)

# plot   <- which Plot do we save? We defined p before.
# file   <- where do you want to save the plot. This saves the plot at the current working directory (can be accessed using getwd()).
#              It also defines the file format (here png). jpg, pdf, ... are also possible. 
# width  <- Plot width in inches.
# height <- Plot height in inches.
# units  <- "in", "cm", ... 
# dpi    <- dots per inch. The higher the number the better the resolution. 300 is probably fine.

# The problem is, that you should not change the size of the plot inside word, because then you
# end up with varying text sizes again. To avoid this, I recommend to look at your word document. 
# Look how long your text lines are. Just look at the "Lineal" (guide). The text line length 
# can be seen here. The text goes from 0 to some value (for me its 16 cm for example).
# Now take that "some value" and calculate how much it is in inch: For examlple:
MyLineLength <- 16 # [cm]
MyLineLength / 2.54
# My line length is 6.299 inch. I can use this number as an input in ggsave():
ggsave(plot = p, file = "~/MyPlot.png",
       width = MyLineLength / 2.54, height = 3, units = "in", dpi = 300)
# This means the plot that you export fits exaclty in your word document. You have to adjust your height though.
# Of cause you can make a smaller plot, that does not span over your text line. Then just
# save the plot with the size that you need.




# Sources:
# https://stackoverflow.com/questions/34522732/changing-fonts-in-ggplot2/51906008
# https://www.christophenicault.com/post/understand_size_dimension_ggplot2/