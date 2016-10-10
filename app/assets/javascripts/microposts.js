$(document).ready(function() {
  if ($("#micropost_picture").length) {
    $("#micropost_picture").bind("change", function() {
      var size_in_megabytes = this.files[0].size / 1024 / 1024;

      if (size_in_megabytes > 5) {
        $(".new_micropost").prepend(
          $("<div>", { class: "error-explanation" }).append(
            $("<div>", {
              class: "alert alert-danger",
              text: "Maximum file size is 5MB. Please choose a smaller file."
            })
          )
        );
      }
    });
  }
});
