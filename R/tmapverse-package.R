#' tmapverse Meta-Package for Thematic Mapping
#'
#' The tmapverse package attaches a set of packages that are
#' commonly used for spatial plotting with tmap. It includes tmap and its
#' extensions (tmap.glyphs, tmap.networks, tmap.cartogram), as well as
#' supporting spatial data packages (sf, stars, terra), and cols4all for
#' exploring color palettes. The package is intended for use in thematic mapping
#' workflows and does not include the full set of packages from the R-spatial ecosystem.
#'
"_PACKAGE"

.onAttach <- function(libname, pkgname) {
	# Core tmapverse packages for table
	pkgs <- c("sf", "tmap", "tmap.glyphs", "tmap.networks", "tmap.cartogram", "tmap.mapgl",
			  "stars", "terra", "cols4all")

	# Supporting packages for cols4all GUI (not in table)
	support_pkgs <- c("shiny", "shinyjs", "kableExtra", "colorblindcheck")

	# Load sf first, suppress automatic startup message
	if (requireNamespace("sf", quietly = TRUE)) {
		suppressPackageStartupMessages(library("sf", character.only = TRUE, quietly = TRUE))
	}

	# Attach core packages so functions are directly available
	for (p in setdiff(pkgs, "sf")) {
		if (requireNamespace(p, quietly = TRUE)) {
			suppressPackageStartupMessages(library(p, character.only = TRUE, quietly = TRUE))
		}
	}

	# Load supporting packages silently (not in table)
	for (p in support_pkgs) {
		if (requireNamespace(p, quietly = TRUE) && !p %in% loadedNamespaces()) {
			attachNamespace(p)
		}
	}

	# Collect versions for table
	versions <- vapply(pkgs, function(p) {
		if (requireNamespace(p, quietly = TRUE)) {
			as.character(utils::packageVersion(p))
		} else "not installed"
	}, character(1))

	# Green checkmark
	check <- crayon::green(cli::symbol$tick)

	# Two-column formatting
	n <- ceiling(length(pkgs)/2)
	left  <- sprintf("%s %-14s %-7s", check, pkgs[1:n], versions[1:n])
	right <- sprintf("%s %-14s %-7s", check, pkgs[(n+1):length(pkgs)], versions[(n+1):length(pkgs)])
	if (length(left) > length(right)) right <- c(right, rep("", length(left) - length(right)))
	pkg_table <- paste0(left, "    ", right, collapse = "\n")

	# Manually print sf linking line
	sf_ext <- sf::sf_extSoftVersion()
	sf_line <- paste0(
		"Linking to GEOS ", sf_ext[["GEOS"]],
		", GDAL ", sf_ext[["GDAL"]],
		", PROJ ", sf_ext[["PROJ"]],
		"; sf_use_s2() is ", sf::sf_use_s2()
	)

	# Print tidyverse-style startup
	msg = paste(
		cli::cat_line(c("i"= "Loading tmapverse")),
		cli::cat_line(sf_line),
		cli::cat_rule(left = "Attaching packages", right = "tmapverse"),
		cli::cat_line(pkg_table),
		sep = "\n"
	)
	packageStartupMessage(msg)
}
