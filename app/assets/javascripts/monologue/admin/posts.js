$(document).ready (function(){


  var preview = {
      el: null,
      
      // initialize - bind events, etc.
      init: function(selector) {
         this.el = $(selector);
         if (this.el.length == 0) { return;}
         $(this.el.attr("data-trigger")).click(this, this.open);
         this.el.find("[data-dismiss='post-preview']").click(this, this.close);
      },
      
      // open preview
      open: function(e) {
         var el = e.data.el;
         var iframe = el.find("iframe")[0];
         if(iframe.contentDocument){
            var doc = iframe.contentDocument;
         }
         else if(iframe.contentWindow){
            var doc = iframe.contentWindow.document;
         } else {
            var doc = iframe.document;
         }

         $("#post_content").val(CKEDITOR.instances["post_content"].getData()); // update textarea with CKEDITOR content.
         $.post(el.attr("data-url"), $("form").serialize(), function(data) {
            doc.open();
            doc.writeln(data);
            doc.close();
            $(doc).keydown(e.data, e.data.keydown);   
         });

         // show preview & hide scrollbars
         el.toggleClass("hide");
         $("body").attr("style", "overflow:hidden;");

         // look for esc
         $(document).on("keydown.post-preview", e.data, e.data.keydown);
      },
      
      // close preview on esc key.
      keydown: function(e) {
         if (e.keyCode==27) {
            e.data.close();
         }
      },
      
      // close preview
      close: function(e) {
         var el = (e==undefined)? this.el: e.data.el;
         el.toggleClass("hide");
         $("body").attr("style", "overflow:auto;");
         $(document).off("keydown.post-preview");
      }
  }
  var setTable = {
    init: function(){

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
   
  // initialize preview.
  preview.init("[data-toggle='post-preview']");

  // initialize table
  setTable.init();


})