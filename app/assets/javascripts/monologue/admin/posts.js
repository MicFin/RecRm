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
                           var val = $.fn.dataTable.util.escapeRegex(
                               $(this).val()
                           );

                           column
                               .search( val ? '^'+val+'$' : '', true, false )
                               .draw();
                       } );
                   column.data().unique().sort().each( function ( d, j ) {
                       select.append( '<option value="'+d+'">'+d+'</option>' )
                   } );
               } );
            }
         });

         // Get dynamic num of columns
         var numColumns = table.columns()[0].length;
         var hideColumnLink, columnTitle;

         // Loop through all columns
         for (var i = 0, l = numColumns; i < l; i++ ) {
         // Create Links to hide columns
         columnTitle = $(table.columns( i ).header()).text();
         hideColumnLink = i === l - 1 || i === 9 ? '<a class="toggle-vis" data-column="'+i+'">'+columnTitle+'</a>' : '<a class="toggle-vis" data-column="'+i+'">'+columnTitle+'</a> - ';
         // append links to hide columns and hide tag columns to start
         if ( i > 10) {
           if (columnTitle !== "") {
             $('.hide-tag-columns').append(hideColumnLink);
           }
           table.column(i).visible(false);
         } else {
           if (columnTitle !== "") {
             $('.hide-general-columns').append(hideColumnLink);
           }
           $("a[data-column='" + i + "']").addClass("visible-column");
         }
         };

         // Create link to show all tag columns
         $(".show-all-tags").on("click", function(e){
            e.preventDefault();
            for (var i = 11, l = numColumns; i < l; i++ ) {
              table.column(i).visible(true);  
              $("a[data-column='" + i + "']").addClass("visible-column");
            }
            $(".show-all-tags, .hide-all-tags").toggleClass("hidden");

         });

         // Create link to hide all tag columns
         $(".hide-all-tags").on("click", function(e){
            e.preventDefault();
            for (var i = 11, l = numColumns; i < l; i++ ) {
              table.column(i).visible(false);  
              $("a[data-column='" + i + "']").removeClass("visible-column");
            }
            $(".hide-all-tags, .show-all-tags").toggleClass("hidden");  
         });

         // When links are clicked then toggle column
         $('a.toggle-vis').on( 'click', function (e) {
           e.preventDefault();
           // Get the column API object
           var column = table.column( $(this).attr('data-column') );
           // Toggle the visibility
           column.visible( ! column.visible() );
           // Toggle link color
           $(this).toggleClass("visible-column");
         });

         // Show table
         $(".datatable").removeClass("hidden");
      }
   }   
   
   // initialize preview.
   preview.init("[data-toggle='post-preview']");

   // initialize table
   setTable.init();




})