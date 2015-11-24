

// // Register a template definition set named "default".
CKEDITOR.addTemplates("default",
    {   
        // The name of the subfolder that contains the preview images of the templates.
        imagesPath:CKEDITOR.getUrl(CKEDITOR.plugins.getPath("templates")+"templates/images/"),

        templates:[
            { 
                title:"Recipe A",
                image:"template1.gif",
                description:"1 image, 1 set of ingredients, and 1 set of steps.",
                html:'<p class="monologue-post-intro-paragraph">Introduction paragraph can go here. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoconsequat. Duis aute irure dolor in reprehenderit in voluptate velit essecillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat nonproident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'+
                    '<div class="text-center">'+
                        '<img src=" " alt="" class="monologue-post-image-center" style="height: 100px; width:100px"/>'+
                    '</div>'+
                    '<div class="row">'+
                        '<div class="col-xs-6 monologue-post-ingredients">'+
                            '<hr>'+
                            '<h4><span class="heading">Makes:</span> 6-8 servings</h4>'+
                            '<h4><span class="heading">Total Time:</span> 45 minutes</h4>'+
                            '<hr>'+
                            '<h2 class="heading">Ingredients</h2>'+
                            '<ul>'+
                                '<li>1 Cup sugar</li>'+
                                '<li>1¼ Cup pomegranate juice (water may be substituted)</li>'+
                                '<li>1 Tbsp. julienned lemon zest  *see note</li>'+
                                '<li>1 Tbsp. julienned orange zest *see note</li>'+
                                '<li>1 Tbsp. julienned grapefruit zest *see note</li>'+ 
                                '<li>¼ Cup grapefruit segments, cut into 1” pieces + the juice</li>'+
                                '<li>¼ Orange segments cut into 1” pieces + the juice</li>'+
                                '<li>3 whole allspice berries</li>'+
                                '<li>3 whole cloves</li>'+
                                '<li>½ Cinnamon stick</li>'+
                                '<li>Pinch of salt</li>'+
                            '<ul>'+
                            '<p>Optional special equipment:  cheesecloth</p>'+
                        '</div>'+
                        '<div class="col-xs-6 monologue-post-steps">'+
                            '<h2 class="heading">Directions</h2>'+
                            '<p>Combine all the ingredients in a thick bottom pot over high heat. You may want to keep the spice separate, making it easier to extract later.  If so, combine the allspice berries and clove in a small piece of cheesecloth, tie with heat safe string and place in the sauce (the cinnamon stick is easy to remove, no need to add it to the spice satchel). Bring the pot to a boil and quickly reduce heat to low and simmer for approximately 30 minutes.  The relish should be thick and jammy almost gooey.  If your liquid is cooking off too quickly, turn down the heat and add a bit more water, incorporating ¼ cup at a time. Remove the pot from the heat, discard the spices (if you did not use cheesecloth you might have to fish around a bit), and serve at your desired temperature.</p>'+
                            '<hr>'+
                            '<p class="monologue-post-note">NOTE:  I prefer to hand cut my zest for this recipe because it looks beautiful in the bowl and delivers wonderful, small bursts of zesty citrus flavor. (Microplanes are handy but they create a muddled flavor.  If you choose to use a microplane, reduce amounts to ½ Tbsp. each citrus.)  To julienne, use a vegetable peeler to create large strips of the zest. Avoid digging into the white pith – it’s very bitter.  Stack a few slices at a time and cut the peels at an angle to create thin strips of zest, about an inch in length.</p>'+
                            '<p class="monologue-post-storage">The relish will keep for up to a week refrigerated and up to 3 weeks frozen.</p>'+
                        '</div>'+
                    '</div>',
            },
            {
                title:"Recipe B",
                image:"template1.gif",
                description:"1 image, 2 sets of ingredients, and 1 set of steps.",
                html:'<p class="monologue-post-intro-paragraph">Introduction paragraph can go here. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoconsequat. Duis aute irure dolor in reprehenderit in voluptate velit essecillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat nonproident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'+
                    '<div class="text-center">'+
                        '<img src=" " alt="" class="monologue-post-image-center" style="height: 100px; width:100px"/>'+
                    '</div>'+
                    '<div class="row">'+
                        '<div class="col-xs-6 monologue-post-ingredients">'+
                            '<hr>'+
                            '<h4><span class="heading">Makes:</span> 6-8 servings</h4>'+
                            '<h4><span class="heading">Total Time:</span> 45 minutes</h4>'+
                            '<hr>'+
                            '<h2 class="heading">Ingredients</h2>'+
                            '<h4 class="monologue-post-subcategory">Sauce</h4>'+
                            '<ul>'+
                                '<li>1 Cup sugar</li>'+
                                '<li>1¼ Cup pomegranate juice (water may be substituted)</li>'+
                                '<li>1 Tbsp. julienned lemon zest  *see note</li>'+
                                '<li>1 Tbsp. julienned orange zest *see note</li>'+
                            '</ul>'+
                            '<h4 class="monologue-post-subcategory">Main Dish</h4>'+
                            '<ul>'+
                                '<li>1 Tbsp. julienned grapefruit zest *see note</li>'+ 
                                '<li>¼ Cup grapefruit segments, cut into 1” pieces + the juice</li>'+
                                '<li>¼ Orange segments cut into 1” pieces + the juice</li>'+
                                '<li>3 whole allspice berries</li>'+
                                '<li>3 whole cloves</li>'+
                                '<li>½ Cinnamon stick</li>'+
                                '<li>Pinch of salt</li>'+
                            '<ul>'+
                            '<p>Optional special equipment:  cheesecloth</p>'+
                        '</div>'+
                        '<div class="col-xs-6 monologue-post-steps">'+
                            '<h2 class="heading">Directions</h2>'+
                            '<p>Combine all the ingredients in a thick bottom pot over high heat. You may want to keep the spice separate, making it easier to extract later.  If so, combine the allspice berries and clove in a small piece of cheesecloth, tie with heat safe string and place in the sauce (the cinnamon stick is easy to remove, no need to add it to the spice satchel). Bring the pot to a boil and quickly reduce heat to low and simmer for approximately 30 minutes.  The relish should be thick and jammy almost gooey.  If your liquid is cooking off too quickly, turn down the heat and add a bit more water, incorporating ¼ cup at a time. Remove the pot from the heat, discard the spices (if you did not use cheesecloth you might have to fish around a bit), and serve at your desired temperature.</p>'+
                            '<hr>'+
                            '<p class="monologue-post-note">NOTE:  I prefer to hand cut my zest for this recipe because it looks beautiful in the bowl and delivers wonderful, small bursts of zesty citrus flavor. (Microplanes are handy but they create a muddled flavor.  If you choose to use a microplane, reduce amounts to ½ Tbsp. each citrus.)  To julienne, use a vegetable peeler to create large strips of the zest. Avoid digging into the white pith – it’s very bitter.  Stack a few slices at a time and cut the peels at an angle to create thin strips of zest, about an inch in length.</p>'+
                            '<p class="monologue-post-storage">The relish will keep for up to a week refrigerated and up to 3 weeks frozen.</p>'+
                        '</div>'+
                    '</div>',
            },
            {
                title:"Recipe C",
                image:"template1.gif",
                description:"1 image, 2 sets of ingredients, and 2 sets of steps.",
                html:'<p class="monologue-post-intro-paragraph">Introduction paragraph can go here. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoconsequat. Duis aute irure dolor in reprehenderit in voluptate velit essecillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat nonproident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>'+
                    '<div class="text-center">'+
                        '<img src=" " alt="" class="monologue-post-image-center" style="height: 100px; width:100px"/>'+
                    '</div>'+
                    '<div class="row">'+
                        '<div class="col-xs-6 monologue-post-ingredients">'+
                            '<hr>'+
                            '<h4><span class="heading">Makes:</span> 6-8 servings</h4>'+
                            '<h4><span class="heading">Total Time:</span> 45 minutes</h4>'+
                            '<hr>'+
                            '<h2 class="heading">Ingredients</h2>'+
                            '<h4 class="monologue-post-subcategory">Sauce</h4>'+
                            '<ul>'+
                                '<li>1 Cup sugar</li>'+
                                '<li>1¼ Cup pomegranate juice (water may be substituted)</li>'+
                                '<li>1 Tbsp. julienned lemon zest  *see note</li>'+
                                '<li>1 Tbsp. julienned orange zest *see note</li>'+
                            '</ul>'+
                            '<h4 class="monologue-post-subcategory">Main Dish</h4>'+
                            '<ul>'+
                                '<li>1 Tbsp. julienned grapefruit zest *see note</li>'+ 
                                '<li>¼ Cup grapefruit segments, cut into 1” pieces + the juice</li>'+
                                '<li>¼ Orange segments cut into 1” pieces + the juice</li>'+
                                '<li>3 whole allspice berries</li>'+
                                '<li>3 whole cloves</li>'+
                                '<li>½ Cinnamon stick</li>'+
                                '<li>Pinch of salt</li>'+
                            '<ul>'+
                            '<p>Optional special equipment:  cheesecloth</p>'+
                        '</div>'+
                        '<div class="col-xs-6 monologue-post-steps">'+
                            '<h2 class="heading">Directions</h2>'+
                            '<h4 class="monologue-post-subcategory">Sauce</h4>'+
                            '<p>Combine all the ingredients in a thick bottom pot over high heat. You may want to keep the spice separate, making it easier to extract later.  If so, combine the allspice berries and clove in a small piece of cheesecloth, tie with heat safe string and place in the sauce (the cinnamon stick is easy to remove, no need to add it to the spice satchel). Bring the pot to a boil and quickly reduce heat to low and simmer for approximately 30 minutes.  The relish should be thick and jammy almost gooey.  If your liquid is cooking off too quickly, turn down the heat and add a bit more water, incorporating ¼ cup at a time. Remove the pot from the heat, discard the spices (if you did not use cheesecloth you might have to fish around a bit), and serve at your desired temperature.</p>'+
                            '<h4 class="monologue-post-subcategory">Main Dish</h4>'+
                            '<p>Combine all the ingredients in a thick bottom pot over high heat. You may want to keep the spice separate, making it easier to extract later.  If so, combine the allspice berries and clove in a small piece of cheesecloth, tie with heat safe string and place in the sauce (the cinnamon stick is easy to remove, no need to add it to the spice satchel). Bring the pot to a boil and quickly reduce heat to low and simmer for approximately 30 minutes.  The relish should be thick and jammy almost gooey.  If your liquid is cooking off too quickly, turn down the heat and add a bit more water, incorporating ¼ cup at a time. Remove the pot from the heat, discard the spices (if you did not use cheesecloth you might have to fish around a bit), and serve at your desired temperature.</p>'+
                            '<hr>'+
                            '<p class="monologue-post-note">NOTE:  I prefer to hand cut my zest for this recipe because it looks beautiful in the bowl and delivers wonderful, small bursts of zesty citrus flavor. (Microplanes are handy but they create a muddled flavor.  If you choose to use a microplane, reduce amounts to ½ Tbsp. each citrus.)  To julienne, use a vegetable peeler to create large strips of the zest. Avoid digging into the white pith – it’s very bitter.  Stack a few slices at a time and cut the peels at an angle to create thin strips of zest, about an inch in length.</p>'+
                            '<p class="monologue-post-storage">The relish will keep for up to a week refrigerated and up to 3 weeks frozen.</p>'+
                        '</div>'+
                    '</div>',
            },
            // {
            //     title:"Article",
            //     image:"template2.gif",
            //     description:"A template that defines two colums, each one with a title, and some text.",
            //     html:'<table cellspacing="0" cellpadding="0" style="width:100%" border="0"><tr><td style="width:50%"><h3>Title 1</h3></td><td></td><td style="width:50%"><h3>Title 2</h3></td></tr><tr><td>Text 1</td><td></td><td>Text 2</td></tr></table><p>More text goes here.</p>'
            // },
            // {
            //     title:"Text and Table",
            //     image:"template3.gif",
            //     description:"A title with some text and a table.",
            //     html:'<div style="width: 80%"><h3>Title goes here</h3><table style="width:150px;float: right" cellspacing="0" cellpadding="0" border="1"><caption style="border:solid 1px black"><strong>Table title</strong></caption><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></table><p>Type the text here</p></div>'
            // }
        ]
    }
);