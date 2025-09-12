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


#
# # .onAttach <- function(libname, pkgname) {
# # 	pkgs <- c("sf", "tmap", "tmap.glyphs", "tmap.networks", "tmap.cartogram",
# # 			  "stars", "terra", "cols4all")
# #
# # 	# Load sf first
# # 	if (requireNamespace("sf", quietly = TRUE)) {
# # 		suppressPackageStartupMessages(library("sf", character.only = TRUE))
# # 	}
# #
# # 	# Load the rest silently
# # 	for (p in setdiff(pkgs, "sf")) {
# # 		if (requireNamespace(p, quietly = TRUE)) {
# # 			suppressPackageStartupMessages(library(p, character.only = TRUE))
# # 		}
# # 	}
# #
# # 	# Collect versions
# # 	versions <- vapply(pkgs, function(p) {
# # 		if (requireNamespace(p, quietly = TRUE)) {
# # 			as.character(utils::packageVersion(p))
# # 		} else {
# # 			"not installed"
# # 		}
# # 	}, character(1))
# #
# # 	# Green checkmark
# # 	check <- crayon::green(cli::symbol$tick)
# #
# # 	# Two-column formatting
# # 	n <- ceiling(length(pkgs)/2)
# # 	left  <- sprintf("%s %-14s %-7s", check, pkgs[1:n], versions[1:n])
# # 	right <- sprintf("%s %-14s %-7s", check, pkgs[(n+1):length(pkgs)], versions[(n+1):length(pkgs)])
# # 	if (length(left) > length(right)) right <- c(right, rep("", length(left) - length(right)))
# # 	pkg_table <- paste0(left, "    ", right, collapse = "\n")
# #
# # 	# Use cli to write to stdout (white background in RStudio)
# # 	sf_ext <- sf::sf_extSoftVersion()
# # 	sf_line <- paste0("Linking to GEOS ", sf_ext[["GEOS"]],
# # 					  ", GDAL ", sf_ext[["GDAL"]],
# # 					  ", PROJ ", sf_ext[["PROJ"]],
# # 					  "; sf_use_s2() is ", sf::sf_use_s2())
# # 	cli::cat_line("ℹ Loading tmapverse")
# # 	cli::cat_line(sf_line)
# # 	cli::cat_rule(left = "Attaching packages", right = "tmapverse")
# # 	cli::cat_line(pkg_table)
# # }
#
# #
# # .onAttach <- function(libname, pkgname) {
# # 	pkgs <- c("sf", "tmap", "tmap.glyphs", "tmap.networks", "tmap.cartogram",
# # 			  "stars", "terra", "cols4all")
# #
# # 	# Attach namespaces safely
# # 	attached <- vapply(pkgs, function(p) {
# # 		if (requireNamespace(p, quietly = TRUE)) {
# # 			if (!p %in% loadedNamespaces()) {
# # 				attachNamespace(p)
# # 			}
# # 			TRUE
# # 		} else {
# # 			FALSE
# # 		}
# # 	}, logical(1))
# #
# # 	# Collect versions
# # 	versions <- vapply(pkgs, function(p) {
# # 		if (requireNamespace(p, quietly = TRUE)) {
# # 			as.character(utils::packageVersion(p))
# # 		} else {
# # 			"not installed"
# # 		}
# # 	}, character(1))
# #
# # 	# Green checkmark
# # 	check <- crayon::green(cli::symbol$tick)
# #
# # 	# Two-column formatting
# # 	n <- ceiling(length(pkgs)/2)
# # 	left  <- sprintf("%s %-14s %-7s", check, pkgs[1:n], versions[1:n])
# # 	right <- sprintf("%s %-14s %-7s", check, pkgs[(n+1):length(pkgs)], versions[(n+1):length(pkgs)])
# # 	if (length(left) > length(right)) right <- c(right, rep("", length(left) - length(right)))
# # 	pkg_table <- paste0(left, "    ", right, collapse = "\n")
# #
# # 	# sf linking line
# # 	if (requireNamespace("sf", quietly = TRUE)) {
# # 		sf_ext <- sf::sf_extSoftVersion()
# # 		sf_line <- paste0("Linking to GEOS ", sf_ext[["GEOS"]],
# # 						  ", GDAL ", sf_ext[["GDAL"]],
# # 						  ", PROJ ", sf_ext[["PROJ"]],
# # 						  "; sf_use_s2() is ", sf::sf_use_s2())
# # 	} else {
# # 		sf_line <- "sf not installed"
# # 	}
# #
# # 	# Print tidyverse-style startup
# # 	cli::cat_line(c("i" = "Loading tmapverse"))
# # 	cli::cat_line(sf_line)
# # 	cli::cat_rule(left = "Attaching packages", right = "tmapverse")
# # 	cli::cat_line(pkg_table)
# # }
#
#
# .onAttach <- function(libname, pkgname) {
# 	pkgs <- c("sf", "tmap", "tmap.glyphs", "tmap.networks", "tmap.cartogram",
# 			  "stars", "terra", "cols4all")
#
# 	# Attach each package safely
# 	for (p in pkgs) {
# 		if (requireNamespace(p, quietly = TRUE)) {
# 			# Use one function via :: to satisfy R CMD check
# 			invisible(utils::packageVersion(p))
#
# 			# Attach the namespace (like library() but CRAN-friendly)
# 			if (!p %in% loadedNamespaces()) attachNamespace(p)
#
# 			# Optionally also attach to search path
# 			if (!p %in% loadedNamespaces() || !p %in% search()) {
# 				try(suppressWarnings(
# 					attachNamespace(p)
# 				), silent = TRUE)
# 			}
# 		}
# 	}
#
# 	# Collect versions
# 	versions <- vapply(pkgs, function(p) {
# 		if (requireNamespace(p, quietly = TRUE)) {
# 			as.character(utils::packageVersion(p))
# 		} else "not installed"
# 	}, character(1))
#
# 	# Green checkmark
# 	check <- crayon::green(cli::symbol$tick)
#
# 	# Two-column formatting
# 	n <- ceiling(length(pkgs)/2)
# 	left  <- sprintf("%s %-14s %-7s", check, pkgs[1:n], versions[1:n])
# 	right <- sprintf("%s %-14s %-7s", check, pkgs[(n+1):length(pkgs)], versions[(n+1):length(pkgs)])
# 	if (length(left) > length(right)) right <- c(right, rep("", length(left) - length(right)))
# 	pkg_table <- paste0(left, "    ", right, collapse = "\n")
#
# 	# sf linking line
# 	if (requireNamespace("sf", quietly = TRUE)) {
# 		sf_ext <- sf::sf_extSoftVersion()
# 		sf_line <- paste0("Linking to GEOS ", sf_ext[["GEOS"]],
# 						  ", GDAL ", sf_ext[["GDAL"]],
# 						  ", PROJ ", sf_ext[["PROJ"]],
# 						  "; sf_use_s2() is ", sf::sf_use_s2())
# 	} else {
# 		sf_line <- "sf not installed"
# 	}
#
# 	# Print startup messages
# 	cli::cat_line("ℹ Loading tmapverse")
# 	cli::cat_line(sf_line)
# 	cli::cat_rule(left = "Attaching packages", right = "tmapverse")
# 	cli::cat_line(pkg_table)
# }
#


.onAttach <- function(libname, pkgname) {
	# Core tmapverse packages for table
	pkgs <- c("sf", "tmap", "tmap.glyphs", "tmap.networks", "tmap.cartogram",
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
	cli::cat_line("ℹ Loading tmapverse")
	cli::cat_line(sf_line)
	cli::cat_rule(left = "Attaching packages", right = "tmapverse")
	cli::cat_line(pkg_table)
}
