$(function() {

//    Full configuation can be found under  http://docs.cksource.com/CKEditor_3.x/Developers_Guide/Toolbar
    CKEDITOR.config.toolbar = 'Basic';
    CKEDITOR.config.toolbar_Basic =
    [
    	{ name: 'document', items : [ 'Source', 'Templates' ] },
        // { name: 'document', items : [ 'Source','-','Save','NewPage','DocProps','Preview','Print','-','Templates' ] },
        // { name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
    	{ name: 'editing', items : [ 'SpellChecker', 'Scayt' ] },
        // { name: 'editing', items : [ 'Find','Replace','-','SelectAll','-','SpellChecker', 'Scayt' ] },
    	{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
    	{ name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote',
    	'-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] },
        // { name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv',
        // '-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] },
    	{ name: 'links', items : [ 'Link','Unlink','Anchor' ] },
        '/',
    	{ name: 'insert', items : [ 'Image','Table','SpecialChar','PageBreak', 'HorizontalRule'] },
        // { name: 'insert', items : [ 'Image','Table','HorizontalRule','Smiley','SpecialChar','PageBreak','Iframe' ] },
    	{ name: 'styles', items : [ 'Styles','Format','Font','FontSize' ] },
    	{ name: 'colors', items : [ 'TextColor','BGColor' ] },
    	{ name: 'tools', items : [ 'Maximize'] }
        // { name: 'tools', items : [ 'Maximize', 'ShowBlocks' ] }
    ];

    CKEDITOR.config.extraAllowedContent = 'div(*); p(monologue-post-intro-paragraph,heading,monologue-post-note,monologue-post-storage); img(monologue-post-image-center); h2(heading); h4(monologue-post-subcategory); span(heading); ul(list-item)';
   // CKEDITOR.config.extraAllowedContent = 'div(*)';

    CKEDITOR.config.templates_files = [ '/assets/monologue/admin/monologue_templates.js' ];
    // CKEDITOR.loadTemplates(CKEDITOR.config.templates_files,'')
    // CKEDITOR.loadTemplates(CKEDITOR.config.templates_files, '');
    //     var ck = CKEDITOR.replace('cke_contents', {               
    //         on: {
    //              instanceReady: function (ev) {                       
    //                 var insert = CKEDITOR.getTemplates('default');
    //                 this.setData(insert.templates[0].html);
    //             }
    //         }
    //     });
    CKEDITOR.config.extraPlugins = 'notification,wordcount,tableresize,autogrow';

});