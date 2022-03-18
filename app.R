library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(dashBootstrapComponents)
library(ggplot2)
library(plotly)
library(tidyr)
library(dplyr)
library(readr)

app <- Dash$new(external_stylesheets = dbcThemes$BOOTSTRAP)
app$title("Music Explorer")
df <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-01-21/spotify_songs.csv")

genres <- c("pop","rap","rock","latin","r&b","edm")
features <- c("danceability","energy","mode","speechiness","acousticness","liveness","valence","loudness")


app$layout(
    dbcContainer(
        # dbcRow(
        #     div(
        #         list(
        #             htmlH1("Spotify Music Explorer"),
        #             dbcButton("About", id = "toast-toggle"),
        #             dbcToast(
        #                 list(p(htmlA('GitHub', href='https://github.com/UBC-MDS/music_explorer_r',
        #                              style=list("text-decoration" = "underline")),
        #                        htmlP("The dashboard was created by Dongxiao Li, Rong Li, Zihan Zhou. It is licensed under the terms of the MIT license."),
        #                        htmlA("Data", href = 'https://raw.githubusercontent.com/UBC-MDS/music_explorer/main/data/spotify_songs.csv',
        #                              style =list("text-decoration" = "underline")),
        #                        htmlP("The dataset was derived from the open Spotify music database."))),
        #                 id = "toast",
        #                 header = "About",
        #                 dismissable = TRUE,
        #                 is_open = FALSE
        #             )
        #         )
        #     )
        # ),#row1
        list(
            dbcToast(
                list(p(htmlA('GitHub', href='https://github.com/UBC-MDS/music_explorer_r',
                             style=list("text-decoration" = "underline")),
                       htmlP("The dashboard was created by Dongxiao Li, Rong Li, Zihan Zhou. It is licensed under the terms of the MIT license."),
                       htmlA("Data", href = 'https://raw.githubusercontent.com/UBC-MDS/music_explorer/main/data/spotify_songs.csv',
                             style =list("text-decoration" = "underline")),
                       htmlP("The dataset was derived from the open Spotify music database."))),
                id = "toast",
                header = "About",
                dismissable = TRUE,
                is_open = FALSE,
                style=list("position"="fixed", 
                           "top"=75, 
                           "right"=10, 
                           "width"= 350, 
                           "z-index"= "1"),
            ),
        
        
        dbcRow(list(
            
            htmlDiv(
                htmlImg(src="assets/icon.png", height="60px"),
                style =list("position" = "absolute",
                    "top"= "10px",
                    "left"= 0,
                    "width"= 70 )
            ),
            
            htmlDiv("Spotify Music Explorer",
                     style= list('font-size'= "260%", 'color'="#FFF",'text-aligh'='left', 
                         "padding"= "0",
                         "white-space"="nowrap",
                         "position" = "absolute",
                         "top"= 10, 
                         "left"= 90, 
                         "width"=800
                     ),),
            
            dbcButton(
                "About",
                id="toast-toggle",
                color="#074983",
                n_clicks=0,
                style=list(
                    
                    "white-space"="nowrap",
                    "top"= 9,
                    "position" = "absolute",
                    "right"="20px",
                    'text-aligh'='center',
                    "width"= 120
                )
            )
            
        ),
        id="header",
        className="g-0",
        style=list(
            "background-image"= "linear-gradient(to right, #074983,#9198e5)",
            # "max-width"="100%",
            "width"="100%",
            "height"=80, 
            "z-index"= "1"
        )),
        
        
        dbcCol(
            dbcRow(
                list(
                    htmlBr(),
                    htmlBr(),
                    htmlBr(),
                    htmlBr(),
                    htmlBr(),
                    htmlBr(),
                    htmlP(list(
                        "The music explorer dashboard is designed for the purpose of helping music lovers and members of Spotify music platform to explore the trends of songs and artists.",
                        htmlBr(),
                        htmlBr(),
                        "Start using the dashboard by limiting the songs' popularity range and selecting the music genre you are interested in."
                    ),
                    style = list("font-size"=20,
                        'color'= '#3F69A9',
                        'font-family'= 'sans-serif',
                        "position"="absolute",
                        "top"=40,
                        "left"=0,
                        "bottom"= 0,
                        "width"="18%",
                        "z-index"= "1")),
                    htmlBr()
                    
                ),
            ),
            width=2,
            style=list(
                "position"= "absolute",
                "top"= 80,
                "left"= 0,
                "bottom"= 0,
                "width"="100%",
                "height"=920,
                "padding"= "2rem 1rem"
                # "background-image"= "url(/assets/background.jpg)",
                # "background-color"= "#E4EBF5",
                # "background-blend-mode"="overlay"
            )
        ), 
            

            
            
        # list(
        # dbcRow(
        #     list(
        #         dbcCard(
        #             list(h1('Spotify Music Explorer')),
        #             style= list('font-size'= "300%", 'color'='#3F69A9','text-aligh'='center')
        #         )
        #     )
        # ),
        htmlBr(),
        
        
        dbcContainer(list(
        
        
        dbcRow(
            list(
                div(
                    style = list(width='50%'),
                dbcCol(
                    list(
                    dbcCard(
                        list(
                            dbcCardHeader(
                                htmlLabel('What kinds of music do you like to explore?',
                                          style = list("font-size"=18, 'text_aligh'= 'left', 'color'= '#3F69A9', 'font-family'= 'sans-serif'))),
                            htmlBr(),
                            dbcCardBody(
                                list(
                                htmlBr(),
                                htmlP('Popularity range'),
                                dccRangeSlider(
                                    id = "pop-range",
                                    min = 0,
                                    max = 100,
                                    marks = list("0"="0", "25"="25","50"="50","75"="75","100"="100"),
                                    value = list(5,100)
                                ),
                                htmlBr(),
                                htmlBr(),
                                htmlBr(),
                                htmlBr(),
                                htmlP('Music Genre Dropdown Menu'),
                                dccChecklist(
                                    id = 'genre-select',
                                    options = genres %>% purrr::map(function(genre, pop) list(label = genre, value = genre)),
                                    value=list("rock","pop"),
                                    labelStyle=list("display" = "block", "margin-left" = "30px")
                                )
                                )
                                
                            )
                        )
                    )
                    )
                )
                ),#div1
               div(
                   style = list(width = '50%'),
               dbcCol(
                   list(
                       dbcCardHeader(htmlLabel("How many songs in the genres selected?",
                                               style = list("font-size"=18, 'text_aligh'= 'left', 'color'= '#3F69A9', 'font-family'= 'sans-serif'))),
                       dbcCardBody(
                           list(
                               dbcCol(dccGraph(id = "plot-bar")
                             )
                           )
                       )
                   )
               )
               )
                
            )
        ),#row2
        dbcRow(
            list(
                div(
                    style = list(width = '50%'),
                    dbcCol(
                        list(
                            dbcCardHeader(htmlLabel("What are some artists' popularity trend within the selected range?",
                                                    style = list("font-size"=18, 'text_aligh'= 'left', 'color'= '#3F69A9', 'font-family'= 'sans-serif'))),
                            dbcCardBody(
                                list(
                                    dccDropdown(
                                        id='artist_names',
                                        # options = genres %>% purrr::map(function(genre, pop) list(label = genre, value = genre)),
                                        value=list("Queen","The Cranberries", "Calvin Harris", "David Guetta"),
                                        multi=TRUE),
                                    dbcCol(dccGraph(id = "plot-2"))
                                )
                            )
                        )
                    )

                    
                ),
                div(
                    style = list(width = '50%'),
                
                    dbcCol(
                        list(
                            dbcCardHeader(htmlLabel("What's the relationship between songs' features and the popularity?",
                                                    style = list("font-size"=18, 'text_aligh'= 'left', 'color'= '#3F69A9', 'font-family'= 'sans-serif'))),
                            dbcCardBody(
                                list(
                                    dccDropdown(
                                        id = 'features',
                                        options = features %>% purrr::map(function(feature, pop) list(label = feature, value = feature)),
                                        value="danceability",
                                        multi=FALSE
                                    ),
                                    dbcCol(dccGraph(id = "plot-3"))
                                )
                            )
                        )
                    )
            
                )
            )
        )
        
        
        ),
        style=list(
            "position"= "absolute",
            "left"= "17%",
            "max-width"= "83%",
            "top"= "90px")
        
        )
    ),
    style = list(
        "max-width"= "100%",
        "padding"= "0")
    
   )
)

