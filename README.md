# Music Explorer (R)

Authors: Dongxiao Li, Rong Li, Zihan Zhou

## Description of App

The app link can be found [here](https://musicexplorer-r.herokuapp.com/).

The full proposal can be found in [our proposal file](https://github.com/UBC-MDS/music_explorer_r/blob/main/docs/proposal.md).

The `music_explorer_r` dashboard is designed for the purpose of helping music lovers and members of Spotify music platform to explore the trends of songs and artists.

The dashboard mainly contains:

- a bar chart that shows the number of songs in the genres that users selected and the popularity range they filtered.

- a scatter plot between different music features (can be selected using the dropdown button by users) of songs and their popularity.

- a time-series line plot that shows artists' popularity trend within the selected range and genres? Users can use the dropdown menu to select one or more artists that they are interested in. 

![](https://github.com/UBC-MDS/music_explorer_r/blob/main/img/app.gif)

## Usage and Installation

Installation is not required when run the dashboard remotely: <https://musicexplorer-r.herokuapp.com/>

If you wish to run the app locally, please run the following commands after cloning the repo:
```
# Install the R packages required 
Rscript init.R

# Run the script
Rscript app.R
```
Finally, open the app in the followin URL: http://localhost:8000/

## Contribution

We welcome all feedback and contributions. If you are interested in contributing, check out the contributing guidelines [here](https://github.com/UBC-MDS/music_explorer_r/blob/main/CONTRIBUTING.md). Please note that this project is released with a [Code of Conduct](https://github.com/UBC-MDS/music_explorer_r/blob/main/CODE_OF_CONDUCT.md). By contributing to this project, you agree to abide by its terms.

## License

`music_explorer_r` was created by Dongxiao Li, Rong Li, Zihan Zhou. It is licensed under the terms of the MIT license [here](https://github.com/UBC-MDS/music_explorer_r/blob/main/LICENSE).
