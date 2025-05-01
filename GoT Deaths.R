# 📦 Install required packages if not already installed
install.packages(c("ggplot2", "viridis"))
library(ggplot2)
library(viridis)

# 📊 Final combined dataset: GoT characters who died
got_died <- data.frame(
  Character = c(
    "Ned Stark", "Robb Stark", "Ramsay Bolton", "Stannis Baratheon", "Night King",
    "Robert Baratheon", "Joffrey Baratheon", "Viserys Targaryen", "Renly Baratheon",
    "Mance Rayder", "Oberyn Martell", "Ygritte", "Missandei", "Jorah Mormont",
    "Theon Greyjoy", "Catelyn Stark", "Tywin Lannister", "Petyr Baelish", "Styr",
    "Barristan Selmy", "Thoros of Myr", "Lysa Arryn", "Qyburn", "Ros", "Khal Drogo",
    "Hizdahr zo Loraq", "Shae", "Roose Bolton", "Myrcella Baratheon", "Alliser Thorne",
    "Daenerys Targaryen", "Sandor Clegane", "Eddard (Dolorous Edd)", "Beric Dondarrion",
    "Melisandre", "Varys", "Euron Greyjoy", "Qhono", "Rhaegal"
  ),
  First_Season = c(
    1,1,3,2,4,1,1,1,1,3,4,2,3,1,1,1,1,1,4,1,3,1,3,1,1,4,1,2,1,1,
    1,1,1,1,2,1,6,6,5
  ),
  Last_Season = c(
    1,3,6,5,8,1,4,1,2,5,4,4,8,8,8,3,4,7,4,5,7,4,8,3,1,5,4,6,5,6,
    8,8,8,8,8,8,8,8,8
  ),
  Screen_Time = c(
    166,198,83,146,8,49,135,27,27,20,38,60,42,144,131,127,130,75,5,
    36,20,18,22,12,50,9,70,41,14,25,524,199,36,32,60,130,48,10,15
  ),
  Death_Style = c(
    "beheading", "stabbing", "devoured", "burned", "stabbed", "boar", "poison",
    "molten gold", "shadow", "burned", "skull crushed", "shot", "beheaded", "stabbed",
    "stabbed", "throat slit", "crossbow", "throat slit", "stabbed", "ambushed", "bear",
    "pushed", "killed", "arrow", "infection", "stabbed", "strangled", "stabbed",
    "poison", "hanged", "stabbed", "fall", "stabbed", "burned", "aged", "burned",
    "stabbed", "burned", "scorpioned"
  )
)

# 🛠 Add display label and midpoint for text
got_died$Label <- paste0(got_died$Character, " (", got_died$Death_Style, ")")
got_died$Mid_Season <- (got_died$First_Season + got_died$Last_Season) / 2

# 📐 Order by screen time
got_died$Character <- factor(got_died$Character, levels = got_died$Character[order(got_died$Screen_Time)])

# 📊 Gantt-style visualization
ggplot(got_died, aes(y = Character)) +
  geom_segment(aes(x = First_Season, xend = Last_Season,
                   yend = Character, color = Screen_Time),
               size = 6, alpha = 0.9) +
  geom_text(aes(x = Mid_Season, label = Label),
            color = "black", fontface = "bold", size = 3.1, hjust = 0.5) +
  scale_color_viridis(name = "Screen Time (min)", option = "D", direction = -1) +
  labs(
    title = "💀 Game of Thrones: Death Timeline of Major Characters",
    subtitle = "Each bar shows screen lifespan (season span), labeled with death method",
    x = "Season",
    y = NULL
  ) +
  theme_minimal(base_family = "Helvetica") +
  theme(
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    panel.grid.major.y = element_blank(),
    plot.title = element_text(size = 16, face = "bold"),
    plot.subtitle = element_text(size = 12, color = "gray40")
  )