# plot 1
app$callback(
    output('plot-bar', 'figure'),
    list(input('genre-select', 'value'),
         input('pop-range','value')),
    function(genre, pop) {
        p <- df %>%
            filter(playlist_genre %in% genre) %>%
            filter(track_popularity >= pop[1] & track_popularity <= pop[2]) %>%
             ggplot(aes(y = playlist_genre,
                 fill = playlist_genre)) +
            geom_bar(alpha = 0.6) +
            xlab("Music Genres") +
            ylab("Number of Song Records") +
            #ggthemes::scale_fill_tableau() +
            theme_bw()
        p <- p + guides(fill=guide_legend(title="Music Genre"))
        ggplotly(p)
    }
)

# plot3
app$callback(
    output('plot-3', 'figure'),
    list(input('genre-select', 'value'),
         input('pop-range','value'),
         input("features", "value")
    ),
    function(genre, pop, feature){
        pop_min <- pop[1]
        pop_max <- pop[2]
        filtered_df <- df %>%
            filter(playlist_genre %in% genre) %>%
            filter(track_popularity >= pop_min & track_popularity <= pop_max)
        
        if (is.null(feature)|length(feature) == 0){
            feature<-"danceability"}
        #else{feature<-features[1]}
        
        filtered_df$`Music Genres` = filtered_df$playlist_genre
        
        
        p <- filtered_df %>% ggplot(aes(y = track_popularity,
                                        x = !!sym(feature),
                                        color = `Music Genres`)) +
            geom_point(alpha=0.5) +
            ylab("popularity") +
            #ggthemes::scale_fill_tableau() +
            theme_bw() 
        p <- p + theme(legend.title=element_blank())
        ggplotly(p)
    }
)
# plot2
app$callback(
    output("artist_names", "options"),
    list(input('genre-select', 'value'),
         input('pop-range','value')),
    function(genre, pop){
        pop_min <- pop[1]
        pop_max <- pop[2]
        suggested_list  <-  df %>% drop_na() %>%
            filter(playlist_genre %in% genre) %>%
            filter(track_popularity >= pop_min & track_popularity <= pop_max)%>%
            group_by(track_artist) %>%
            summarize(count=n())%>%
            arrange(desc(count))%>%
            pull(track_artist)
        
        result <- suggested_list %>% purrr::map(function(track_artist) list(label = track_artist, value = track_artist))
        result
    }
)
app$callback(
    output('plot-2', 'figure'),
    list(input('genre-select', 'value'),
         input('pop-range','value'),
         input("artist_names", "value")
    ),
    function(genre, pop, artist) {
        pop_min <- pop[1]
        pop_max <- pop[2]
        filtered_df <- df %>% drop_na() %>%
            filter(playlist_genre %in% genre) %>%
            filter(track_popularity >= pop_min & track_popularity <= pop_max)
        if (is.null(artist)|length(artist) == 0){
            artist <- filtered_df %>%
                group_by(track_artist) %>%
                summarize(count=n())%>%
                arrange(desc(count))%>%
                pull(track_artist)
            artist <- artist[1:5]
        }
        filtered_df <- filtered_df%>%
            filter(track_artist %in% artist)
        filtered_df$year <- as.numeric(substr(filtered_df$track_album_release_date, 1,4))
        # if using direct labeling
        order <- filtered_df %>%
            group_by(track_artist, year) %>%
            summarize(popularity = mean(track_popularity))%>%
            arrange(desc(year)) %>%
            distinct(track_artist,.keep_all = TRUE)
        
        p <- filtered_df %>%
            ggplot(aes(x = year,
                       y = track_popularity,
                       color = track_artist,
            )) +
            geom_point(alpha = 0.6) +
            #ggthemes::scale_fill_tableau()+
            geom_line(stat = 'summary', fun = 'mean')+
            geom_text(
                data = order,
                ggplot2::aes_string(x = "year", y = "popularity", color = "track_artist", label = "track_artist"),
                size = 3.5,
                vjust = -3,
                hjust = 0.7
            )+
            theme_bw()+
            theme(legend.position = 'none') +
            labs(x="Year",
                 y="Popularity",
            )
        
        # p <- df %>% drop_na() %>%
        #         filter(playlist_genre %in% genre) %>%
        #         filter(track_popularity >= pop[1] & track_popularity <= pop[2]) %>%
        #      ggplot(aes(x = playlist_genre,
        #          fill = playlist_genre)) +
        #     geom_bar(alpha = 0.6) +
        #     ggthemes::scale_fill_tableau() +
        #     theme_bw()
        ggplotly(p)
    }
)

app$callback(output('toast', 'is_open'),
             list(input('toast-toggle', 'n_clicks')),
function(n){
    if(n){
        TRUE
    }else{
        FALSE
    }
    
})

app$run_server(host = '0.0.0.0')
