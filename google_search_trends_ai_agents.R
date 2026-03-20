library(tidyverse)
library(here)
library(gghighlight)
library(scales)

end_date <- as.Date("2026-01-30")
start_date <- as.Date("2025-11-24")

gst <- vroom::vroom(here("raw_data","time_series_Worldwide_20250101-0000_20260320-0856.csv"),delim = ",")

label_data <- gst %>%
  slice(c(3,11,15))



gst |> 
  ggplot(
    aes(
      x = Time,
      y = `AI agent`
    )
  )+
  geom_rect(
    aes(
      xmin = start_date,
      xmax = end_date,
      ymin = -Inf,  # Extends to bottom of plot
      ymax = Inf    # Extends to top of plot
    ),
    fill = "gray80",
    alpha = 0.2,    # Transparency
    color = NA      # No border
  ) +
  geom_line(linewidth = 1) +
   labs(
    title = "One year ago, nobody cared about AI agents",
    x = "",
    y = "relative serach Interest",
    caption = "see Google Search Trends for definition of Interest, absolute numbers not provided"
  )+
  geom_text(
    data = label_data,
    aes(
      label = percent(`AI agent` / 100),
    ),
    nudge_y = 3
  )+
  scale_y_continuous(
    breaks = c()
  )+
  theme_minimal(
    base_size = 18
  )+
  theme(
    panel.grid = element_blank(),
    # axis.line.y = element_line()
  )

ggsave(
  filename = "ai_agents.png",
  width = 3840,
  height = 2160,
  units = "px")
  