import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["preview", "previewpano"];

  connect() {
    console.log("Stimulus preview image controller connected.");
  }

  preview(event) {
    console.log("call fonction preview");

    const input = event.target;
    const previewContainer = this.previewTarget;

    previewContainer.innerHTML = ""; // Clear previous contents

    if (input.files && input.files[0]) {
      const reader = new FileReader();
      reader.onload = function (e) {
        const img = document.createElement("img");
        img.src = e.target.result;
        previewContainer.appendChild(img);
        img.classList.add("profile-pic");
      };
      reader.readAsDataURL(input.files[0]);
    } else {
      const placeholder = document.createElement("span");
      placeholder.classList.add("placeholder");
      placeholder.textContent = "No Image Selected";
      previewContainer.appendChild(placeholder);
    }
  }

  previewpano(event) {
    console.log("call fonction preview pano");

    const input = event.target;
    const previewContainer = this.previewpanoTarget;

    previewContainer.innerHTML = ""; // Clear previous contents

    if (input.files && input.files[0]) {
      const reader = new FileReader();
      reader.onload = function (e) {
        const img = document.createElement("img");
        img.src = e.target.result;
        previewContainer.appendChild(img);
        img.classList.add("panorama-img");
        img.classList.add("custom-rounded");

      };
      reader.readAsDataURL(input.files[0]);
    } else {
      const placeholder = document.createElement("span");
     // placeholder.classList.add("placeholder");
      placeholder.textContent = "No Image Selected";
      previewContainer.appendChild(placeholder);
    }
  }


}
