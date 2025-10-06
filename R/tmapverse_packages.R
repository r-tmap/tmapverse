#' List all packages in the tmapverse
#'
#' List all packages in the tmapverse. The function `tmapverse_packages` will return a character vector of packages. The function `tmapverse_packages_versions` will also return the corresponding versions and those of the latest versions available in the specified repository.
#'
#' @param include_deps Include dependencies?
#' @param recursive If `include_deps`, should nested dependencies also be included?
#' @example ./examples/tmapverse_packages.R
#' @export
#' @return vector of package names ( `tmapverse_packages`) or a `data.frame` of version information (`tmapverse_packages_versions`)
#' @export
tmapverse_packages = function (include_deps = FALSE, recursive = FALSE)
{
	# Get direct imports from DESCRIPTION
	raw = utils::packageDescription("tmapverse")$Imports
	imports = strsplit(raw, ",")[[1]]
	parsed = gsub("^\\s+|\\s+$", "", imports)
	pkgs = vapply(strsplit(parsed, "\\s+"), "[[", 1, FUN.VALUE = character(1))

	# Include dependencies if requested
	if (include_deps) {
		# Safe dependency lookup (avoids needing CRAN mirror)
		ap = tryCatch(
			utils::available.packages(),
			error = function(e) utils::installed.packages()
		)
		deps = tools::package_dependencies(pkgs, db = ap, recursive = recursive)
		pkgs = unique(sort(c(pkgs, unlist(deps, use.names = FALSE))))
	}

	base_pkgs = c("base", "compiler", "datasets", "graphics",
				  "grDevices", "grid", "methods", "parallel", "splines",
				  "stats", "stats4", "tools", "tcltk", "utils")
	pkgs = setdiff(pkgs, base_pkgs)
	pkgs
}

#' @param repos repository
#' @rdname tmapverse_packages
#' @export
tmapverse_packages_versions = function(include_deps = FALSE, recursive = FALSE, repos = getOption("repos")) {
	pkgs = tmapverse_packages(include_deps = include_deps, recursive = recursive)

	# --- Robust CRAN-safe repo handling ---
	if (is.null(repos) || length(repos) == 0 || is.na(repos["CRAN"]) || repos["CRAN"] == "@CRAN@") {
		repos = c(CRAN = "https://cloud.r-project.org")
	}
	# --------------------------------------

	all_pkgs = tryCatch({
		utils::available.packages(repos = repos)
	}, error = function(e) {
		utils::installed.packages()
	})

	cran_version = lapply(all_pkgs[pkgs, "Version"], package_version)
	local_version = lapply(pkgs, utils::packageVersion)
	behind = mapply(`>`, cran_version, local_version)

	data.frame(
		package = pkgs,
		cran = to_version_string(cran_version),
		local = to_version_string(local_version),
		behind = behind,
		stringsAsFactors = FALSE
	)
}

to_version_string = function(x) {
	vapply(x, function(v) {
		if (inherits(v, "package_version")) {
			as.character(v)
		} else {
			paste(v, collapse = ".")
		}
	}, character(1))
}

