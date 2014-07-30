/**
 * Antiquarium Common
 */
Antiquarium.Common = {
  
  cloudinaryUpload: function() {
    // Cloudinary jQuery integration library uses jQuery File Upload widget
    // (see http://blueimp.github.io/jQuery-File-Upload/).
    // Any file input field with cloudinary-fileupload class is automatically
    // wrapped using the File Upload widget and configured for Cloudinary uploads.
    // You can further customize the configuration using .fileupload method
    // as we do below.
    $(".cloudinary-fileupload")
      .cloudinary_fileupload({
        // Uncomment the following lines to enable client side image resizing and valiation.
        // Make sure cloudinary/processing is included the js file
        //disableImageResize: false,
        //imageMaxWidth: 800,
        //imageMaxHeight: 600,
        //acceptFileTypes: /(\.|\/)(gif|jpe?g|png|bmp|ico)$/i,
        //maxFileSize: 20000000, // 20MB
        dropZone: "#direct_upload",
        start: function (e) {
          $(".status").text("Starting upload...");
        },
        progress: function (e, data) {
          $('.progress-bar').css('width', Math.round((data.loaded * 100.0) / data.total) + '%'); 
          $(".status").text("Uploading... " + Math.round((data.loaded * 100.0) / data.total) + "%");
        },
        fail: function (e, data) {
          console.log(data);
          $(".status").text("Upload failed");
        }
      })
      .off("cloudinarydone").on("cloudinarydone", function (e, data) {
        $(".status").text("Done");
        $("#new_photo").submit();
      }
    );
  },
  
  
  
  // Clickable rows
  clickable: function() {
    $("tr.clickable")
    .css('cursor', 'pointer')
    .click(function() {
      window.document.location = $(this).attr("href");
    });
  }
  
};