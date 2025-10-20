# tmapverse <img src="man/figures/logo.png" align="right" width="120"/>

<!-- badges: start -->
[![CRAN](https://www.r-pkg.org/badges/version/tmapverse)](https://cran.r-project.org/package=tmap)
[![CRAN
checks](https://badges.cranchecks.info/worst/tmapverse.svg)](https://cran.r-project.org/web/checks/check_results_tmap.html)
[![Downloads](https://cranlogs.r-pkg.org/badges/tmapverse?color=brightgreen)](https://www.r-pkg.org:443/pkg/tmapverse)
[![License](https://img.shields.io/badge/License-GPL%20v3-brightgreen.svg?style=flat)](https://www.gnu.org/licenses/gpl-3.0.html)
<!-- badges: end -->

The **tmapverse** is a meta-package that installs and attaches a curated set of packages for thematic mapping in R.  
It brings together the core **tmap** package, its extensions, and supporting spatial and color tools — providing a consistent, high-level framework for visualizing and analyzing spatial data.

---

## Packages in the tmapverse

Core package **tmap** and extension packages

| Package | Description | Logo |
|:--|:--|:--:|
| **tmap** | Core package for static and interactive thematic maps. | <img src="man/figures/tmap.png" width="80"/> |
| **tmap.glyphs** | Add glyphs (small plots) to maps. | <img src="man/figures/tmap_glpyhs.png" width="80"/> |
| **tmap.networks** | Visualize networks and flows on maps. | <img src="man/figures/tmap_networks_hex2.png" width="80"/> |
| **tmap.cartogram** | Create cartograms with distorted geometries. | <img src="man/figures/tmap_cartogram.png" width="80"/> |
| **tmap.mapgl** | Add interactive modes based on ‘Mapbox GL JS’ and ‘MapLibre GL JS’. | <img src="man/figures/tmap_mapgl2.png" width="80"/> |


Under the hood

| Package | Description | Logo |
|:--|:--|:--:|
| **sf** | Simple Features for R — standard for vector spatial data. | <img src="man/figures/sf.png" width="80"/> |
| **stars** | Spatiotemporal arrays for raster and vector data cubes. | <img src="man/figures/stars.png" width="80"/> |
| **terra** | Modern package for raster and vector spatial data. | <img src="man/figures/terra.png" width="80"/> |
| **cols4all** | Explore, compare, and apply color palettes for maps. | <img src="man/figures/cols4all.png" width="80"/> |

---

## tmapverse hex wall

<div class="hex">
  <a href="https://r-tmap.github.io/tmapverse/">
    <svg viewBox="0 0 100 115" preserveAspectRatio="xMidYMid meet" aria-label="tmapverse">
      <defs><clipPath id="hex-0"><polygon points="50 3.7 92.5 28.8 92.5 86.2 50 111.3 7.5 86.2 7.5 28.8"/></clipPath></defs>
      <image clip-path="url(#hex-0)" href="https://raw.githubusercontent.com/r-tmap/tmapverse/main/man/figures/logo.png"
             x="0" y="0" width="100" height="115" preserveAspectRatio="xMidYMid slice"/>
      <polygon points="50 3.7 92.5 28.8 92.5 86.2 50 111.3 7.5 86.2 7.5 28.8"
               fill="none" stroke="rgba(0,0,0,0.06)"/>
    </svg>
  </a>
  <span class="hex-label">tmapverse</span>
</div>

## Installation

Installation of **tmapverse** is straightforward:

```r
install.packages("tmapverse")
```

Install the development version from GitHub:

```r
# install.packages("remotes")
remotes::install_github("r-tmap/tmapverse")
```
