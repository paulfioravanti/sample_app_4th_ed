$(document).ready(function() {
  if ($("#micropost_picture").length) {
    $("#micropost_picture").bind("change", function() {
      var sizeInMegabytes = this.files[0].size / 1024 / 1024;

      if (sizeInMegabytes > 5) {
        var errorMessage =
          $("<div>", { class: "error-explanation" }).append(
            $("<div>", {
              class: "alert alert-danger",
              text: "Maximum file size is 5MB. Please choose a smaller file."
            })
          );
        $(".new_micropost").prepend(errorMessage);
      }
    });
  }
});
