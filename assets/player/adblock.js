

"use strict";


// Remove ads and bloat html elements
[
	".adsBox",
	".afs_ads",
	".ad-placement",
	"a",
	"body > script",
].forEach(
	sel => document.querySelectorAll(sel).forEach(
		el => el?.remove()
	)
);
