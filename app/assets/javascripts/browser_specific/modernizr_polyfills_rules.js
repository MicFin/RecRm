Modernizr.load([
	// placeholders
	{
  	test: Modernizr.placeholder,
  	nope: ['/assets/browser_specific/polyfills/placeholder.min.js']
	},
	// media queries
	{
  	test: Modernizr.mq('only all'),
  	nope: ['/assets/browser_specific/polyfills/respond.min.js']
	},
	// IE 9 and below
	{
		test: Modernizr.cssgradients,
		nope: [
			'/assets/browser_specific/polyfills/selectivizr.js', 
			"/assets/modules/bootstrap/bootstrap_overrides/ie7.css", 
			"/assets/modules/bootstrap/bootstrap_overrides/css3pie.css", 
			'/assets/browser_specific/polyfills/PIE.js'
		]
	}
]);