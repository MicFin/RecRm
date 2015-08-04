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
	// // IE 8 and below
	// {
	// 	test: Modernizr.backgroundsize,
	// 	yep: ['/assets/stylesheets/partials/browser_specific/background-size.min.htc']
	// },
	// IE 9 and below
	{
		test: Modernizr.cssgradients,
		nope: [
			'/assets/browser_specific/polyfills/selectivizr.js', 
			"/assets/stylesheets/modules/bootstrap/bootstrap_overrides/ie7.css", 
			"/assets/stylesheets/modules/bootstrap/bootstrap_overrides/css3pie.css", 
			'/assets/browser_specific/polyfills/PIE.js'
		]
	}
]);