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
	# Core tmapverse packages
	core_pkgs <- c(
		"sf", "tmap", "tmap.glyphs", "tmap.networks",
		"tmap.cartogram", "tmap.mapgl", "stars", "terra", "cols4all"
	)

	# Supporting packages (used for cols4all GUI, not in startup table)
	support_pkgs <- c("shiny", "shinyjs", "kableExtra", "colorblindcheck")

	# Attach core packages quietly
	attach_core(core_pkgs)

	# Attach supporting namespaces (no search path clutter)
	for (p in support_pkgs) {
		if (requireNamespace(p, quietly = TRUE) && !p %in% loadedNamespaces()) {
			attachNamespace(p)
		}
	}

	# Collect versions
	versions <- vapply(core_pkgs, function(p) {
		if (requireNamespace(p, quietly = TRUE)) {
			as.character(utils::packageVersion(p))
		} else {
			"not installed"
		}
	}, character(1))

	# Emit tidyverse-style startup message
	packageStartupMessage(startup_msg(core_pkgs, versions))
}

attach_core <- function(pkgs) {
	for (p in pkgs) {
		if (requireNamespace(p, quietly = TRUE)) {
			suppressPackageStartupMessages(
				library(p, character.only = TRUE, quietly = TRUE)
			)
		}
	}
}

startup_msg <- function(pkgs, versions) {
	check <- crayon::green(cli::symbol$tick)

	# Two-column table
	n <- ceiling(length(pkgs) / 2)
	left  <- sprintf("%s %-14s %-7s", check, pkgs[1:n], versions[1:n])
	right <- sprintf("%s %-14s %-7s", check, pkgs[(n+1):length(pkgs)], versions[(n+1):length(pkgs)])
	if (length(left) > length(right)) {
		right <- c(right, rep("", length(left) - length(right)))
	}
	pkg_table <- paste0(left, "    ", right, collapse = "\n")

	# sf linking line
	sf_ext <- sf::sf_extSoftVersion()
	sf_line <- paste0(
		"Linking to GEOS ", sf_ext[["GEOS"]],
		", GDAL ", sf_ext[["GDAL"]],
		", PROJ ", sf_ext[["PROJ"]],
		"; sf_use_s2() is ", sf::sf_use_s2()
	)

	# Build banner with format_* (no printing yet!)
	paste(
		cli::format_message("Loading tmapverse"),
		sf_line,
		cli::rule(left = "Attaching packages", right = "tmapverse"),
		pkg_table,
		sep = "\n"
	)
}
