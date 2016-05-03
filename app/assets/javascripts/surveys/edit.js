

Kindrdfood = Kindrdfood || {};

Kindrdfood.surveys = Kindrdfood.surveys || {};

Kindrdfood.surveys.edit = {

	init: function(){
	  var groupName = $("#survey-questions-container").data("survey-group");
	  if (groupName === "Client - Pre Appointment" ){ 

			// validate forms
			Kindrdfood.formValidations.growthEntries.clientForm();
			Kindrdfood.formValidations.foodDiaryEntries.init();
			Kindrdfood.formValidations.surveys.openResponse();
			Kindrdfood.dateTimePickers.dateTimePicker.init();

		} else if (groupName ===  "Dietitian - Pre Appointment" ){ 

			 Kindrdfood.formValidations.growthEntries.dietitianForm();
			 Kindrdfood.formValidations.surveys.openResponse();

		} else if (groupName === "Client - Assessment"){

			Kindrdfood.formValidations.surveys.openResponse();

	    // Create table
	    var table = $(".datatable").DataTable({

	      // select filter on footer
	      initComplete: function () {
	        this.api().columns().every( function () {
	          var column = this;
	          var select = $('<select><option value=""></option></select>')
	            .appendTo( $(column.footer()).empty() )
	            .on( 'change', function () {
	              var val = $.fn.dataTable.util.escapeRegex( $(this).val() );
	              column
	              .search( val ? '^'+val+'$' : '', true, false )
	              .draw();
	            });
	          column.data().unique().sort().each( function ( d, j ) {
	            select.append( '<option value="'+d+'">'+d+'</option>' )
	          });
	        });
	      }
	    });

	    // Get dynamic num of columns in entire table
	    var numColumns = table.columns()[0].length, objectOfCategories = {};
	    var hideColumnLink, columnTitle, tagCategory, contentType, showColumnBoolean;

	    // Loop through all columns to get the tag-categories
	    for (var i = 0, l = numColumns; i < l; i++ ) {
	      tagCategory = $(table.columns( i ).footer()).attr("data-tag-category");
	      contentType = $(table.columns( i ).footer()).attr("data-content-type");
	      showColumnBoolean = (tagCategory === "basic_info");

	      // if tagCategory key has not been added to object 
	      if ( tagCategory && !objectOfCategories.hasOwnProperty(tagCategory) ) {

	        // then add colunID to object 
	        objectOfCategories[tagCategory] = [i];

	        // and add link to screen
	        hideColumnLink = '<a class="toggle-vis" data-tag-category="'+tagCategory+'">'+tagCategory.toUpperCase().split('_').join(' ')+'</a> | ';

	        if ( contentType === "recipe") {
	          $('.hide-recipe-columns').append(hideColumnLink);
	        } else if ( contentType === "article") {
	          $('.hide-article-columns').append(hideColumnLink);
	        } else {
	          $('.hide-general-columns').append(hideColumnLink);
	        }
	        table.column(i).visible(showColumnBoolean);
	      // if tagCategory key has been added
	      } else if (tagCategory) {

	        // then add columnID to object
	        objectOfCategories[tagCategory].push(i); 
	        table.column(i).visible(showColumnBoolean);           
	      }
	    };

	    $(".toggle-vis").on("click", function(e){
	      e.preventDefault();
	      var $link = $(this);
	      var categoryName = $link.attr("data-tag-category");
	      var arrayOfColumnIds = objectOfCategories[categoryName];

	      if ( $link.hasClass("visible-column") ) {
	        $link.removeClass("visible-column");
	        arrayOfColumnIds.forEach(function(columnId){
	          table.column(columnId).visible(false);
	        });

	      } else {
	        $link.addClass("visible-column");
	        arrayOfColumnIds.forEach(function(columnId){
	          table.column(columnId).visible(true);
	        });
	      }
	    })

	    // Show table
	    $(".datatable").removeClass("hidden");

		}

	}
}	