library(rvest)
library(janitor)
library(dplyr)
library(readr)

link <- "https://en.wikipedia.org/wiki/List_of_Formula_One_drivers"

page <- read_html("raw_data/f1_drivers_wiki_page.html")

drivers_F1 <- html_element(page, "table.sortable") %>%
  html_table() |> 
  clean_names() 

drivers_F1 <- drivers_F1 |> 
  select(
    driver_name,
    nationality,
    seasons_competed,
    drivers_championships,
    pole_positions,
    race_wins,
    podiums
  ) |> 
  slice_head(
    n = nrow(drivers_F1)-1
  ) |> 
  mutate(
    drivers_championships = parse_number(substr(drivers_championships,start = 1, stop = 1)),
    race_wins = parse_number(race_wins),
    pole_positions = parse_number(pole_positions)
  )


championships_by_nation <- drivers_F1 %>%
  group_by(
    nationality
  ) |> 
  summarise(
    championship_wins = sum(drivers_championships)
  )

championships_by_driver <- drivers_F1 %>%
  group_by(
    driver_name
  ) |> 
  summarise(
    championship_wins = sum(drivers_championships)
  )

drivers_F1 %>%
  filter(pole_positions > 1) %>%
  ggplot(aes(x = pole_positions, y = drivers_championships)) +
  geom_point(position = "jitter") +
  labs(y = "Championships won", x = "Pole positions") +
  geom_smooth(
    method = "lm"
  )+
  theme_minimal()
